docker exec -it opendj /opt/opendj/bin/ldapsearch \
  -h localhost \
  -p 1389 \
  -D "cn=zerocool" \
  -w admin \
  -b "dc=moria,dc=org" \
  "(objectClass=*)"
