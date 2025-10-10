-- varchar a length
-- char a fixed amt of length
-- text any length

-- !! Create syntaxa
-- logic behind creating tables if there's multiple selections or types best for a table
-- anything that gets in the way of modelling a 'singular object should be put into another table

-- CREATE TABLE customer (
--   first_name VARCHAR(30) NOT NULL,
--   last_name VARCHAR(30) NOT NULL,
--   email VARCHAR(60) NOT NULL,
--   company VARCHAR(60) NOT NULL,
--   street VARCHAR(50) NOT NULL,
--   city VARCHAR(40) NOT NULL,
--   state CHAR(2) NOT NULL,
--   zip INTEGER NOT NULL,
--   phone VARCHAR(20) NOT NULL,
--   birth_date DATE NULL,
--   sex CHAR(1) NOT NULL,
--   date_entered TIMESTAMP NOT NULL,
--   id SERIAL PRIMARY KEY
-- );

-- CREATE TABLE sales_person (
--   first_name VARCHAR(30) NOT NULL,
--   last_name VARCHAR(30) NOT NULL,
--   email VARCHAR(60) NOT NULL,
--   street VARCHAR(60) NOT NULL,
--   city VARCHAR(40) NOT NULL,
--   state CHAR(2) NOT NULL DEFAULT 'PA',
--   zip INTEGER NOT NULL,
--   phone VARCHAR(20) NOT NULL,
--   birth_date DATE NOT NULL,
--   sex sex_type NOT NULL,
--   date_hired TIMESTAMP NOT NULL,
--   id SERIAL PRIMARY KEY
-- );

-- CREATE TABLE product_type (
--   name VARCHAR(30) NOT NULL,
--   id SERIAL PRIMARY KEY
-- );


-- describes the quality of the item 
-- CREATE TABLE product (
--   type_id INTEGER,  --- CAN INSGTEAD WRITE type_id INTEGER REFERENCES product_type(id)
--   name VARCHAR(30) NOT NULL,
--   supplier VARCHAR(30) NOT NULL,
--   description TEXT NOT NULL,
--   id SERIAL PRIMARY KEY, 
--   CONSTRAINT fk_product_type
--   	FOREIGN KEY(type_id)
-- 	  REFERENCES product_type(id)
-- );

--describes the actual item being sold
-- CREATE TABLE item (
--   product_id INTEGER REFERENCES product(id),
--   name VARCHAR(30) NOT NULL,
--   color VARCHAR(30) NOT NULL,
--   picture VARCHAR(256) NOT NULL,
--   price NUMERIC(6,2) NOT NULL,
--  id SERIAL PRIMARY KEY
-- );

-- !!!sales order table
-- CREATE TABLE sales_order (
--   cust_id INTEGER REFERENCES customer(id),
--   sales_person_id INTEGER REFERENCES sales_person(id),
--   purchase_order_number BIGINT NOT NULl,
--   order_time TIMESTAMP NOT NULL,
--   credit_card_number VARCHAR(16) NOT NULL,
--   credit_card_expire_month SMALLINT NOT NULL,
--   credit_card_expire_year SMALLINT NOT NULL,
--   credit_card_secret_code SMALLINT NOT NULL,
--   name_on_card VARCHAR(100) NOT NULL,
--   id SERIAL PRIMARY KEY
-- );

-- !FINAL SALES ITEM table
-- CREATE TABLE sales_item (
--   item_id INTEGER REFERENCES item(id),
--   sales_order_id INTEGER REFERENCES sales_order(id),
--   quantity INTEGER NOT NULL,
--   discount NUMERIC(3,2) NULL DEFAULT 0,
--   taxable BOOLEAN NOT NULL DEFAULT FALSE,
--   sales_tax_rate NUMERIC(5,2) NOT NULL DEFAULT 0,
--   id SERIAL PRIMARY KEY
-- );



-- !! ALT Just say type_id INTEGER REFERENCE product_type(id)

-- !!INSERT SYNTAX

-- INSERT INTO customer (
--   first_name, last_name, email, company, street, city, state, zip, phone, birth_date, sex, date_entered
-- )
-- VALUES
--   ('Toni', 'Rivera', 'toni@example.com', 'Modular Minds Inc.', '123 Circuit Lane', 'Pavia', 'WV', 5001, '0917-123-4567', '1990-05-12', 'F', CURRENT_TIMESTAMP),
--   ('Alex', 'Santos', 'alex@example.com', 'TraitWorks', '456 Logic St.', 'Iloilo', 'WV', 5000, '0918-987-6543', '1988-11-03', 'M', CURRENT_TIMESTAMP);


-- !!CUSTOM DATA TYPES 

-- CREATE TYPE sex_type as enum ('M', 'F');

-- !! ALTERING TABLE DATA (MANY EXAMPLES)
-- ALTER TABLE customer
-- -- !! CAST OPERATOR (::) cast current values in sex as sex_type
-- ALTER COLUMN sex TYPE sex_type USING sex::sex_type;
-- add column
-- ALTER TABLE sales_item ADD day_of_week VARCHAR(8);
-- ALTER TABLE sales_item ALTER COLUMN day_of_week SET NOT NULL;
-- ALTER TABLE sales_item RENAME COLUMN day_of_week to weekday;
-- ALTER TABLE sales_item DROP COLUMN weekday;
-- CREATE TABLE transaction_type(
-- name VARCHAR(30) NOT NULL, 
-- payment_type VARCHAR(30) NOT NULL, 
-- id SERIAL PRIMARY KEY
-- );
-- ALTER TABLE transaction_type RENAME TO "transaction";
-- delete all data in table
-- TRUNCATE TABLE transaction;
-- delete the actual table
-- DROP TABLE transaction;
-- inserting for more data

-- INSERT INTO product_type(name) VALUES ('Business');
-- INSERT INTO product_type(name) VALUES ('Casual');
-- INSERT INTO product_type(name) VALUES ('Athletic');
-- INSERT INTO product (type_id, name, supplier, description) VALUES
--   (1, 'Allen Edmonds', 'Allen Edmonds', 'Classic broguing adds texture to a charming longwing derby crafted'),
--   (1, 'Allen Edmonds', 'Allen Edmonds', 'Sharp broguing touches up a charming, American-made derby fashioned'),
--   (1, 'John Varvatos', 'John Varvatos', 'Leather upper, manmade sole'),
--   (1, 'Johnston & Murphy', 'Johnston & Murphy', 'Leather upper, manmade sole'),
--   (1, 'Johnston & Murphy', 'Johnston & Murphy', 'Suede upper, manmade sole'),
--   (1, 'Mezlan', 'Mezlan', 'Contrast insets at the toe and sides bring updated attitude to a retro'),

--   (2, 'Nike Air 270 React', 'Nike', 'The reggae inspired Nike Air 270 React fuses street fashion with a rich'),
--   (2, 'Nike Bead Foam', 'Nike', 'Tiny foam beads underfoot conform to your foot for cushioning'),
--   (2, 'Stacy Adams Icon', 'Stacy Adams', 'A modern take on the icon that blends classic style and fresh street'),
--   (2, 'Stacy Adams Loaf', 'Stacy Adams', 'Just know that now it still strikes a just-right balance of ON LOAF softness'),

--   (3, 'Brooks Ghost', 'Brooks', 'Style to spare, now even softer.'),
--   (3, 'Brooks Plush', 'Brooks', 'A plush fit and super soft transitions make every stride luxurious');
-- SELECT product.*, product_type.name AS product_name FROM product JOIN product_type ON product_type.id = product.type_id;
-- ALTER TABLE customer ALTER COLUMN zip TYPE INTEGER;
-- ALTER TABLE sales_person ALTER COLUMN zip TYPE INTEGER;


-- INSERT INTO sales_person (
--   first_name, last_name, email, street, city, state, zip, phone,
--   birth_date, sex, date_hired
-- ) VALUES
-- ('James', 'Anderson', 'james.anderson@shoeco.com', '101 Market St', 'Philadelphia', 'PA', 19107, '215-555-0191', '1980-05-14', 'M', CURRENT_TIMESTAMP),
-- ('Linda', 'Nguyen', 'linda.nguyen@shoeco.com', '202 Walnut Ave', 'Pittsburgh', 'PA', 15222, '412-555-0173', '1985-08-22', 'F', CURRENT_TIMESTAMP),
-- ('Carlos', 'Ramirez', 'carlos.ramirez@shoeco.com', '303 Chestnut Blvd', 'Harrisburg', 'PA', 17101, '717-555-0134', '1990-03-09', 'M', CURRENT_TIMESTAMP),
-- ('Emily', 'Chen', 'emily.chen@shoeco.com', '404 Spruce St', 'Scranton', 'PA', 18503, '570-555-0188', '1992-11-30', 'F', CURRENT_TIMESTAMP),
-- ('Robert', 'Lee', 'robert.lee@shoeco.com', '505 Pine Rd', 'Erie', 'PA', 16501, '814-555-0166', '1987-06-18', 'M', CURRENT_TIMESTAMP),
-- ('Sophia', 'Taylor', 'sophia.taylor@shoeco.com', '606 Maple Ln', 'Allentown', 'PA', 18101, '610-555-0142', '1994-01-25', 'F', CURRENT_TIMESTAMP),
-- ('David', 'Clark', 'david.clark@shoeco.com', '707 Cedar Ct', 'Lancaster', 'PA', 17602, '717-555-0199', '1982-09-12', 'M', CURRENT_TIMESTAMP),
-- ('Olivia', 'White', 'olivia.white@shoeco.com', '808 Birch Way', 'Bethlehem', 'PA', 18015, '610-555-0177', '1996-04-03', 'F', CURRENT_TIMESTAMP);


-- INSERT INTO item (product_id, name, color, picture, price) VALUES
-- (1, 'AE Longwing', 'Brown', 'images/ae_longwing_brown.jpg', 289.99),
-- (2, 'AE Derby', 'Black', 'images/ae_derby_black.jpg', 279.99),
-- (3, 'JV Classic', 'Tan', 'images/jv_classic_tan.jpg', 199.99),
-- (4, 'JM Leather', 'Cognac', 'images/jm_leather_cognac.jpg', 189.99),
-- (5, 'JM Suede', 'Navy', 'images/jm_suede_navy.jpg', 179.99),
-- (6, 'Mezlan Retro', 'Burgundy', 'images/mezlan_retro_burgundy.jpg', 249.99),
-- (7, 'Nike 270 React', 'Multicolor', 'images/nike_270_multicolor.jpg', 159.99),
-- (8, 'Nike Bead Foam', 'White', 'images/nike_beadfoam_white.jpg', 149.99),
-- (9, 'Stacy Icon', 'Charcoal', 'images/stacy_icon_charcoal.jpg', 139.99),
-- (10, 'Stacy Loaf', 'Olive', 'images/stacy_loaf_olive.jpg', 129.99),
-- (11, 'Brooks Ghost', 'Gray', 'images/brooks_ghost_gray.jpg', 119.99),
-- (12, 'Brooks Plush', 'Blue', 'images/brooks_plush_blue.jpg', 129.99);


-- INSERT INTO sales_order (
--   cust_id, sales_person_id, purchase_order_number, order_time,
--   credit_card_number, credit_card_expire_month, credit_card_expire_year,
--   credit_card_secret_code, name_on_card
-- ) VALUES
-- (1, 1, 100000001, CURRENT_TIMESTAMP, '4111111111111111', 12, 2026, 123, 'Matthew Martinez'),
-- (2, 2, 100000002, CURRENT_TIMESTAMP, '5500000000000004', 11, 2025, 456, 'Melissa Moore'),
-- (1, 3, 100000003, CURRENT_TIMESTAMP, '340000000000009', 10, 2027, 789, 'Matthew Martinez'),
-- (2, 4, 100000004, CURRENT_TIMESTAMP, '6011000000000004', 9, 2026, 321, 'Melissa Moore');

-- INSERT INTO sales_item (
--   item_id, sales_order_id, quantity, discount, taxable, sales_tax_rate
-- ) VALUES
-- (1, 9, 2, 5.00, TRUE, 7.50),
-- (2, 9, 1, 0.00, FALSE, 7.50),
-- (3, 10, 3, 3.50, TRUE, 7.50),
-- (4, 10, 1, 0.00, TRUE, 7.50),
-- (5, 11, 2, 2.75, TRUE, 7.50),
-- (6, 11, 1, 0.00, TRUE, 7.50),
-- (7, 12, 1, 0.00, TRUE, 7.50),
-- (8, 12, 2, 2.75, TRUE, 7.50);








-- !!Getting data
-- select * from customer where id = 1;
-- select * from sales_item where discount > 0.1;
-- !! LOGICAL AND OR NOT + ordering + limit
-- select * from sales_item where discount > 0.1 or taxable = false
-- order by discount DESC
-- limit 2;
-- !! MODIFY RETRUNED WITH ALIAS AND CONCAT
-- select concat(first_name, ' ', last_name) as name, phone, state from customer;
--!! MODIFY With sum()
-- returns one show per product id 
-- select product_id, SUM(price) AS total from item where  product_id = 1 group by product_id;
-- !! DINSTINCT RETURNS ALL DISTINCT TYPES OF WHAT"S BEIGN SELECTED
-- select distinct state
-- from customer where state !='CA' IF ONLY selected
-- from customer where state in ('CA', 'WX')
-- order by state;


-- ! CREATE DATA FROM MULTIPELE TABLE
-- inner join

-- select product_id, price from item inner join sales_item on sales_item.item_id = item.id order by product_id desc;

-- left outer join returns all tables of the left ven wheno no matching example all tasks even those that aren't complete from the left table
-- show all products even never sold (when traits are optional)
-- exampel when getting orders if one customer had no orders will not shww in an inner join but will show in left join (customer is left table	)


-- using regex
-- get name that starts with a letter make lower)
-- use LIKE for wildcards SIMILAR to for cmplex patterns matching like SIMILAR TO '(a|b)%'
-- select concat(first_name ,' ' , last_name) as customer_name from customer where lower(first_name) similar to 't%';


-- using extract, count, groupby and having 

-- select extract(month from birth_date) as  month, count(*) as amount
-- from customer 
-- group by month 
-- having count(*) < 2
-- order by month;

-- using views to get wanted data and create a view, to display data
-- every column selected must appear in group by
-- create view product_name_type as
-- select product.type_id, product.name, product_type.name as product_name 
-- from product 
-- join product_type 
-- on product_type.id = product.type_id
-- order by type_id; 

-- views can be used for all function sexpect distint and aggrate
-- select * from product_name_type;
-- drop view to drop views