#!/bin/sh

cd ~
dtm=`date "+%Y-%m-%d_%T"`;
LOG="./WEBA_$dtm.log";


# Recommend to run under root
if [ "$(id -u)" != "0" ]; then
   echo "   [[  This script better run as ROOT             ]]" 1>&2 | tee -a $LOG
   echo "   [[  Press Ctrl-C or wait 5 seconds to continue ]]" 1>&2 | tee -a $LOG
   echo "   [[  Use su or sudo for run $0             ]]" 1>&2 | tee -a $LOG
   echo "   [[  for ICMP-Tracing and more detail diag      ]]" 1>&2 | tee -a $LOG
   echo "   -------------------------------------------------" 1>&2 | tee -a $LOG
   echo "   [[  Need ~ 8 min. for all tests. Don't panic.  ]]" 1>&2 | tee -a $LOG
   sleep 5;
fi


echo "=-=-=-=-=     WEBA Diagnostic [$dtm]     =-=-=-=-=

" | tee $LOG


echo    "
************ OS Version ************" | tee -a $LOG
uname -a | tee -a $LOG
cat /etc/*release* | tee -a $LOG

echo    "
************ SELinux Status ************" | tee -a $LOG
getenforce | tee -a $LOG
id -Z | tee -a $LOG

echo    "
************ IP Interfaces parameters ************" | tee -a $LOG
ifconfig | tee -a $LOG
ip a | tee -a $LOG

echo    "
************ SysCTL net-parameters ************" | tee -a $LOG
echo    "       --- net-parameters ---" | tee -a $LOG
sysctl -a | grep net | tee -a $LOG
echo    "       --- tcp-parameters ---" | tee -a $LOG
sysctl -a | grep tcp | grep -v net | tee -a $LOG
echo    "       --- udp-parameters ---" | tee -a $LOG
sysctl -a | grep udp | grep -v net | tee -a $LOG

echo    "
************ IPv4 Routing Table ************" | tee -a $LOG
netstat -nr | tee -a $LOG

echo    "
************ IPv6 Routing Table ************" | tee -a $LOG
netstat -nr -6 | tee -a $LOG

echo    "
************ ARP-Table ************" | tee -a $LOG
arp -an | tee -a $LOG

echo    "
************ Current connections ************" | tee -a $LOG
netstat -natup | tee -a $LOG



echo "   ------- " `date "+%Y-%m-%d_%T"` | tee -a $LOG


ping_cmd="ping -p 20416d696e203d20446f62726f203d20 -s 86 -c 10";
ping_cmd_opt="ping -p 20416d696e203d20446f62726f203d20 -s 94 -c 2 -R";

echo    "
************ Ping 10x to WEBA-DNS1 ************" | tee -a $LOG
$ping_cmd 37.153.1.2 | tee -a $LOG
$ping_cmd_opt 37.153.1.2 | tee -a $LOG

echo    "
************ Ping 10x to WEBA-DNS2 ************" | tee -a $LOG
$ping_cmd 37.153.0.5 | tee -a $LOG
$ping_cmd_opt 37.153.0.5 | tee -a $LOG

echo    "
************ Ping 10x to WEBA-DNS3 ************" | tee -a $LOG
$ping_cmd 37.153.1.5 | tee -a $LOG
$ping_cmd_opt 37.153.1.5 | tee -a $LOG

echo    "
************ Ping to Basic Yandex-DNS ************" | tee -a $LOG
$ping_cmd 77.88.8.8 | tee -a $LOG # http://dns.yandex.ru/
$ping_cmd_opt 77.88.8.8 | tee -a $LOG # http://dns.yandex.ru/

echo    "
************ Ping to Safe Yandex-DNS ************" | tee -a $LOG
$ping_cmd 77.88.8.88 | tee -a $LOG # http://dns.yandex.ru/
$ping_cmd_opt 77.88.8.88 | tee -a $LOG # http://dns.yandex.ru/

echo    "
************ Ping to Family Yandex-DNS ************" | tee -a $LOG
$ping_cmd 77.88.8.7 | tee -a $LOG # http://dns.yandex.ru/
$ping_cmd_opt 77.88.8.7 | tee -a $LOG # http://dns.yandex.ru/

echo    "
************ Ping 10x to Mail.ru ************" | tee -a $LOG
$ping_cmd mail.ru | tee -a $LOG
$ping_cmd_opt mail.ru | tee -a $LOG

echo    "
************ Ping 10x to Yahoo.com ************" | tee -a $LOG
$ping_cmd yahoo.com | tee -a $LOG
$ping_cmd_opt yahoo.com | tee -a $LOG



echo "   ------- " `date "+%Y-%m-%d_%T"` | tee -a $LOG



echo    "
************ Trace to Google-DNS ************" | tee -a $LOG
traceroute -n -w 3 8.8.8.8 | tee -a $LOG
tracepath  -b 8.8.8.8 | tee -a $LOG

echo    "
************ Trace to Yandex-DNS ************" | tee -a $LOG
traceroute -n -w 3 77.88.8.7 | tee -a $LOG # http://dns.yandex.ru/
tracepath  -b 77.88.8.7 | tee -a $LOG

echo    "
************ Trace to 109.167.190.190 (Lan-IX.Ru, PEERING) ************" | tee -a $LOG
traceroute -w 3 109.167.190.190 | tee -a $LOG
tracepath  -b 109.167.190.190 | tee -a $LOG

echo    "
************ Trace to 178.18.224.100 (DataIX-1, PEERING) ************" | tee -a $LOG
traceroute -w 3 178.18.224.100 | tee -a $LOG
tracepath  -b 178.18.224.100 | tee -a $LOG

echo    "
************ Trace to 178.18.227.100 (DataIX-2, PEERING) ************" | tee -a $LOG
traceroute -w 3 178.18.227.100 | tee -a $LOG
tracepath  -b 178.18.227.100 | tee -a $LOG

echo    "
************ Trace to 193.28.6.1 (Pirix, PEERING) ************" | tee -a $LOG
traceroute -w 3 193.28.6.1 | tee -a $LOG
tracepath  -b 193.28.6.1 | tee -a $LOG

echo    "
************ Trace to 185.47.53.153 (Comfortel, INET) ************" | tee -a $LOG
traceroute -w 3 185.47.53.153 | tee -a $LOG
tracepath  -b 185.47.53.153 | tee -a $LOG

echo    "
************ Trace to WEBA.RU ************" | tee -a $LOG
traceroute -w 3 weba.ru | tee -a $LOG
tracepath  -b weba.ru | tee -a $LOG



echo "   ------- " `date "+%Y-%m-%d_%T"` | tee -a $LOG



echo    "
************ ICMP-Trace to Google-DNS ************" | tee -a $LOG
traceroute -n -I -w 3 8.8.8.8 2>&1 | tee -a $LOG

echo    "
************ ICMP-Trace to Yandex-DNS ************" | tee -a $LOG
traceroute -n -I -w 3 77.88.8.7 2>&1 | tee -a $LOG # http://dns.yandex.ru/

echo    "
************ ICMP-Trace to 109.167.190.190 (Lan-IX.Ru, PEERING) ************" | tee -a $LOG
traceroute -n -I -w 3 109.167.190.190 2>&1 | tee -a $LOG

echo    "
************ ICMP-Trace to 178.18.224.100 (DataIX-1, PEERING) ************" | tee -a $LOG
traceroute -n -I -w 3 178.18.224.100 2>&1 | tee -a $LOG

echo    "
************ ICMP-Trace to 178.18.227.100 (DataIX-2, PEERING) ************" | tee -a $LOG
traceroute -n -I -w 3 178.18.227.100 2>&1 | tee -a $LOG

echo    "
************ ICMP-Trace to 193.28.6.1 (Pirix, PEERING) ************" | tee -a $LOG
traceroute -n -I -w 3 193.28.6.1 2>&1 | tee -a $LOG

echo    "
************ ICMP-Trace to 185.47.53.153 (Comfortel, INET) ************" | tee -a $LOG
traceroute -n -I -w 3 185.47.53.153 2>&1 | tee -a $LOG

echo    "
************ ICMP-Trace to WEBA.RU ************" | tee -a $LOG
traceroute -I -w 3 weba.ru 2>&1 | tee -a $LOG



echo "   ------- " `date "+%Y-%m-%d_%T"` | tee -a $LOG



echo    "
************ Name resolving tests ************" | tee -a $LOG
nslookup weba.ru. | tee -a $LOG
nslookup mail.ru. | tee -a $LOG
nslookup google.ru. | tee -a $LOG
nslookup google.cn. | tee -a $LOG
nslookup cisco.com. | tee -a $LOG
nslookup microsoft.com. | tee -a $LOG
nslookup drweb.com. | tee -a $LOG
nslookup kaspersky.com. | tee -a $LOG
nslookup dataix.ru. | tee -a $LOG
nslookup lan-ix.ru. | tee -a $LOG



echo    "
************ IPv6-TracePath to Google.com ************" | tee -a $LOG
tracepath6 -b google.com 2>&1 | tee -a $LOG

echo    "
************ IPv6-TracePath to vk.com ************" | tee -a $LOG
tracepath6 -b vk.com 2>&1 | tee -a $LOG



echo "   ------- " `date "+%Y-%m-%d_%T"` | tee -a $LOG



echo "
=-=-=-=-=   Diagnostic finished.   =-=-=-=-=
   Send $LOG to support@weba.ru
=-=-=-=-=   CIIACU6O.   =-=-=-=-=
" | tee -a $LOG

