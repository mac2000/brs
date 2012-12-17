#!/bin/sh

# SETTINGS
# ----------------------------------------------------------------
  MYSQL_USERNAME=[USERNAME]   # example: root
  MYSQL_PASSWORD=[PASSWORD]   # example: ****
  MYSQL_DATABASE=[DATABASE]   # example: wordpress

  WWW_PATH=[WWW_PATH]         # example: /home/wordpress/public_html
  BACKUPS_PATH=[BACKUPS_PATH] # example: /home/wordpress/backups

  COUNT_OF_BACKUPS_TO_STORE=30
# ----------------------------------------------------------------

# Remove trailing slashes
WWW_PATH=`echo "${WWW_PATH}" | sed -e "s/\/*$//" `
BACKUPS_PATH=`echo "${BACKUPS_PATH}" | sed -e "s/\/*$//" `

# Current date for file names
DATE=`date +%Y-%m-%d`

# Backup www directory, options: c - create, p - preserve permissions, z - zip, P - do not strip slashes, f - archive file path
/bin/tar -cpzPf ${BACKUPS_PATH}/www-${DATE}.tar.gz -C $WWW_PATH ./

# Backup database
/usr/bin/mysqldump --databases -u $MYSQL_USERNAME --password=$MYSQL_PASSWORD $MYSQL_DATABASE > ${BACKUPS_PATH}/sql-${DATE}.sql

# Delete old backups
/usr/bin/find $BACKUPS_PATH -mtime +${COUNT_OF_BACKUPS_TO_STORE} -delete
