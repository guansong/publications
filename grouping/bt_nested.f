       program BT
c---------------------------------------------------------------------

       include  'header.h'
      
       integer IMAX, JMAX, KMAX, num_zones
       parameter (IMAX=gx_size+x_zones,JMAX=gy_size,KMAX=gz_size)
       parameter (num_zones=x_zones*y_zones)

       integer nx(num_zones), nxmax(num_zones), ny(num_zones), 
     $         nz(num_zones), start1(num_zones), start5(num_zones),
     $         qstart_west (num_zones), qstart_east (num_zones),
     $         qstart_south(num_zones), qstart_north(num_zones)

       integer ios
       integer lcpu, lid
       character envstr*80

       double precision 
     >   u       (5*IMAX*JMAX*KMAX),
     >   us      (  IMAX*JMAX*KMAX),
     >   vs      (  IMAX*JMAX*KMAX),
     >   ws      (  IMAX*JMAX*KMAX),
     >   qs      (  IMAX*JMAX*KMAX),
     >   rho_i   (  IMAX*JMAX*KMAX),
     >   square  (  IMAX*JMAX*KMAX),
     >   rhs     (5*IMAX*JMAX*KMAX),

       common /thr_mapping/ num_groups, proc_zone_id, proc_num_threads
       common /fields/  u, us, vs, ws, qs, rho_i, square, 
     >                 rhs

       integer i, niter, step, fstatus, n3, zone
       double precision navg, mflops

      integer whoami
      integer num_groups
      integer proc_zone_id(num_zones), proc_num_threads(num_groups)

      integer omp_get_thread_num
      external omp_get_thread_num
      integer omp_get_max_threads
      external omp_get_max_threads
C
CCC  
CCC    The user determines the number of outer parallel regions
CCC    by setting an envrionment variable, .i.e. NTH_NUM_GROUPS
C
       call getenv('NTH_NUM_GROUPS', envstr)
       num_groups = value_of_envstr
       print *, 'Number of groups at the outer level = ', num_groups

       call map_zones(num_zones, nx, ny, nz)

       do  step = 1, niter

C
CCC   This is using the extension to the NUM_THREADS clause as proposed
CCC   under issue 19. The keyword STATIC indicates that the scheduling of
CCC   work is known in advance for the whole duration of the parallel
CCC   region. The second argument "num_groups" defines how many threads should
CCC   be working on the outer level. The 3rd argument, array "proc_num_threads"
CCC   which was determined in map_zones, defines the team composition for the
CCC   inner parallel regions.
C
C$OMP PARALLEL PRIVATE(whoami,zone) NUM_THREADS(STATIC,num_groups,proc_num_threads)
       whoami=omp_get_thread_num()
       do zone = 1, num_zones
         if (whoami .eq. proc_zone_id(zone)) then
           call solver (rhs(start5(zone)),  
     $              u(start5(zone)), 
     $              nx(zone), nxmax(zone), ny(zone), nz(zone))
           end if
         end do
C$OMP END PARALLEL

       end do
       
       call verify_results() 
       call print_results() 

       end


==========================================================================
      subroutine solver(rhs, u, nx, nxmax, ny, nz)
      integer num_groups
      integer proc_zone_id(num_zones), proc_num_threads(num_zones)
C
CCC   This is the inner parallel region.
CCC   Note that the thread team composition does not have to be passed
CCC   to this routine. It also no problem to call the routine outside
CCC   of an outer parallel region.
C
!$OMP PARALLEL DEFAULT(SHARED) PRIVATE(isize)
      isize = nx-1
!$OMP DO
      do k = 1, nz-2
         do j = 1, ny-2
            do i=1,isize-1
               u (i, j, k) = u(i, j, k) + rhs (i-1,j,k) + rhs (i+1,j,k)
                                        + rhs (i,j-1,k) + rhs (i,j+1,k)
                                        + rhs (i,j,k-1) + rhs (i,j,k+1)
            end do
         enddo
      enddo
!$OMP END DO nowait
!$OMP END PARALLEL
      return
      end

==========================================================================

      subroutine map_zones(num_zones, nx, ny, nz)
      include 'header.h'
      integer num_groups, num_zones, nx(*), ny(*), nz(*)
      integer proc_zone_id(num_zones), proc_num_threads(num_groups)
      common /thr_mapping/ num_groups, proc_zone_id, proc_num_threads

CCC  
CCC   Initially, the same number of threads is assigned to each outer
CCC   parallel region
C
      num_threads = omp_get_max_threads() / num_groups
C    
CCC   First step of load balancing
CCC   balannce_load_outer_level: If there are more zones
CCC   than outer parallel regions the zones are assigned
CCC   to the outer parallel regions with respect to their
CCC   computational workload. For example two small zones are
CCC   assigned to outer region 0, one big zone to outer region 1.
CCC   The array proc_zone_id defines the mapping of zones to
CCC   outer parallel region.
C
      call balannce_load_outer_level (p_index)
      do iz = 1, num_zones
          proc_zone_id (i) = p_index (iz)
      end do
C
CCC   Second step of load balancing:
CCC   In some cases it is not possible to achieve perfect load-balance
CCC   on the outer level.
CCC   Once the zones are mapped onto the outer regions, the number of
CCC   threads for the inner level is determined, again based on 
CCC   computational workload.
CCC 

      call balance_load_inner_level_(num_threads_new)
      do ip = 1, num_groups
		    proc_num_threads(ip) = num_threads_new
      end do
      return
      end
