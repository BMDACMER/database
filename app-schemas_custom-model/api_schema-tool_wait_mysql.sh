#!/bin/bash
cat config.xsson | jq ".username=\"$MYSQL_USERNAME\"" | sponge config.xsson
cat config.xsson | jq ".password=\"$MYSQL_PASSWORD\"" | sponge config.xsson
cat config.xsson | jq ".host=\"$MYSQL_HOST\"" | sponge config.xsson
cat config.xsson | jq ".port=\"$MYSQL_PORT\"" | sponge config.xsson

function query_db() {
  echo "select 1" | mysql -N -h $MYSQL_HOST -u $MYSQL_USERNAME --password=$MYSQL_PASSWORD --port $MYSQL_PORT 2> /dev/null
}

function check_db_init() {
  echo "select count(*) from information_schema.tables where table_schema = 'revision' and table_name = 'api_schemas_history'" | mysql -N -h $MYSQL_HOST -u $MYSQL_USERNAME --password=$MYSQL_PASSWORD --port $MYSQL_PORT 2> /dev/null
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

# The order of those operations is important because of foreign keys between tables!
if [ "$1" = "force" ] || [ "$(check_db_init)" != '1' ]; then
  echo "running 'schema init'"
  /usr/local/dspnxs/schema-tool/schematool/schema.py init
  echo "running 'schema up'"
  /usr/local/dspnxs/schema-tool/schematool/schema.py up

  execute_sql_file fill/data.sql
  execute_sql_file fill/mysql_timezones.sql
  execute_sql_file fill/contract_db.sql
  execute_sql_file fill/contractdb_data.sql
  execute_sql_file fill/opt_meta_db.sql
else
  echo "schema already initialized, running updates"
  /usr/local/dspnxs/schema-tool/schematool/schema.py up
fi
