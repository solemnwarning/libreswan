: ==== start ====
TESTNAME=ikev2-07-biddown
/testing/pluto/bin/wait-until-network-ready

source /testing/pluto/bin/eastlocal.sh

ipsec setup start
/testing/pluto/bin/wait-until-pluto-started

ipsec auto --add westnet-eastnet-ipv4
ipsec whack --debug-control --debug-controlmore --debug-crypt
echo "initdone"
