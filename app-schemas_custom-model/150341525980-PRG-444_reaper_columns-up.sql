-- direction: up
-- backref: 149494875490
-- ref: 150341525980

USE `custom_model`;

ALTER TABLE `custom_model`
	ADD COLUMN `deleted` tinyint(1) NOT NULL DEFAULT '0',
    ADD COLUMN `client_last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ADD COLUMN `is_expired` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'flags whether the custom model object expired for inactivity',
    ADD INDEX `idx_deleted` (`deleted`),
    ADD INDEX `idx_is_expired` (`is_expired`),
    ADD INDEX `idx_client_last_modified` (`client_last_modified`),
    algorithm=inplace;
