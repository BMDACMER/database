-- direction: down
-- backref: 149494875490
-- ref: 150341525980

USE `custom_model`;

ALTER TABLE `custom_model`
	DROP INDEX `idx_deleted`,
    DROP INDEX `idx_is_expired`,
    DROP INDEX `idx_client_last_modified`,
    DROP COLUMN `deleted`,
    DROP COLUMN `client_last_modified`,
    DROP COLUMN `is_expired`;


-- start rev query
DELETE FROM `revision`.`custom_model_schemas_history` WHERE alter_hash = '150341525980';
-- end rev query
