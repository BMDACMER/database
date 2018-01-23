-- direction: down
-- backref: 146583246120
-- ref: 148181960640
USE `custom_model`;

ALTER TABLE lre_lut
  DROP `created_on`,
  DROP `last_modified`,
  DROP `deleted`;

ALTER TABLE lre_hash
  DROP `last_modified`,
  DROP `deleted`;

ALTER TABLE lre_hash_coefficient
  DROP `created_on`,
  DROP `last_modified`;

ALTER TABLE lut_hash
  DROP `created_on`,
  DROP `last_modified`,
  DROP `deleted`;
