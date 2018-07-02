#!/bin/bash

# sendemail    \
#     -f "footprns@yahoo.com"   \
#     -u "Email Subject 1"     \
#     -t "imankurniawan@gmail.com" \
#     -s "smtp.mail.yahoo.com:587"  \
#     -o tls=yes \
#     -xu "footprns@yahoo.com" \
#     -xp "serpong35" \
#     -o message-file="/tmp/mailbody.txt"


    curl --url 'smtps://smtp.mail.yahoo.com:465' --ssl-reqd \
      --mail-from 'footprns@yahoo.com' --mail-rcpt 'imankurniawan@gmail.com' \
     --user 'footprns@yahoo.com:serpong35'
