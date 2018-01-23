-- direction: up
-- backref: 146583246120
-- ref: 148181960640
USE `custom_model`;

ALTER TABLE lre_lut
  ADD COLUMN `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ADD COLUMN `deleted` tinyint(1) NOT NULL DEFAULT 0,
  ADD KEY `idx_last_modified_deleted` (`last_modified`, `deleted`);

ALTER TABLE lre_hash
  ADD COLUMN `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ADD COLUMN `deleted` tinyint(1) NOT NULL DEFAULT 0,
  ADD KEY `idx_last_modified_deleted` (`last_modified`, `deleted`);

ALTER TABLE lre_hash_coefficient
  ADD COLUMN `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE lut_hash
  ADD COLUMN `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ADD COLUMN `deleted` tinyint(1) NOT NULL DEFAULT 0,
  ADD KEY `idx_last_modified_deleted` (`last_modified`, `deleted`);
