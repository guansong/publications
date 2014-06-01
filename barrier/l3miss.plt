set title "L3 Misses"
set xlabel "Processor number"
set ylabel "Miss"

#This is scale
set size 1,1

set key 14,850

set xtics 8,8,32
set ytics 100,100,1000

set grid noxtics ytics

#set logscale x 2
#set logscale y 2

set terminal postscript eps color "Times-Roman" 18
#set terminal postscript default color "Times-Roman" 10

plot [6:33] [0:900] \
           '-'  using 1:2 title "FetchAndAdd" w linespoints 7 1, \
           '-'  using 1:3 title "DistCounter" w linespoints 7 2, \
           '-'  using 1:4 title "DistCounterPad" w linespoints 7 3, \
           '-'  using 1:5 title "LocalSensor" w linespoints 7 4, \
           '-'  using 1:6 title "Combined" w linespoints 7 5

#pause -1 "Hit return to continue"

THDS    Fetch     DistC    PDistC   LocS     Combined
08      11   10   23    45    2
16      104  60   58    28    51 
24      172  75   86    110   71 
32      766  729  57    172   48
e
THDS    Fetch     DistC    PDistC   LocS     Combined
08      11   10   23    45    2
16      104  60   58    28    51 
24      172  75   86    110   71 
32      766  729  57    172   48
e
THDS    Fetch     DistC    PDistC   LocS     Combined
08      11   10   23    45    2
16      104  60   58    28    51 
24      172  75   86    110   71 
32      766  729  57    172   48
e
THDS    Fetch     DistC    PDistC   LocS     Combined
08      11   10   23    45    2
16      104  60   58    28    51 
24      172  75   86    110   71 
32      766  729  57    172   48
e
THDS    Fetch     DistC    PDistC   LocS     Combined
08      11   10   23    45    2
16      104  60   58    28    51 
24      172  75   86    110   71 
32      766  729  57    172   48
e
