-- direction: up
-- ref: 146583246120

CREATE DATABASE `custom_model`
  CHARACTER SET = 'utf8mb4'
  COLLATE = 'utf8mb4_unicode_ci';

USE `custom_model`;

-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- Internal tables, not intended to be read outside app_custom-model.
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

CREATE TABLE `custom_model` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'an additional field for clients to use however they please',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name of the custom model, specified by client',
  `member_id` int unsigned NOT NULL,
  `model_text` mediumtext NOT NULL COLLATE utf8mb4_unicode_ci COMMENT 'this is the human readable representation of the model',
  `compiled_text` mediumtext NOT NULL COLLATE utf8mb4_unicode_ci COMMENT 'this is the executable image of the model',
  `custom_model_structure` varchar(100) NOT NULL COLLATE utf8mb4_unicode_ci COMMENT 'the type of custom model code',
  `model_output` varchar(100) NOT NULL COLLATE utf8mb4_unicode_ci COMMENT 'the output type of the custom model',
  `active` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'flags whether the custom model object is active or not',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_member_name` (`member_id`,`name`),
  UNIQUE KEY `unique_custom_model_member_code` (`member_id`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='optimization and prediction model table';


--
-- Table structure for lre_hash.
-- can only create/delete
--
CREATE TABLE `lre_hash` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `hash_function` varchar(255) NOT NULL COLLATE utf8mb4_unicode_ci,
  `hash_table_size_log` int unsigned NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;


--
-- Table structure for lre_hash_coefficient.
-- can only create/delete
--
CREATE TABLE `lre_hash_coefficient` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `hash_id` int unsigned NOT NULL,
  `bucket_index0` bigint unsigned NOT NULL,
  `bucket_index1` bigint unsigned NOT NULL,
  `weight` double NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_predictor_hash_bucket_index` (`hash_id`,`bucket_index0`, `bucket_index1`),
  CONSTRAINT `lre_hash_lre_hash_coefficient_fk` FOREIGN KEY (`hash_id`) REFERENCES `lre_hash` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;


--
-- Table structure for lre_lut.
-- can only create/delete
--
CREATE TABLE `lre_lut` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `json` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;


--
-- Table structure for lre_lut.
-- can only create/delete
-- represents a mapping from a lookup table to a hash indexed table of buckets and their weights
--
CREATE TABLE `lut_hash` (
  `lut_id` int unsigned NOT NULL,
  `hash_id` int unsigned NOT NULL,
  `hash_predictor_json` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`lut_id`),
  CONSTRAINT `lre_hash_lut_hash_fk` FOREIGN KEY (`hash_id`) REFERENCES `lre_hash` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `lre_lut_lut_hash_fk` FOREIGN KEY (`lut_id`) REFERENCES `lre_lut` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;



-- start rev query
INSERT INTO `revision`.`custom_model_schemas_history` (alter_hash, ran_on) VALUES ('146583246120', NOW());
-- end rev query
