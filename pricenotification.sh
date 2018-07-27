#!/bin/bash

cd /home/pi/Documents/mutualfund
INPUT=listquotes.txt
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read quote currency price lowerprice upperprice email baselinedate lowerpcg upperpcg desc
do
  link=https://www.bloomberg.com/quote/$quote
  outputfile=$quote
  w3m -dump $link > $outputfile
  runningprice=$(grep $quote -A1 $outputfile | awk 'NR==2' | sed 's/,//g')
  if [[ -z "$runningprice" ]]; then
  runningprice=$(grep $quote -A4 $outputfile | awk 'NR==5' | sed 's/,//g' | sed 's/[^0-9]*//g')
    echo $runningprice
  else
    echo $runningprice
  fi

  echo "quote : $quote $desc"
	echo "price : $price"
	echo "lowerprice : $lowerprice"
	echo "upperprice : $upperprice"

  if (( $(echo "$runningprice >= $upperprice" | bc -l) )); then
     echo "Subject: $quote $desc" > msg.txt
     echo "" >> msg.txt
     echo "Jual untung" >> msg.txt
     echo "baselinedate: $baselinedate" >> msg.txt
     echo "baselineprice: $price $currency" >> msg.txt
     echo "runningprice: $runningprice $currency" >> msg.txt
     echo "more than $upperpcg" >> msg.txt
     ssmtp $email < msg.txt
  elif (( $(echo "$runningprice <= $lowerprice" | bc -l) )); then
    echo "Subject: $quote  $desc" > msg.txt
    echo "" >> msg.txt
    echo "Jual rugi" >> msg.txt
    echo "baselinedate: $baselinedate" >> msg.txt
    echo "baselineprice: $price $currency" >> msg.txt
    echo "runningprice: $runningprice $currency" >> msg.txt
    echo "less than $lowerpcg" >> msg.txt
    ssmtp $email < msg.txt
  else
    echo "Tahan"
  fi
echo "--------------------------"
done < $INPUT
# IFS=$OLDIFS
