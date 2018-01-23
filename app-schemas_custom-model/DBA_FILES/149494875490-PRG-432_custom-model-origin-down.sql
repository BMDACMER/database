-- direction: down
-- backref: 148190710930
-- ref: 149494875490

USE `custom_model`;

ALTER TABLE `custom_model` DROP COLUMN `origin`;

-- start rev query
DELETE FROM `revision`.`custom_model_schemas_history` WHERE alter_hash = '149494875490';
-- end rev query
