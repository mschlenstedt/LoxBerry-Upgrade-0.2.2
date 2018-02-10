#!/bin/sh

#
# LoxBerry Upgrade Script
#

# Script basedir
DIR=$(dirname $(readlink -f $0))
echo "<INFO> My basedir: $DIR"
cd $DIR

UPGRADEFOUND=0

##################################################
# Upgrade 0.2.1 to 0.2.2
##################################################

# Read Current Version
if [ -f "../../../config/system/general.cfg" ]
	then

	VERSION=`cat ../../../config/system/general.cfg | grep VERSION= | xargs -d '=' | awk '{print $2}' | head -1`
	NVERSION=`echo $VERSION | sed 's/\.//g'` # string with two dots cannot be compared in bash

else

  echo "<FAIL> Cannot find your system configuration. Aborting."
  exit 1;

fi

if [ "$NVERSION" -eq "021" ]
  then

  UPGRADEFOUND=1

  echo "<INFO> Upgrade will be done from $VERSION to 0.2.2"

  cp -v -r ./files/0.2.2/data/system/uninstall ../../../data/system/
  chown -v -R loxberry.loxberry ../../../data/system/uninstall

  cp -v ./files/0.2.2/sbin/* ../../../sbin/
  chown -v -R loxberry.loxberry ../../../sbin  
  chmod -v 755 ../../../sbin/*

  cp -v -r ./files/0.2.2/system/daemons/uninstall ../../../system/daemons/
  chown -v -R loxberry.loxberry ../../../system/daemons/uninstall

  cp -v ./files/0.2.2/templates/system/timezones.dat ../../../templates/system/
  cp -v ./files/0.2.2/templates/system/de/help/* ../../../templates/system/de/help/
  cp -v ./files/0.2.2/templates/system/de/setup/* ../../../templates/system/de/setup/
  cp -v ./files/0.2.2/templates/system/de/* ../../../templates/system/de/
  cp -v ./files/0.2.2/templates/system/en/help/* ../../../templates/system/en/help/
  cp -v ./files/0.2.2/templates/system/en/setup/* ../../../templates/system/en/setup/
  cp -v ./files/0.2.2/templates/system/en/* ../../../templates/system/en/
  chown -v -R loxberry.loxberry ../../../templates/system
  
  cp -v -r ./files/0.2.2/webfrontend/cgi/system/setup ../../../webfrontend/cgi/system/
  cp -v ./files/0.2.2/webfrontend/cgi/system/* ../../../webfrontend/cgi/system/
  chown -v -R loxberry.loxberry ../../../webfrontend/cgi/system
  chmod -v 755 ../../../webfrontend/cgi/system/*
  chmod -v 755 ../../../webfrontend/cgi/system/setup/*

  echo "loxberry ALL = NOPASSWD: /usr/bin/dpkg" >> /etc/sudoers

  # Upgrade version number
  /bin/sed -i "s:VERSION=0.2.1:VERSION=0.2.2:" ../../../config/system/general.cfg

  echo "<OK> Upgrade successfully done to Version 0.2.2"

fi

##################################################
# Upgrade 0.2.2 to 0.2.3
##################################################

# Read Current Version
if [ -f "../../../config/system/general.cfg" ]
	then

	VERSION=`cat ../../../config/system/general.cfg | grep VERSION= | xargs -d '=' | awk '{print $2}' | head -1`
	NVERSION=`echo $VERSION | sed 's/\.//g'` # string with two dots cannot be compared in bash

else

  echo "<FAIL> Cannot find your system configuration. Aborting."
  exit 1;

fi

if [ "$NVERSION" -eq "022" ]
  then

  UPGRADEFOUND=1

  echo "<INFO> Upgrade will be done from $VERSION to 0.2.3"

  cp -v ./files/0.2.3/templates/system/de/* ../../../templates/system/de/
  cp -v ./files/0.2.3/templates/system/en/* ../../../templates/system/en/
  chown -v -R loxberry.loxberry ../../../templates/system
  
  cp -v ./files/0.2.3/webfrontend/cgi/system/* ../../../webfrontend/cgi/system/
  chown -v -R loxberry.loxberry ../../../webfrontend/cgi/system
  chmod -v 755 ../../../webfrontend/cgi/system/*

  cp -v ./files/0.2.3/sbin/* ../../../sbin/
  chown -v -R loxberry.loxberry ../../../sbin  
  chmod -v 755 ../../../sbin/*

  # Upgrade version number
  /bin/sed -i "s:VERSION=0.2.2:VERSION=0.2.3:" ../../../config/system/general.cfg

  echo "<OK> Upgrade successfully done to Version 0.2.3"

fi

##################################################
# Upgrade 0.2.3 to 0.2.4
##################################################

# Read Current Version
if [ -f "../../../config/system/general.cfg" ]
	then

	VERSION=`cat ../../../config/system/general.cfg | grep VERSION= | xargs -d '=' | awk '{print $2}' | head -1`
	NVERSION=`echo $VERSION | sed 's/\.//g'` # string with two dots cannot be compared in bash

else

  echo "<FAIL> Cannot find your system configuration. Aborting."
  exit 1;

fi

if [ "$NVERSION" -eq "023" ]
  then

  UPGRADEFOUND=1

  echo "<INFO> Upgrade will be done from $VERSION to 0.2.4"

  cp -v ./files/0.2.4/webfrontend/cgi/system/* ../../../webfrontend/cgi/system/
  chown -v -R loxberry:loxberry ../../../webfrontend/cgi/system
  chmod -v 755 ../../../webfrontend/cgi/system/*

  cp -v ./files/0.2.4/sbin/* ../../../sbin/
  chown -v -R loxberry:loxberry ../../../sbin  
  chmod -v 755 ../../../sbin/*

  export DEBIAN_FRONTEND=noninteractive
  dpkg --configure -a
  apt-get -q -y update
  apt-get -q -y install php5-curl
  apt-get -q -y install curl

  # Upgrade version number
  /bin/sed -i "s:VERSION=0.2.3:VERSION=0.2.4:" ../../../config/system/general.cfg

  echo "<OK> Upgrade successfully done to Version 0.2.4"

fi

if [ "$UPGRADEFOUND" -eq "1" ]
  then

  exit 0

else

  echo "<FAIL> Cannot find any upgrade for your version. Your version is $VERSION. Aborting."
  exit 1

fi

exit 0
