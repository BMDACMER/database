-- direction: down
-- backref: 149263183600
-- ref: 149383891650

ALTER TABLE ratcontrol.settings_exclude_datacenters DROP CONSTRAINT settings_exclude_datacenters_pkey;

ALTER TABLE ratcontrol.settings_exclude_datacenters ADD PRIMARY KEY (settings_id);

