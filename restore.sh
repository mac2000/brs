#!/bin/sh

# SETTINGS
# ----------------------------------------------------------------
  MYSQL_USERNAME=[USERNAME]   # example: root
  MYSQL_PASSWORD=[PASSWORD]   # example: ****
  MYSQL_DATABASE=[DATABASE]   # example: wordpress

  WWW_PATH=[WWW_PATH]         # example: /home/wordpress/public_html
  BACKUPS_PATH=[BACKUPS_PATH] # example: /home/wordpress/backups
# ----------------------------------------------------------------

# Remove trailing slashes
WWW_PATH=`echo "${WWW_PATH}" | sed -e "s/\/*$//" `
BACKUPS_PATH=`echo "${BACKUPS_PATH}" | sed -e "s/\/*$//" `

LAST_WWW_BACKUP=$(ls ${BACKUPS_PATH}/www-*.tar.gz | tail -n 1)
LAST_SQL_BACKUP=$(ls ${BACKUPS_PATH}/sql-*.sql | tail -n 1)

# Restore files
/bin/tar -xpzf $LAST_WWW_BACKUP -C $WWW_PATH

# Restore database
/usr/bin/mysql -u $MYSQL_USERNAME --password=$MYSQL_PASSWORD $MYSQL_DATABASE < $LAST_SQL_BACKUP
