/testing/guestbin/swan-prep --x509
cp /testing/x509/crls/needupdate.crl /etc/ipsec.d/crls
certutil  -d sql:/etc/ipsec.d -D -n west
ipsec setup start
/testing/pluto/bin/wait-until-pluto-started
ipsec auto --add nss-cert-crl
ipsec auto --status |grep nss-cert-crl
echo "initdone"
