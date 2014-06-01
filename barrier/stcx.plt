set title "Performance counter"
set xlabel "Processor number"
set ylabel "Counter value"

#This is scale
set size 1,1

set key 10,1680

set xtics 2,2,32
set ytics 100,200,1800

set grid noxtics ytics

#set logscale x 2
#set logscale y 2

set terminal postscript eps color "Times-Roman" 18
#set terminal postscript default color "Times-Roman" 10

plot [0:33] [0:1800] \
           '-'  using 1:2 title "PASS" w linespoints 7 1, \
           '-'  using 1:3 title "FAIL" w linespoints 7 2

#pause -1 "Hit return to continue"

THDS    PASS   FAIL   
02      766.551  44.751  
04      647.442  233.965 
06      607.953  433.068
08      583.269  554.863
10      560.950  705.871 
12      560.900  839.596
14      554.222  980.753
16      549.166  1100.867
18      545.259  1184.639
20      541.713  1261.214 
22      539.013  1342.863
24      536.596  1416.315
26      534.672  1494.287
28      533.111  1568.670
30      531.560  1642.486 
32      530.345  1715.924
e
THDS    PASS   FAIL   
02      766.551  44.751  
04      647.442  233.965 
06      607.953  433.068
08      583.269  554.863
10      560.950  705.871 
12      560.900  839.596
14      554.222  980.753
16      549.166  1100.867
18      545.259  1184.639
20      541.713  1261.214 
22      539.013  1342.863
24      536.596  1416.315
26      534.672  1494.287
28      533.111  1568.670
30      531.560  1642.486 
32      530.345  1715.924
e
