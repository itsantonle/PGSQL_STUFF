-- create or replace function fn_add_int(int, int)
-- returns int as 
-- $body$ 
-- SELECT $1 + $2;
-- $body$ 
-- Language SQL --using the SQL LANGUAGE

-- SELECt fn_add_int(4,5);


-- create or replace function fn_update_sales_person()
-- returns void as 
-- $body$
--  update sales_person
--  set state  = 'PA'
--  where state = null
-- $body$

-- language SQL

CREATE OR REPLACE FUNCTION fn_get_max_product_price()
returns int as 
$body$
SELECT 
$body$

language SQL
CREATE VIEW product_count_view as
SELECT product_type.name AS product_type_name, product.name, COUNT(*) AS item_count
FROM product 
JOIN product_type
ON product_type.id = product.type_id
GROUP BY product.type_id, product.name, product_type_name
ORDER BY product.type_id;

SELECT * FROM product_count_view

CREATE OR REPLACE FUNCTION func_get_highest_count()
RETURNS int AS
$body$
SELECT MAX(item_count) 
FROM  product_count_view
$body$
language SQL

SELECT func_get_highest_count();

select * from product
-- select * from sales_person

select fn_update_sales_person();


create or replace function func_get_count_state(state_name char(2))
returns numeric as 
$body$
 select count(*)
 from customer 
 where state = state_name;
$body$

language sql

select func_get_count_state('WV')

--natural join matches columns without on by using similar named

--returning composites or rows

create or replace function fn_get_last_order()
returns sales_order as
$body$
 select * 
 from sales_order
 order by id desc
 limit 1
$body$
language sql

-- ask for table format
select (fn_get_last_order()).order_time
select(fn_get_last_order()).*

create or replace function func_get_cust_by_state(state_name char(2))
returns setof customer as 
$body$
	select * 
	from customer
	where state = state_name;
$body$
language sql

--better syntax
select * from func_get_cust_by_state('WV');
