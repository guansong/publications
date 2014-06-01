set title "Barrier overhead"
set xlabel "Processor number"
set ylabel "Time(us)"

#This is scale
set size 1,1

#set key 10,18
set key left

set xtics 4,4,32
#set ytics 

set grid noxtics ytics

#set logscale x 2
#set logscale y 2

set terminal postscript eps color "Times-Roman" 30
#set terminal postscript default color "Times-Roman" 10

plot [0:33] [0:40] \
           '-'  using 1:2 title "FetchAndAdd" w linespoints 7 1, \
           '-'  using 1:2 title "DistCounter" w linespoints 7 2

#pause -1 "Hit return to continue"

THDS    Fetch  
02      2.02    
04      4.16     
06           
08      9.12     
10          
12          
14          
16      23.16    
18          
20          
22          
24          
26          
28          
30         
32      38.66   
e
THDS    Fetch   
02      1.06    
04      2.10     
06           
08      3.18     
10          
12          
14          
16      5.50    
18          
20          
22          
24          
26          
28          
30         
32      7.96   
e
