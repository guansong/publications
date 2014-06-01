      program bt_mz
! ... This version uses the 'ONTHREADS' construct from the SUBTEAM proposal
! ... by B. Chapman et al.
      integer, parameter :: num_zones=4, nz=40, niter=200
      integer, parameter :: p_size=16000, max_threads=256
      integer, dimension(num_zones) :: nxy, start
      double precision, dimension(p_size) :: u, rhs, erhs
      double precision, dimension(2*nz*num_zones) :: qbc
      integer nt_groups, z_group_id(num_zones)
      integer group_subid(max_threads)
      integer zone, step, mgid, subteam

! ... nt_groups (<= num_zones) is the number of thread groups,
! ... which is the number of threads used for the outer (1st) level
      read(*,*) nt_groups

! ... fill up arrays nxy,start for the current problem size
      call setup(num_zones, p_size, nxy, nz, start)

! ... balance load by first assigning different zones to each thread group
! ... and recording the result to 'z_group_id', then figuring out the 
! ... number of threads within each thread group for the inner-level 
! ... parallelism and recording group (subteam) id to 'group_subid'
      call map_zones(num_zones, nxy, nz, nt_groups, 
     &               z_group_id, group_subid)

!$OMP PARALLEL PRIVATE(zone,step,mgid,subteam)
      mgid = group_subid(omp_get_thread_num() + 1)
      subteam = omp_create_subteam(group_subid, mgid)

! ... initialize solution
!$OMP ONTHREADS(SUBTEAM)
      do zone = 1, num_zones
         if (z_group_id(zone) == mgid) then
            call initialize(u(start(zone)), erhs(start(zone)), 
     &                      nxy(zone), nz)
         endif
      enddo
!$OMP END ONTHREADS

! ... time step loop
      do  step = 1, niter

! ... exchange boundary condition
         call exch_qbc(u, qbc, num_zones, nxy, nz, start)

! ... perform adi solver
!$OMP ONTHREADS(SUBTEAM)
         do zone = 1, num_zones
            if (z_group_id(zone) == mgid) then
               call solver(u(start(zone)), rhs(start(zone)), 
     &                     erhs(start(zone)), nxy(zone), nz)
            endif
         enddo
!$OMP END ONTHREADS

      enddo
!$OMP END PARALLEL

! ... verify results
      call verify(u, rhs, num_zones, nxy, nz)

      end

      subroutine setup(num_zones, p_size, nxy, nz, start)
      integer num_zones, p_size, nxy(*), nz, start(*)
      integer zone
      nxy(1) = 50
      nxy(2) = 100
      nxy(3) = 200
      nxy(4) = p_size/nz - nx(1) - nxy(2) - nxy(3)
      start(1) = 1
      do zone = 2, num_zones
         start(zone) = start(zone-1) + nxy(zone-1)*nz
      enddo
      return
      end

      subroutine initialize(u, erhs, nxy, nz)
      integer nxy, nz
      double precision u(nxy,*), erhs(nxy,*)
      integer k, ij

!$OMP DO
      do k = 1, nz
         u(:,k) = 0.0
         do ij = 1, nxy
            erhs(ij,k) = 0.5 * (ij + k)
         enddo
      enddo
!$OMP END DO

      return
      end

      subroutine solver(u, rhs, erhs, nxy, nz)
      integer nxy, nz
      double precision u(nxy,*), rhs(nxy,*), erhs(nxy,*)
      integer k

!$OMP DO
      do k = 2, nz-1
         rhs(:,k) = erhs(:,k) - 2.0*u(:,k) + (u(:,k-1) - u(:,k+1))*0.5
      enddo
!$OMP END DO

!$OMP DO
      do k = 2, nz-1
         u(:,k) = u(:,k) + rhs(:,k)
      enddo
!$OMP END DO

      return
      end

      subroutine exch_qbc(u, qbc, num_zones, nxy, nz, start)
      integer num_zones, nxy(*), nz, start(*)
      double precision u(*), qbc(2*nz,*)
      integer zone, zp, zm

!$OMP DO
      do zone = 1, num_zones
         call copy_face(u(start(zone)), qbc(1,zone), nxy(zone), nz, 1)
      enddo
!$OMP END DO
!$OMP DO
      do zone = 1, num_zones
         zp = mod(zone, num_zones) + 1
         zm = mod(zone-2+num_zones, num_zones) + 1
         call copy_face(u(start(zone)), qbc(1,zp), nxy(zone), nz, 2)
         call copy_face(u(start(zone)), qbc(1,zm), nxy(zone), nz, 3)
      enddo
!$OMP END DO

      return
      end

      subroutine copy_face(u, qbc, nxy, nz, idir)
      integer nxy, nz, idir
      double precision u(nxy,*), qbc(nz,*)

      if (idir == 1) then
         do k=1,nz
            qbc(k,1) = u(1,k)
            qbc(k,2) = u(nxy,k)
         enddo
      else if (idir == 2) then
         do k=1,nz
            u(nxy,k) = qbc(k,1)
         enddo
      else if (idir == 3) then
         do k=1,nz
            u(1,k) = qbc(k,2)
         enddo
      endif

      return
      end
