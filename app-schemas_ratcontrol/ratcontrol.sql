CREATE SCHEMA IF NOT EXISTS ratcontrol;
-- packrat datacenters
CREATE TABLE ratcontrol.datacenter (
    name varchar(20) PRIMARY KEY
);
INSERT INTO ratcontrol.datacenter VALUES ('nym2');
INSERT INTO ratcontrol.datacenter VALUES ('lax1');
INSERT INTO ratcontrol.datacenter VALUES ('ams1');
INSERT INTO ratcontrol.datacenter VALUES ('fra1');
INSERT INTO ratcontrol.datacenter VALUES ('sin1');

-- packrat environments
CREATE TABLE ratcontrol.environment (
    name varchar(20) PRIMARY KEY
);

INSERT INTO ratcontrol.environment VALUES ('dev');
INSERT INTO ratcontrol.environment VALUES ('prod');

-- packrat serialization formats
CREATE TABLE ratcontrol.message_format (
    name varchar(20) NOT NULL PRIMARY KEY
);

INSERT INTO ratcontrol.message_format VALUES ('protobuf');
INSERT INTO ratcontrol.message_format VALUES ('native');
INSERT INTO ratcontrol.message_format VALUES ('native2');
INSERT INTO ratcontrol.message_format VALUES ('tabdelim');

-- represents a group of packrats with the same
-- datacenter, environment, and collection.
CREATE TABLE ratcontrol.upstream_packrat_set (
    id bigserial PRIMARY KEY,
    datacenter varchar(20) references ratcontrol.datacenter(name),
    environment varchar(20) references ratcontrol.environment(name),
    collection varchar(20) NOT NULL,
    UNIQUE (datacenter, environment, collection)
);

-- filters packrat can apply to data
CREATE TABLE ratcontrol.filter_type (
    name varchar(20) NOT NULL PRIMARY KEY
);

-- different kinds of downstream_hosts that will require
-- different request formats from packrat
CREATE TABLE ratcontrol.downstream_host_type(
    name varchar(20) NOT NULL PRIMARY KEY
);

INSERT INTO ratcontrol.downstream_host_type VALUES ('kafka');
INSERT INTO ratcontrol.downstream_host_type VALUES ('kafka_forwarder');
INSERT INTO ratcontrol.downstream_host_type VALUES ('azure_forwarder');

-- properties that can be set at the host or log level
CREATE TABLE ratcontrol.settings (
    id bigserial PRIMARY KEY,
    is_ephemeral boolean,
    message_format varchar(20) references ratcontrol.message_format(name),
    shard_divisor integer,
    send_shards integer[],
    shard_key varchar(100),
    filter_type varchar(10) references ratcontrol.filter_type(name),
    filter_field varchar(100),
    filter_values integer[],
    sample_pct integer);

-- a row in this table represents a datacenter whose traffic
-- packrat will exclude when sending to a downstream_host
CREATE TABLE ratcontrol.settings_exclude_datacenters (
    settings_id integer references ratcontrol.settings(id) PRIMARY KEY,
    datacenter varchar(20) references ratcontrol.datacenter(name)
);

-- a host that an upstream_packrat_set sends data to
CREATE TABLE ratcontrol.downstream_host (
    id serial PRIMARY KEY,
    send_all boolean,
    upstream_packrat_set_id integer references ratcontrol.upstream_packrat_set(id),
    hostname varchar(255) NOT NULL,
    port integer NOT NULL,
    only_flush_full_buffers boolean,
    settings_id integer references ratcontrol.settings(id),
    UNIQUE(hostname, port, upstream_packrat_set_id),
    UNIQUE(settings_id)
    );

-- a log for a particular downstream_host
CREATE TABLE ratcontrol.log (
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    downstream_host_id integer references ratcontrol.downstream_host(id),
    settings_id integer references ratcontrol.settings(id),
    UNIQUE(name, downstream_host_id),
    UNIQUE(settings_id));

-- where we store a freshly-generated packrat config every time changes
-- are made
CREATE TABLE ratcontrol.packrat_config(
    id serial PRIMARY KEY,
    upstream_packrat_set_id integer references ratcontrol.upstream_packrat_set(id),
    config text NOT NULL
);

-- the types of changes that can be made to settings via the api
CREATE TABLE ratcontrol.operation (
    name varchar(20) primary key
);
INSERT INTO ratcontrol.operation VALUES ('add');
INSERT INTO ratcontrol.operation VALUES ('update');
INSERT INTO ratcontrol.operation VALUES ('delete');

--- objects that can be modified in the api
CREATE TABLE ratcontrol.objects (
    name varchar(20) primary key
);

INSERT INTO ratcontrol.objects VALUES ('downstream_host');
INSERT INTO ratcontrol.objects VALUES ('upstream_packrat_set');
INSERT INTO ratcontrol.objects VALUES ('log');

-- a log of all operations made via the api
CREATE TABLE ratcontrol.history (
    id serial primary key,
    username varchar(20),
    operation varchar(20) references ratcontrol.operation(name) NOT NULL,
    object_id integer NOT NULL,
    object_name varchar(20) references ratcontrol.objects(name) NOT NULL,
    created_on timestamp WITH time zone DEFAULT now(),
    VALUES text
);
