#set encoding iso_8859_1
set data style boxes
set style fill solid

set xrange [0:8]

set xtic ("" 2.5,"" 5.5)

set label 3 "POWER3" at 2.5, graph -0.05, 0 centre norotate 
set label 6 "POWER4" at 5.5, graph -0.05, 0 centre norotate

set yrange [0:80]

set ylabel "Time(us)" 

#set term fig  metric
#set terminal postscript default color "Times-Roman" 18
set terminal postscript eps color "Times-Roman" 30

set key right

set title "Parallel region overhead (for 16 threads)"

set boxwidth 0.5
plot     "-" using ($1-1+0.25):($2) title "Init at startup" linetype 1 ,\
	 "-" using ($1-1+0.65):($2) title "Init on demand" linetype 2 

3       70.28
6       35.76
e
3       22.84
6       12.54
e
