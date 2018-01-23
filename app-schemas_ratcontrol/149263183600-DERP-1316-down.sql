-- direction: down
-- backref: 149141288940
-- ref: 149263183600

ALTER TABLE ratcontrol.downstream_host DROP COLUMN type;
ALTER TABLE ratcontrol.log DROP COLUMN topic;

DROP TABLE ratcontrol.active_version;
DROP TABLE ratcontrol.bake_version;

