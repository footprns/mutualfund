#!/bin/bash

INPUT=listquotes.txt
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read quote currency price lowerprice upperprice
do
  link=https://www.bloomberg.com/quote/$quote
  outputfile=$quote
  w3m -dump $link > $outputfile
  runningprice=$(grep $quote -A1 $outputfile | awk 'NR==2' | sed 's/,//g')
  echo $runningprice
  echo "quote : $quote"
	echo "price : $price"
	echo "lowerprice : $lowerprice"
	echo "upperprice : $upperprice"

  if (( $(echo "$runningprice >= $upperprice" | bc -l) )); then
    echo "Jual untung"
  elif (( $(echo "$runningprice <= $lowerprice" | bc -l) )); then
   echo "Jual rugi"
  else
    echo "Tahan"
  fi
echo "--------------------------"
done < $INPUT
# IFS=$OLDIFS
