--**************************************************************
-- Crear las tablas requeridas con las relaciones necesarias. **
--**************************************************************

-- -----------------------------------------------------
-- Schema Store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS Store DEFAULT CHARACTER SET utf8 ;
USE Store ;

-- -----------------------------------------------------
-- Table store
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS store (
  sto_id INT NOT NULL AUTO_INCREMENT,
  sto_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (sto_id)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table supplier
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS supplier (
  sup_id INT NOT NULL AUTO_INCREMENT,
  sup_name VARCHAR(45) NOT NULL,
  sup_last_name VARCHAR(45) NOT NULL,
  create_at DATETIME NOT NULL,
  update_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (sup_id)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
  pro_id INT NOT NULL AUTO_INCREMENT,
  store_id INT NOT NULL,
  supplier_id INT NOT NULL,
  pro_name VARCHAR(45) NOT NULL,
  pro_price DOUBLE NOT NULL,
  create_at DATETIME NOT NULL,
  update_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (pro_id),
  INDEX fk_product_store1_idx (store_id ASC) VISIBLE,
  INDEX fk_product_supplier1_idx (supplier_id ASC) VISIBLE,
  CONSTRAINT fk_product_store1
    FOREIGN KEY (store_id)
    REFERENCES store (sto_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_product_supplier1
    FOREIGN KEY (supplier_id)
    REFERENCES supplier (sup_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table customer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer (
  cus_id INT NOT NULL AUTO_INCREMENT,
  cus_name VARCHAR(45) NOT NULL,
  cus_last_name VARCHAR(45) NOT NULL,
  cus_type_id VARCHAR(3) NOT NULL,
  cus_document VARCHAR(12) NOT NULL,
  create_at DATETIME NOT NULL,
  update_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (cus_id)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table seller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seller (
  sel_id INT NOT NULL AUTO_INCREMENT,
  store_id INT NOT NULL,
  sel_name VARCHAR(45) NOT NULL,
  sel_last_name VARCHAR(45) NOT NULL,
  create_at DATETIME NOT NULL,
  update_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (sel_id),
  INDEX fk_seller_store1_idx (store_id ASC) VISIBLE,
  CONSTRAINT fk_seller_store1
    FOREIGN KEY (store_id)
    REFERENCES store (sto_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table invoice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS invoice (
  inv_id INT NOT NULL AUTO_INCREMENT,
  customer_id INT NOT NULL,
  inv_date DATETIME NOT NULL,
  inv_total_invoice DOUBLE NOT NULL,
  inv_status INT NOT NULL,
  create_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (inv_id),
  INDEX fk_invoice_customer1_idx (customer_id ASC) VISIBLE,
  CONSTRAINT fk_invoice_customer1
    FOREIGN KEY (customer_id)
    REFERENCES customer (cus_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table invoice_has_product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS invoice_has_product (
  invpro_id INT NOT NULL AUTO_INCREMENT,
  invoice_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (invpro_id),
  INDEX fk_invoice_has_product_invoice1_idx (invoice_id ASC) VISIBLE,
  INDEX fk_invoice_has_product_product1_idx (product_id ASC) VISIBLE,
  UNIQUE INDEX inv_pro_id_UNIQUE (invoice_id ASC, product_id ASC) VISIBLE,
  CONSTRAINT fk_invoice_has_product_invoice1
    FOREIGN KEY (invoice_id)
    REFERENCES invoice (inv_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_invoice_has_product_product1
    FOREIGN KEY (product_id)
    REFERENCES product (pro_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;


--****************************************************************************************************
-- Llenar las tablas con información previa para poder manipular la base de datos a nivel de datos. **
--****************************************************************************************************

-- store
insert into store (sto_name) values ('Parkway, Inc.');
insert into store (sto_name) values ('Medpace Holdings, Inc.');

-- supplier
insert into supplier (sup_name, sup_last_name, create_at) values ('Malvina', 'Duckitt', '2021-04-03 06:33:46');
insert into supplier (sup_name, sup_last_name, create_at) values ('Cherey', 'Cattemull', '2021-03-21 02:22:01');

-- product
insert into product (store_id, supplier_id, pro_name, pro_price, create_at) values (1, 1, 'Rum - Light, Captain Morgan', '60548.56', '2021-12-23 11:22:00');
insert into product (store_id, supplier_id, pro_name, pro_price, create_at) values (1, 1, 'Sambuca Cream', '67771.24', '2021-07-03 19:30:39');
insert into product (store_id, supplier_id, pro_name, pro_price, create_at) values (1, 1, 'Doilies, Paper', '60483.63', '2021-12-16 22:06:37');
insert into product (store_id, supplier_id, pro_name, pro_price, create_at) values (1, 2, 'Tea Peppermint', '51775.91', '2021-03-18 23:49:54');
insert into product (store_id, supplier_id, pro_name, pro_price, create_at) values (1, 2, 'Soap - Hand Soap', '80291.99', '2021-03-14 19:55:45');
insert into product (store_id, supplier_id, pro_name, pro_price, create_at) values (1, 2, 'Calypso - Pineapple Passion', '29287.58', '2021-07-29 17:14:07');

-- customer
insert into customer (cus_name, cus_last_name, cus_type_id, cus_document, create_at) values ('Roselia', 'Fossey', 'TI', '126407868928', '2022-03-04 17:30:31');
insert into customer (cus_name, cus_last_name, cus_type_id, cus_document, create_at) values ('Ramonda', 'Kingcote', 'CC', '470597866871', '2022-03-03 10:30:16');
insert into customer (cus_name, cus_last_name, cus_type_id, cus_document, create_at) values ('Marie-ann', 'Hazeman', 'CC', '749996731663', '2022-03-07 19:20:11');
insert into customer (cus_name, cus_last_name, cus_type_id, cus_document, create_at) values ('Karole', 'Ineson', 'TI', '575365874133', '2022-03-01 16:35:46');
insert into customer (cus_name, cus_last_name, cus_type_id, cus_document, create_at) values ('Dierdre', 'Oaten', 'CC', '566791415337', '2022-03-01 16:59:15');
insert into customer (cus_name, cus_last_name, cus_type_id, cus_document, create_at) values ('Daisey', 'Marchbank', 'TI', '225200714880', '2022-03-07 14:26:56');

-- seller
insert into seller (store_id, sel_name, sel_last_name, create_at) values (1, 'Corene', 'Peregrine', '2022-03-01 03:43:36');
insert into seller (store_id, sel_name, sel_last_name, create_at) values (1, 'Wendye', 'Piffe', '2022-03-07 01:21:29');
insert into seller (store_id, sel_name, sel_last_name, create_at) values (1, 'Harrie', 'Iacobetto', '2022-03-07 15:13:54');
insert into seller (store_id, sel_name, sel_last_name, create_at) values (1, 'Arda', 'Pirrone', '2022-03-03 11:38:04');
insert into seller (store_id, sel_name, sel_last_name, create_at) values (1, 'Daphna', 'Roglieri', '2022-03-06 14:33:49');
insert into seller (store_id, sel_name, sel_last_name, create_at) values (1, 'Melessa', 'Donavan', '2022-03-05 14:59:48');

-- invoice
insert into invoice (customer_id, inv_date, inv_total_invoice, inv_status) values (1, '2021-12-06 17:19:47', '1000.00', 1);
insert into invoice (customer_id, inv_date, inv_total_invoice, inv_status) values (2, '2022-01-09 01:37:53', '2000.00', 1);
insert into invoice (customer_id, inv_date, inv_total_invoice, inv_status) values (3, '2021-12-04 12:37:44', '3000.00', 1);
insert into invoice (customer_id, inv_date, inv_total_invoice, inv_status) values (4, '2022-03-01 00:08:25', '4000.00', 1);
insert into invoice (customer_id, inv_date, inv_total_invoice, inv_status) values (5, '2021-06-10 07:32:21', '5000.00', 1);
insert into invoice (customer_id, inv_date, inv_total_invoice, inv_status) values (6, '2021-06-30 12:13:01', '6000.00', 1);

-- invoice_has_product
insert into invoice_has_product (invoice_id, product_id) values (1, 1);
insert into invoice_has_product (invoice_id, product_id) values (1, 3);
insert into invoice_has_product (invoice_id, product_id) values (1, 5);
insert into invoice_has_product (invoice_id, product_id) values (2, 2);
insert into invoice_has_product (invoice_id, product_id) values (2, 1);
insert into invoice_has_product (invoice_id, product_id) values (2, 6);
insert into invoice_has_product (invoice_id, product_id) values (3, 3);
insert into invoice_has_product (invoice_id, product_id) values (3, 4);
insert into invoice_has_product (invoice_id, product_id) values (3, 5);

--******************************************************************************
-- Realizar dos borrados lógicos y dos borrados físicos de ventas realizadas. **
--******************************************************************************

-- Borrado Físico
DELETE FROM invoice
WHERE inv_id = 1;

DELETE FROM invoice
WHERE inv_id = 2;

-- Borrado Lógico
UPDATE invoice SET inv_status = 0 WHERE inv_id = 3;
UPDATE invoice SET inv_status = 0 WHERE inv_id = 4;
SELECT inv.inv_id, inv.inv_date, cus.cus_name, cus.cus_last_name, cus.cus_type_id, cus.cus_document, inv.inv_total_invoice
FROM invoice inv
INNER JOIN customer cus
    ON inv.customer_id = cus.cus_id
WHERE inv.inv_status != 0;

--*********************************************************************
-- Modificar tres productos en su nombre y proveedor que los provee. **
--*********************************************************************

UPDATE product
SET pro_name = 'Bar - Sweet And Salty Chocolate', supplier_id = 2
WHERE pro_id = 4;

UPDATE product
SET pro_name = 'Pheasants - Whole', supplier_id = 2
WHERE pro_id = 5;

UPDATE product
SET pro_name = 'Lychee - Canned', supplier_id = 2
WHERE pro_id = 6;
