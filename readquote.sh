#!/bin/bash
# sudo yum install w3m
# sudo yum install phantomjs
# wget https://www.w3.org/Tools/HTML-XML-utils/html-xml-utils-7.7.tar.gz
# tar -zxvf html-xml-utils-7.7.tar.gz
# wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
# sudo su -
# ./configure && make && make install
#<span class="priceText__1853e8a5">1,559.4200</span>
#<div class="price">1,559.42</div>

link=https://www.bloomberg.com/quote/ASHPRON:IJ
outputfile=ASHPRON:IJ
targetprice=1600.05
starttag="div\ class=\"price\""
endtag=div
curl -s $link -o $outputfile
price=$(sed -n "/<$starttag>/,/<\/$endtag>/p" $outputfile | w3m -dump -cols 2000 -T 'text/html' | awk 'NR==7' | sed 's/,//g')
quote=$(sed -n "/<$starttag>/,/<\/$endtag>/p" $outputfile | w3m -dump -cols 2000 -T 'text/html' | awk 'NR==6')
quotename=$(sed -n "/<$starttag>/,/<\/$endtag>/p" $outputfile | w3m -dump -cols 2000 -T 'text/html' | awk 'NR==4')
echo $quote\ $quotename\ $price
echo $price | bc -l


if (( $(echo "$targetprice >= $price" | bc -l) )); then
  #statements
  echo "Target price belum tercapai"
fi
