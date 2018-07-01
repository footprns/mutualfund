#!/bin/bash
while IFS=, read -ra arr; do
    ## Do something with ${arr0]}, ${arr[1]} and ${arr[2]}
    totalReturn3Month=$(echo ${arr[5]} | awk -F ':' '{print $2}')
    echo $totalReturn3Month
    totalReturnYtd=$(echo ${arr[8]} | awk -F ':' '{print $2}')
    echo $totalReturnYtd

    totalReturn1Year=$(echo ${arr[4]} | awk -F ':' '{print $2}')
    totalReturn3Year=$(echo ${arr[6]} | awk -F ':' '{print $2}')
    totalReturn5Year=$(echo ${arr[7]} | awk -F ':' '{print $2}')
    echo $totalReturn3Month","$totalReturnYtd","$totalReturn1Year","$totalReturn3Year","$totalReturn5Year


done < clean.txt
