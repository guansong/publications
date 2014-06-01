#set encoding iso_8859_1
set data style boxes
set style fill solid

set offset 0, 0, 0, 0
#unset border

set xrange [0:12]

set xtic ("PAR" 1,"" 2,"PDO" 3,"" 4,"BAR" 5,"" 6,"DO" 7,"" 8,"SINGLE" 9,"" 10,"REDUC" 11)
#set xtic ("" 2, "" 4, "" 6, "" 8, "" 10)

#set label 6 "POWER4" at 5.5, graph -0.05, 0 centre norotate

set yrange [0:55]

set ylabel "Time(us)" 

#set term fig  metric
#set terminal postscript default color "Times-Roman" 18
set terminal postscript eps color "Times-Roman" 20

set key right

set title "Improvements on EPCC"

set boxwidth 0.5
plot     "-" using ($1-0.5+0.25):($2) title "Before" linetype 1 ,\
	 "-" using ($1-0.5+0.65):($2) title "After" linetype 2 

1       36.6
3       27.36
5       40.12
7       42.96
9       38.64
11      42.12
e
1       17.44
3       19.3
5       8
7       10.2
9       5.98
11      23.22
e
