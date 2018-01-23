-- direction: up
-- backref: 148182052990
-- ref: 148190710930

USE `custom_model`;

ALTER TABLE lre_hash ADD COLUMN member_id int unsigned NOT NULL;
ALTER TABLE lre_lut ADD COLUMN member_id int unsigned NOT NULL;
