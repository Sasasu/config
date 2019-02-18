#!/bin/sh

temp=$(dig @223.5.5.5 _spf.google.com TXT +short | sed -e 's/"v=spf1//' -e 's/ ~all"//' -e 's/ include:/ /g')

for domain in $temp ; do
    t=$(dig @223.5.5.5 $domain TXT +short | sed -e 's/"v=spf1//' -e 's/ ~all"//' -e 's/ ip.:/ /g')
    for i in $t;do
        ip route add $i dev tinc
    done
done
