ipsec auto --up  westnet-eastnet-ipv4-psk-ikev2
ping -n -c 4 -I 192.0.1.254 192.0.2.254
ipsec look
# give east some time, then delete it again
sleep 3
ipsec auto --down westnet-eastnet-ipv4-psk-ikev2
sleep 3
ipsec look
echo done
