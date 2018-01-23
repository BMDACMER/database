-- direction: up
-- backref: 148190710930
-- ref: 149494875490

USE `custom_model`;

ALTER TABLE `custom_model` ADD COLUMN `origin` tinyint(3) NOT NULL DEFAULT 0 COMMENT 'Indicates if the model is an external client model (0) or an internal AN one (1)';


-- start rev query
INSERT INTO `revision`.`custom_model_schemas_history` (alter_hash, ran_on) VALUES ('149494875490', NOW());
-- end rev query
