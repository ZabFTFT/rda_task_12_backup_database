#! /bin/bash
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

if [ -z "${DB_USER}" ] || [ -z "${DB_PASSWORD}" ]; then
  echo "ENV variables are not set"
  exit 1
fi

# Full backup
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --result-file=full_backup.sql --no-create-db
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < full_backup.sql

# Data backup
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --result-file=data_backup.sql --no-create-info --no-create-db
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < data_backup.sql
