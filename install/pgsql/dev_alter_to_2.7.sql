/**
 * Update to v2.7 - develop
 */

/*
 * 3/2/2022
 */
CREATE TABLE col.barcode (
	barcode_id serial NOT NULL,
	barcode_name varchar NOT NULL,
	barcode_code varchar NOT NULL DEFAULT 'QR',
	CONSTRAINT barcode_pk PRIMARY KEY (barcode_id)

);
-- ddl-end --
COMMENT ON TABLE col.barcode IS E'Models of barcodes usable';
-- ddl-end --
COMMENT ON COLUMN col.barcode.barcode_name IS E'Name of the model';
-- ddl-end --
COMMENT ON COLUMN col.barcode.barcode_code IS E'Value of the barcode used by the generating application, if occures. Default value: QR for QRcode';
-- ddl-end --
ALTER TABLE col.barcode OWNER TO collec;
-- ddl-end --

INSERT INTO col.barcode (barcode_name, barcode_code) VALUES (E'QRCode', E'QR');
-- ddl-end --
INSERT INTO col.barcode (barcode_name, barcode_code) VALUES (E'EAN 128', E'C128');
-- ddl-end --

alter table col.label add column barcode_id integer NOT null default 1;

ALTER TABLE col.label ADD CONSTRAINT barcode_fk FOREIGN KEY (barcode_id)
REFERENCES col.barcode (barcode_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE DEFERRABLE INITIALLY IMMEDIATE;

/**
 * 7/2/22
 */
alter table col.campaign add column uuid uuid NOT NULL DEFAULT gen_random_uuid();
COMMENT ON COLUMN col.campaign.uuid IS E'UUID of the campaign';

update col.dataset_type 
set fields =  E'["uid","uuid","identifier","wgs84_x","wgs84_y","location_accuracy","object_status_name","referent_name","referent_email","address_name","address_line2","address_line3","address_city","address_country","referent_phone","referent_firstname","academic_directory","academic_link","object_comment","identifiers","sample_creation_date","sampling_date","multiple_value","sampling_place_name","expiration_date","sample_type_name","storage_product","clp_classification","multiple_type_name","collection_name","metadata","metadata_unit","parent_uid","parent_uuid","parent_identifiers","web_address","content_type","container_uid","container_identifier","container_uuid","storage_type_name","fixed_value","country_code","country_origin_code","trashed","campaign_id","campaign_name","campaign_uuid"]'
where dataset_type_id = 1
;
-- ddl-end --'