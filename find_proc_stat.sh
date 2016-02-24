NOW=$(date +%s)
DIFF=60
for((;;)); do

#echo "DIFF = $DIFF" >> top.log 2>&1

  if(($DIFF >= 60))
then
    TIME=$(date)
    echo " " >> top.log 2>&1
    echo "Refresh at $TIME ..." >> top.log 2>&1
    echo " " >> top.log 2>&1
    free >> top.log 2>&1
    echo " " >> top.log 2>&1
    top| awk ' {if (NR <=7) print;else exit 1} END {print "\n\n"}'  >> top.log 2>&1 &
    echo " " >> top.log 2>&1
    sleep 5
    NOW=$(date +%s)
    DIFF=0
else
    top| awk -v time="$(date +"%Y-%m-%d %r")" 'BEGIN {print"\n", time;print"\n"} {if(NR >20) {exit 1} else if (($3 == "D")||($4 == "D")) {print; count++}} END {if(count >0) {print "\n\nTotal status D (I/O wait probably): "count}}'  >> top.log 2>&1 &
    sleep 5
    DIFF=`expr $(date +%s) - $NOW`
fi
done
