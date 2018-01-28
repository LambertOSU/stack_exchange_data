#!/bin/bash
#-------------------------------------------------------------------------------

# This script loads the stack exchange community data contained in the XML files
# into MySQL.  It uses the name of the directory (community) as the root name of
# the database.  It checks for existing databases, so it can be used to update
# MySQL as new community data sets are downloaded, effectively syncing any
# uncompressed files the directory.

# Use stackex_unpacker.sh to uncompress the .7z files
# into appropriately named directories.

# The MySQL commands are contained in stack_xml_to_mysql.sh which must
# be in the directory.  It contains a generic string, "community", which is
# updated with the name of the target directory and used to make the DATABASE.

#-------------------------------------------------------------------------------

# loop through all of the directories
for dir in */ ;
do
  # get the directory name
  dir="${dir%*/}"
  echo "-----------------"
  echo "$dir"

  # make the database name
  db=$dir"_stackexchange_com"

  # check if database exists already
  RESULT=`mysqlshow --login-path=local $db| grep -v Wildcard | grep -o $db`
  if [ "$RESULT" == "$db" ];

  # if database exists, report that
  then
      echo $'\n'
      echo " Database $db already exists."
      echo $'\n'

  # else run the stack_xml_to_mysql.sql
  # batch script and report progress
  else
      # report
      echo $'\n'
      echo "Creating Database $db."

      # edit the database name
      sed -i "s/community/"$dir"/g" stack_xml_to_mysql.sql

      # execute SQL script
      echo "Loading data..."
      mysql --login-path=local < "stack_xml_to_mysql.sql"

      # reset database name
      sed -i "s/"$dir"/community/g" stack_xml_to_mysql.sql

      # report
      echo "Complete!"
      echo $'\n'
  fi

done
