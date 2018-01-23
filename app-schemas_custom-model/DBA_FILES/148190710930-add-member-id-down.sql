-- direction: down
-- backref: 148182052990
-- ref: 148190710930

USE `custom_model`;

ALTER TABLE lre_hash DROP COLUMN member_id;
ALTER TABLE lre_lut DROP COLUMN member_id;


-- start rev query
DELETE FROM `revision`.`custom_model_schemas_history` WHERE alter_hash = '148190710930';
-- end rev query
