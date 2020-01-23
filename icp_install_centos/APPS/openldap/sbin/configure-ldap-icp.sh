#!/bin/bash
#
# in order to run this script, you should kubernetes cli setup
# or, you will need to cluster adresss, username, password
#

source ~/INSTALL/0_variables.sh


sudo apt-get install jq

URL=`kubectl cluster-info | grep "Kubernetes master" | awk '{print $6}'`
HOST=`echo $URL | cut -d'/' -f3 | cut -d':' -f1`
LDAP=`kubectl get service openldap -o yaml | grep clusterIP | cut -d':' -f2 | xargs`

HOST_IP=192.168.27.199
LDAP_HOST_IP=${1:-$LDAP}
ICPCLUSTERADMIN=admin
ICPCLUSTERADMINPASSWORD=admin

echo "HOST_IP -> $HOST_IP"
echo "LDAP_IP -> $LDAP_HOST_IP"

BEARER=$(curl -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" \
-d "grant_type=password&username="$ICPCLUSTERADMIN"&password="$ICPCLUSTERADMINPASSWORD"&scope=openid" \
https://$HOST_IP:8443/idprovider/v1/auth/identitytoken --insecure | \
jq '.access_token' | tr -d '"')
echo "BEARER: $BEARER"

encoded=$(echo admin| tr -d '\n' |  base64)

echo $encoded

curl -k -X POST \
  https://$HOST_IP:8443/idmgmt/identity/api/v1/directory/ldap/onboardDirectory \
  -H "Authorization: bearer ${BEARER}" \
  -H "content-type: application/json" \
  -d '{
    "TYPE":"LDAP",
    "LDAP_ID": "openLDAP",
    "LDAP_REALM": "openLDAPRealm",
    "LDAP_HOST": "'"${LDAP_HOST_IP}"'",
    "LDAP_PORT": "389",
    "LDAP_IGNORECASE": "false",
    "LDAP_BASEDN": "dc=local,dc=io",
    "LDAP_BINDDN": "cn=admin,dc=local,dc=io",
    "LDAP_BINDPASSWORD": "'"${encoded}"'",
    "LDAP_TYPE": "Custom",
    "LDAP_USERFILTER": "(&(uid=%v)(objectclass=person))",
    "LDAP_GROUPFILTER": "(&(cn=%v)(objectclass=groupOfUniqueNames))",
    "LDAP_USERIDMAP": "*:uid",
    "LDAP_GROUPIDMAP": "*:cn",
    "LDAP_GROUPMEMBERIDMAP": "groupOfUniqueNames:uniquemember"
  }' \
  --insecure
