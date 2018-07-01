#!/bin/bash
# sudo yum install w3m
# wget https://www.w3.org/Tools/HTML-XML-utils/html-xml-utils-7.7.tar.gz
# tar -zxvf html-xml-utils-7.7.tar.gz
# sudo su -
# ./configure && make && make install
#<span class="priceText__1853e8a5">1,559.4200</span>
#<div class="price">1,559.42</div>
# set -o xtrace
outputfile=view-source_https___www.bloomberg.com_quote_BNPASUS_IJ.html
targetprice=1600.05
starttag="div"
endtag="div"
sed -n "/<$starttag>/,/<\/$endtag>/p" $outputfile
price=$(sed -n "/<$starttag>/,/<\/$endtag>/p" $outputfile | w3m -dump -cols 2000 -T 'text/html' | awk 'NR==7' | sed 's/,//g')
quote=$(sed -n "/<$starttag>/,/<\/$endtag>/p" $outputfile | w3m -dump -cols 2000 -T 'text/html' | awk 'NR==6')
quotename=$(sed -n "/<$starttag>/,/<\/$endtag>/p" $outputfile | w3m -dump -cols 2000 -T 'text/html' | awk 'NR==4')
echo $quote\ $quotename\ $price
echo $price | bc -l


for f in $(cat listquotes.txt) ; do
  w3m -dump "view-source_https___www.bloomberg.com_quote_"$f".html" | grep totalReturn3Month | head -1 > clean.txt
  while IFS=, read -ra arr; do
      ## Do something with ${arr0]}, ${arr[1]} and ${arr[2]}
      totalReturn3Month=$(echo ${arr[5]} | awk -F ':' '{print $2}')
      # echo $totalReturn3Month
      totalReturnYtd=$(echo ${arr[8]} | awk -F ':' '{print $2}')
      # echo $totalReturnYtd

      totalReturn1Year=$(echo ${arr[4]} | awk -F ':' '{print $2}')
      totalReturn3Year=$(echo ${arr[6]} | awk -F ':' '{print $2}')
      totalReturn5Year=$(echo ${arr[7]} | awk -F ':' '{print $2}')
      echo $totalReturn3Month","$totalReturnYtd","$totalReturn1Year","$totalReturn3Year","$totalReturn5Year
  done < clean.txt
done
