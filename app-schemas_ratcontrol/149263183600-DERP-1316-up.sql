-- direction: up
-- backref: 149141288940
-- ref: 149263183600

\c ratcontrol;
ALTER TABLE ratcontrol.downstream_host ADD COLUMN type varchar(20) references ratcontrol.downstream_host_type(name);
ALTER TABLE ratcontrol.log ADD COLUMN topic varchar(255);

CREATE TABLE ratcontrol.active_version (
    upstream_packrat_set_id bigint references ratcontrol.upstream_packrat_set(id) PRIMARY KEY,
    packrat_config_id bigint references ratcontrol.packrat_config(id) NOT NULL
);

CREATE TABLE ratcontrol.bake_version (
    upstream_packrat_set_id bigint references ratcontrol.upstream_packrat_set(id) PRIMARY KEY,
    packrat_config_id bigint references ratcontrol.packrat_config(id) NOT NULL
);



