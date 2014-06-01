set title "Performance counter"
set xlabel "Processor number"
set ylabel "Counter value (in thousand)"

#This is scale
set size 1,1

set key 10,8000

set xtics 2,2,32
set ytics 1000,1000,9000

set grid noxtics ytics

#set logscale x 2
#set logscale y 2

set terminal postscript eps color "Times-Roman" 18
#set terminal postscript default color "Times-Roman" 10

plot [0:33] [0:9000] \
           '-'  using 1:2 title "DistCounter" w linespoints 7 1, \
           '-'  using 1:2 title "DistCounterPad" w linespoints 7 2

#pause -1 "Hit return to continue"

THDS    miss   
02      593.710
04      1597.595
06      2405.790
08      2780.939
10      3170.871
12      3520.941
14      3772.861
16      3997.608
18      3702.792
20      3415.641
22      3267.130
24      3082.786
26      2953.098
28      2864.011
30      2754.718
32      2678.151
e
THDS    miss
02      1126.538
04      3274.243
06      5161.984
08      6203.508
10      6872.196
12      7450.386
14      7857.795
16      8306.680
18      7646.408
20      7055.372 
22      6772.184
24      6365.584
26      6130.058
28      6311.486
30      6299.363 
32      5987/737
e
