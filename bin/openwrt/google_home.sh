#!/bin/bash

private_ip_list="0.0.0.0/8 \
    10.0.0.0/8 \
    127.0.0.0/8 \
    172.16.0.0/12 \
    192.168.0.0/16 \
    224.0.0.0/4 \
    240.0.0.0/4"
fake_ip_list="169.254.0.0/16"
google_home_mac="20:DF:B9:5A:37:16"
clash_port="7892"

CLASH_TABLE="CLASH"
IPTABLES="echo iptables"

$IPTABLES -t nat -X $CLASH_TABLE || true

$IPTABLES -t nat -N $CLASH_TABLE

for private in $private_ip_list; do
    $IPTABLES -t nat -A $CLASH_TABLE -d "$private" -j RETURN
done

$IPTABLES -t nat -A $CLASH_TABLE -p tcp -j REDIRECT --to-ports "$clash_port"

for fake_ip in $fake_ip_list; do
    $IPTABLES -t nat -A PREROUTING -p tcp -d "$fake_ip" -j $CLASH_TABLE
done

$IPTABLES -t nat -A PREROUTING -p tcp -m mac --mac-source "$google_home_mac" -j $CLASH_TABLE

for p in udp tcp; do
  $IPTABLES -I PREROUTING -t nat -p $p -m mac --mac-source "$google_home_mac" -d 8.8.4.4 --dport 53 -j REDIRECT --to-ports 853
  $IPTABLES -I PREROUTING -t nat -p $p -m mac --mac-source "$google_home_mac" -d 8.8.8.8 --dport 53 -j REDIRECT --to-ports 853
done

exec clash
