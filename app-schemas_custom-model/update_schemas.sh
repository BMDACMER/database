#!/bin/bash
cd /usr/local/dspnxs/schemas/api_schemas/
echo 'running api schema update...'
/bin/bash /usr/local/bin/api_schema-tool_wait_mysql.sh
echo 'api schema update complete'

cd /usr/local/dspnxs/schemas/custom_model_schemas/
echo 'running cumo schema update...'
/bin/bash /usr/local/bin/cumo_schema-tool_wait_mysql.sh
echo 'cumo schema update complete'
