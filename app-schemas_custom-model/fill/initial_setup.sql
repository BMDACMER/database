GRANT ALL PRIVILEGES ON custom_model.* TO 'custom_model'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON common.* TO 'custom_model'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON bidder.* TO 'custom_model'@'%' WITH GRANT OPTION;

DELETE FROM common.supply_type;
DELETE FROM common.browser;
DELETE FROM common.carrier;
UPDATE common.dma SET country_id = null;
ALTER TABLE common.cities DROP FOREIGN KEY city_dma_fk;
DELETE FROM common.cities;
DELETE FROM common.region;
DELETE FROM bidder.country;
DELETE FROM bidder.country_group;
DELETE FROM common.device_model;
DELETE FROM common.device_make;
DELETE FROM common.operating_system_extended;
DELETE FROM common.operating_system;
DELETE FROM common.operating_system_family;

INSERT INTO bidder.custom_model_structure (id, name) VALUES (2, 'genie');

INSERT INTO common.supply_type VALUES (1,'web',0,'2014-06-18 14:04:28'),(2,'mobile_web',0,'2014-06-18 14:04:28'),(3,'mobile_app',0,'2014-06-18 14:04:28'),(4,'facebook_sidebar',0,'2014-06-18 14:04:28'),(5,'toolbar',1,'2013-02-20 20:09:35');
INSERT INTO common.dma (id, name, code, country_id) VALUES (738, 'test1', 738, null), (899, 'test2', 899, null), (1001, 'test3', 1001, null);

INSERT INTO api.inventory_url (id, url) VALUES (10, 'cnn.com'), (11, 'yahoo.com');
INSERT INTO common.inventory_url_list (id, name, url_list_type_id) VALUES (10, 'test1', 1), (11, 'test2', 1);
