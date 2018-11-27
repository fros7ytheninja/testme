#!/bin/ksh

export TOPDIR=$(dirname $0)
#Connection string for DB2
export CONN_STRING_DB2=""
#Connection user name to DB2
export USR_NAME_DB2=""
#Password file for DB2
export PW_FILE_DB2=""
#Connection string for Oracle
export CONN_STRING_ORA=""
#Connection user name to Oracle
export USR_NAME_ORA=""
#Password file for Oracle
export PW_FILE_ORA=""
#Root target dir for all tables in HDFS
export TARGET_ROOT=

cat $TOPDIR/tables.cfg | grep -v "#" | while read LINE ; do
  $TABLE=$(echo $LINE | cut -d '|' -f 2)
  $SRC_SYS=$(echo $LINE | cut -d '|' -f 1)
  
  if [ "$SRC_SYS" = "LISON" ]
  then
    $NEW_TABLE_NAME=DUW.KGZ.UE.${TABLE}
    sqoop import -libjars '${TOPDIR}/db2jcc4.jar' --connect $CONN_STRING_DB2 --username "$USR_NAME_DB2" --password-file "$PW_FILE_DB2" --table "$TABLE" --target-dir ${TARGET_ROOT}/${SRC_SYS}/${NEW_TABLE_NAME} -m 1
  elif [ "$SRC_SYS" = "LOGIS" ]
  then
    $NEW_TABLE_NAME=DUW.KGZ.FT.${TABLE}
    sqoop import --connect $CONN_STRING_ORA --username "$USR_NAME_ORA" --password-file "$PW_FILE_ORA" --query 'select * from ${TABLE} where \$CONDITIONS' --target-dir ${TARGET_ROOT}/${SRC_SYS}/${NEW_TABLE_NAME} -m 1
  fi

done