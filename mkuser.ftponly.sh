#!/bin/sh

# script to create an FTP-only user in PureFTPD

# confirm a parameter was provided
if [ -z "$1" ] ; then
   echo Usage: $0 SomeUserName
   exit
fi

# confirm PureFTPD is installed
if [ ! -f "/usr/sbin/pure-ftpd" ] ; then
   echo ERROR: Cannot find /usr/sbin/pure-ftpd daemon
   exit
fi

# confirm ftpuser and ftpgroup exist
grep ^ftpuser: /etc/passwd || (
   echo ERROR: ftpuser does not exist.
   echo        Please create with: useradd ftpuser
   exit
)
grep ^ftpgroup: /etc/group || (
   echo ERROR: ftpgroup group does not exist.
   echo        Please create with: groupaddadd ftpgroup
   exit
)

# create user
echo Creating ftp-only user $1
pure-pw useradd $1 -u ftpuser -d /home/ftpuser/$1 -f /etc/pure-ftpd/pureftpd.passwd

# create home directory
test -d /home/ftpuser && mkdir /home/ftpuser/$1
chown -R ftpuser:ftpgroup /home/ftpuser/$1

# commit changes to PureFTPD database
pure-pw mkdb


# to delete a user
# pure-pw userdel janedoe
# rm -rf /home/ftpuser/janedoe

# change password of an existing user
# pure-pw passwd janedoe


# show user details
# pure-pw show janedoe


