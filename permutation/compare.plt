#set encoding iso_8859_1
set data style boxes
set style fill solid

set xrange [0:8]
set xtic ("1" 0.5,"2" 1.5,"4" 3.5, "6" 5.5,"8" 7.5)
set xlabel "Number of processors" 

set yrange [0:2.5]
set ylabel "Time(sesonds)" 

#set term fig  metric
#set terminal postscript default color "Times-Roman" 18
set terminal postscript eps color "Times-Roman" 30

set key right

set title "Execution time difference"

set boxwidth 0.4
plot     "-" using ($1-1+0.3):($2) title "Baseline" linetype 1 ,\
	 "-" using ($1-1+0.6):($2) title "Improved" linetype 5 

1       1.682
2       1.692
4       1.667
6       1.680
8       1.691
e
1       1.546
2       0.862
4       0.630
6       0.668
8       0.658
e
