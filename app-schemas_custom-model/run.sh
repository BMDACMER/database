#!/bin/sh
docker build -t cm_schema .
docker network create test_schema
docker kill mariadb
docker rm mariadb
docker run -d --net=test_schema -e MYSQL_ROOT_PASSWORD=root -p 3307:3306 --name=mariadb mariadb
docker kill schema
docker rm schema
docker run -it --net=test_schema --name=schema cm_schema
