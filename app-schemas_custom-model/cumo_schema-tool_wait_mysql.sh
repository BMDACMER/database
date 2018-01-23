#!/bin/bash
cat config.json | jq ".username=\"$MYSQL_USERNAME\"" | sponge config.json
cat config.json | jq ".password=\"$MYSQL_PASSWORD\"" | sponge config.json
cat config.json | jq ".host=\"$MYSQL_HOST\"" | sponge config.json
cat config.json | jq ".port=\"$MYSQL_PORT\"" | sponge config.json

function query_db() {
  echo "select 1" | mysql -N -h $MYSQL_HOST -u $MYSQL_USERNAME --password=$MYSQL_PASSWORD --port $MYSQL_PORT 2> /dev/null
}

function check_db_init() {
  echo "select count(*) from information_schema.tables where table_schema = 'revision' and table_name = 'custom_model_schemas_history'" | mysql -N -h $MYSQL_HOST -u $MYSQL_USERNAME --password=$MYSQL_PASSWORD --port $MYSQL_PORT 2> /dev/null
}

function execute_sql_file() {
  echo "running '$1'"
  mysql -u $MYSQL_USERNAME -h $MYSQL_HOST -p$MYSQL_PASSWORD --default-character-set=utf8 < "$1"
}

while [ "$(query_db)" != '1' ]; do
    sleep 1
    echo 'waiting for mysql...'
done

echo "found mysql"

# The order of these operations is important because of foreign keys between the tables!
if [ "$1" = "force" ] || [ "$(check_db_init)" != '1' ]; then
  echo "running 'schema init'"
  /usr/local/adnxs/schema-tool/schematool/schema.py init
  echo "running 'schema up'"
  /usr/local/adnxs/schema-tool/schematool/schema.py up

  execute_sql_file fill/initial_setup.sql
  execute_sql_file fill/domain.sql
  execute_sql_file fill/browser.sql
  execute_sql_file fill/carrier.sql
  execute_sql_file fill/country_region_postal_code.sql
  execute_sql_file fill/cities.sql
  execute_sql_file fill/device.sql
  execute_sql_file fill/os_and_mobile.sql
else
  echo "schema already initialized, running updates"
  /usr/local/adnxs/schema-tool/schematool/schema.py up
fi
