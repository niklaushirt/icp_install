#!/bin/bash

source ~/INSTALL/0_variables.sh



# Install OpenLDAP
echo "Install OpenLDAP "
echo "Logging in"

klogin

echo "Install OpenLDAP Helm Chart"
helm install --name openldap ~/INSTALL/APPS/openldap --tls



echo "Install OpenLDAP Command Line"


if [  -n "$(uname -a | grep Ubuntu)" ]; then
klogin
  sudo apt-get update
  sudo apt-get --yes --force-yes install ldap-utils
else
  sudo yum update -y
  sudo yum install -y  openldap-clients
fi

  slappasswd -h {SSHA} -s admin
  sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /~/INSTALL/APPS/openldap/import.ldif

# Create LDAP Users
echo "Create LDAP Users"
~/INSTALL/APPS/openldap/sbin/configure-team-icp.sh

# Create LDAP Config
echo "Create LDAP Config"
~/INSTALL/APPS/openldap/sbin/configure-ldap.sh


echo "-----------------------------------------------------------------------------------------------------------"
echo "DONE"
echo "-----------------------------------------------------------------------------------------------------------"
