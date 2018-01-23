FROM eos-registry-v2.dspnxs.net/rtpapi/schema-tool:0.2
ENV MYSQL_HOST 127.0.0.1
ENV MYSQL_USERNAME root
ENV MYSQL_PASSWORD root
ENV MYSQL_PORT 3306

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
  jq \
  moreutils \
  mysql-client

# setup schema files
RUN mkdir -p /usr/local/dspnxs/schemas/custom_model_schemas/DBA_FILES
RUN mkdir -p /usr/local/dspnxs/schemas/api_schemas/DBA_FILES
COPY ./DBA_FILES/*.sql /usr/local/dspnxs/schemas/custom_model_schemas/DBA_FILES/
COPY ./fill/*.sql /usr/local/dspnxs/schemas/custom_model_schemas/fill/
COPY ./*.sql /usr/local/dspnxs/schemas/custom_model_schemas/
COPY ./config.xsson /usr/local/dspnxs/schemas/custom_model_schemas/
COPY cumo_schema-tool_wait_mysql.sh /usr/local/bin/cumo_schema-tool_wait_mysql.sh

COPY ./pappy/api-schemas/DBA_FILES/*.sql /usr/local/dspnxs/schemas/api_schemas/DBA_FILES/
COPY ./pappy/api-schemas/fill/*.sql /usr/local/dspnxs/schemas/api_schemas/fill/
COPY ./pappy/api-schemas/*.sql /usr/local/dspnxs/schemas/api_schemas/
COPY ./pappy/api-schemas/config.xsson /usr/local/dspnxs/schemas/api_schemas/
COPY api_schema-tool_wait_mysql.sh /usr/local/bin/api_schema-tool_wait_mysql.sh
COPY update_schemas.sh /usr/local/bin/update_schemas.sh

# shell script to wait for mysql then run schema tool is default executable
CMD ["/bin/bash", "update_schemas.sh"]

