#!/bin/bash 

SUITEVERSION=suitecrm-8-9-0

do_init () {
  echo "Initialising"
  echo "Downloading $SUITEVERSION"
   wget -q https://suitecrm.com/download/166/suite89/565428/$SUITEVERSION.zip
   echo "Extracting"
   unzip -o -q $SUITEVERSION.zip -d SuiteCRM/
   echo "Generating self signed keys"
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
          -keyout /etc/ssl/private/apache-selfsigned.key \
          -out /etc/ssl/certs/apache-selfsigned.crt \
          -subj "/C=UK/ST=TestSt/L=Test/O=OS/CN=localhost"
}

if ! [ -f SuiteCRM/VERSION ]; 
  then
    do_init
fi
    chown -R www-data:www-data .
    echo "Permissions set"

      echo "starting Apache server"
     
      echo "$SUITEVERSION is now available @ http://localhost:8080 and https://localhost:8081"
      echo "PHPMyAdmin is available @ http://localhost:8181"
      echo "MySQL is available on port 3306"

      apachectl -D FOREGROUND
