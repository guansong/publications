set title "Barrier overhead"
set xlabel "Processor number"
set ylabel "Time(us)"

#This is scale
set size 1,1

set key 6,140

set xtics 2,2,17
set ytics 0,10,150

set grid noxtics ytics

#set logscale x 2
#set logscale y 2

set terminal postscript eps color "Times-Roman" 18
#set terminal postscript default color "Times-Roman" 10

plot [1:17] [0:150] \
           '-'  using 1:2 title "FetchAndAdd" w linespoints 7 1, \
           '-'  using 1:3 title "DistCounter" w linespoints 7 2, \
           '-'  using 1:4 title "DistCounterPad" w linespoints 7 3, \
           '-'  using 1:5 title "LocalSensor" w linespoints 7 4, \
           '-'  using 1:6 title "Combined" w linespoints 7 5 

#pause -1 "Hit return to continue"


THDS    Fetch   DistC   PDistC  LocS    Combined
02      4.47    3.02    3.62    3.96    4.16
04      8.70    7.64    9.18    9.28    6.96   
06      17.94   14.20   13.74   13.16   11.24
08      28.32   25.48   17.46   18.94   11.86
10      49.16   43.04   21.72   28.00   14.04
12      74.08   65.76   25.78   41.00   15.26
14      102.80  90.70   30.72   57.20   16.76   
16      141.64  121.46  35.88   77.18   19.18
e
THDS    Fetch   DistC   PDistC  LocS    Combined
02      4.47    3.02    3.62    3.96    4.16
04      8.70    7.64    9.18    9.28    6.96   
06      17.94   14.20   13.74   13.16   11.24
08      28.32   25.48   17.46   18.94   11.86
10      49.16   43.04   21.72   28.00   14.04
12      74.08   65.76   25.78   41.00   15.26
14      102.80  90.70   30.72   57.20   16.76   
16      141.64  121.46  35.88   77.18   19.18
e
THDS    Fetch   DistC   PDistC  LocS    Combined
02      4.47    3.02    3.62    3.96    4.16
04      8.70    7.64    9.18    9.28    6.96
06      17.94   14.20   13.74   13.16   11.24
08      28.32   25.48   17.46   18.94   11.86
10      49.16   43.04   21.72   28.00   14.04
12      74.08   65.76   25.78   41.00   15.26
14      102.80  90.70   30.72   57.20   16.76
16      141.64  121.46  35.88   77.18   19.18
e
THDS    Fetch   DistC   PDistC  LocS    Combined
02      4.47    3.02    3.62    3.96    4.16
04      8.70    7.64    9.18    9.28    6.96
06      17.94   14.20   13.74   13.16   11.24
08      28.32   25.48   17.46   18.94   11.86
10      49.16   43.04   21.72   28.00   14.04
12      74.08   65.76   25.78   41.00   15.26
14      102.80  90.70   30.72   57.20   16.76
16      141.64  121.46  35.88   77.18   19.18
e
THDS    Fetch   DistC   PDistC  LocS    Combined
02      4.47    3.02    3.62    3.96    4.16
04      8.70    7.64    9.18    9.28    6.96
06      17.94   14.20   13.74   13.16   11.24
08      28.32   25.48   17.46   18.94   11.86
10      49.16   43.04   21.72   28.00   14.04
12      74.08   65.76   25.78   41.00   15.26
14      102.80  90.70   30.72   57.20   16.76
16      141.64  121.46  35.88   77.18   19.18
e

