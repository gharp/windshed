# cumulative sum
awk '{if ($5>0) {counts[$1]+=$5} else if ($5<0) {counts[$1]-=$5}}END{for (site in counts) print site, counts[site]}' lmp_5min_2013*.csv | sort -k 2 -g > curtailment_events.csv 

# filter out the top few sites
awk '{if ($2>6000) print $1","$2 }' curtailment_events.csv > important_curtailment_sites.csv
