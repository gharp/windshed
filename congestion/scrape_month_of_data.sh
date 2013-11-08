# eg for May 1st and 2nd
# ./scrape_month_of_data.sh 05 "01 02"

m=$1
ds=$2

for d in $ds; do #01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28; do
    # log
    echo $m $d

    # create output file
    touch lmp_5min_2013${m}${d}.csv

    # scrape data
    curl http://www.iso-ne.com/histRpts/5min-rt/lmp_5min_2013${m}${d}_00-04.csv -O
    curl http://www.iso-ne.com/histRpts/5min-rt/lmp_5min_2013${m}${d}_04-08.csv -O
    curl http://www.iso-ne.com/histRpts/5min-rt/lmp_5min_2013${m}${d}_08-12.csv -O
    curl http://www.iso-ne.com/histRpts/5min-rt/lmp_5min_2013${m}${d}_12-16.csv -O
    curl http://www.iso-ne.com/histRpts/5min-rt/lmp_5min_2013${m}${d}_16-20.csv -O
    curl http://www.iso-ne.com/histRpts/5min-rt/lmp_5min_2013${m}${d}_20-24.csv -O

    for f in $(ls lmp_5min_2013${m}${d}_*.csv); do
	# save lines that matter
	awk -F"," -v m=$m -v d=$d '{if ($5!=0 && $1=="\"D\"") print $2, m, d, $3, $5}' $f >> lmp_5min_2013${m}${d}.csv

	# remove full file
	rm $f
    done # end loop over hourly files

done # end loop over days

