-- pl/pgsql

select item.name, item.price
from item
natural join product
where name = 'Nike Bead Foam'

select * 
from item
join product
on item.name = product.name


create or replace function fn_name(param int)
returns int as
$body$
begin
end
$body$
language plpqsql


-- uses RETURN when only return one value, use ReTURN QUERY When  return table or setof
create or replace function pg_func_get_product_by_name(prod_name varchar)
returns table(
	name varchar,
	price numeric)
as $body$
begin
return query 
select item.name, item.price
from item
natural join product
where item.name = prod_name;
end
$body$
language plpgsql;


select * from pg_func_get_product_by_name('Nike Bead Foam');

create or replace function fn_get_sum(val1 int, val2 int)
returns int as
$$
declare 
	ans int; 
begin
-- infers the type using gopher
	ans := val1 + val2;
	return ans;
		
end;
$$
language plpgsql;

select fn_get_sum(2,3)


create or replace function fn_get_rand_val(min_val int, max_val int)
returns int as 
$$
declare
	rand_int int; 
begin
	-- put inside a variable
 	select random() * (max_val - min_val) + min_val into rand_int;
	return rand_int;
end;
$$
language plpgsql;

select fn_get_rand_val(0, 5);


create or replace function fn_get_rand_sales_p()
returns varchar as
$$
	declare 
		rand int; 
		-- record is a row container 
		emp	record; 
	begin 
	select random() * (5-1) + 1 into rand; 
	select * 
	from sales_person
	into emp
	where id = rand;
	return concat(emp.first_name,' ', emp.last_name);
	end;
$$
language plpgsql;
select fn_get_rand_sales_p();

-- ins and outs
create or replace function fn_get_cust_bday(in the_month int, out bd_month int, out bd_day int, out f_name varchar, out l_name varchar)
-- no need to use return 
as 
$$
begin
	select extract(month from birth_date), extract(day from birth_date),
	first_name, last_name
	into bd_month, bd_day, f_name, l_name
	from customer
	where extract(month from birth_date) = the_month
	limit 1;
end;
$$
language plpgsql;

select * from fn_get_cust_bday(5)
select extract(month from birth_date) from customer

select count(*) as item_count, name from product
group by name

create or replace function fn_check_amt_state(itm_name varchar)
returns varchar as 
$$
declare
	total_amt int; 
	
begin
	select count(*) into total_amt
	from product
	where name = itm_name;
	if total_amt >1 then
		return concat(total_amt, ' orders: doing good');

	else
		return concat(total_amt, ' orders: doing bad');
	end if;
	

end;
$$
language plpgsql;

select fn_check_amt_state('Allen Edmonds');


-- using the case block instead
create or replace function fn_case_check_amt_state(itm_name varchar)
returns varchar as 
$$
declare
	total_amt int; 
	
begin
	select count(*) into total_amt
	from product
	where name = itm_name;
	case 
		when total_amt < 1 then
			return concat(total_amt, ' orders: doing bad');
		when total_amt > 1 then
			return concat(total_amt, ' orders: doing good');
		when total_amt == 1 then
			return concat(total_amt, ' orders: doing good');
		else
			return concat(total_amt, 'unknown');
	end case;
	
end;
$$
language plpgsql;

select fn_case_check_amt_state('Allen Edmonds');

-- loops
/*
LOOP - must have exit condition
	Statements
	EXIT WHEN condition is true;
ENDLOOP;
*/

create or replace function fn_loop_test(max_num int)
returns int as
$$
declare
	j int  default 1;
	total_sum int default 0;
begin
	loop
		total_sum := total_sum + j;
		j := j+1;
		exit when j > max_num;
	end loop;
	return total_sum;
end;
$$
language plpgsql;

select fn_loop_test(5);

-- for loop
/* 
FOR counter_name IN start_val... end value by stepping
LOOP
statements
end loop
*/ 


create or replace function fn_for_test(max_num int)
returns int as 
$$
declare
	tot_sum int default 0;
begin
	for i in 1 .. max_num by 2
	-- for i in REVERSE max num .. 1
	loop
	tot_sum := tot_sum + i;
	end loop;
	return tot_sum;
end
$$
language plpgsql;

select fn_for_test(5);

-- one off anonymouse function with DO (quck tests) and doesn't return values

do 
$$
	declare
	 rec record; 
	begin
		for rec in 
			select first_name, last_name
			from sales_person
			limit 3
		loop
			raise notice '% %', rec.first_name, rec.last_name;
		end loop;
	
	end; 
$$
language plpgsql; 


-- foreach with an array 
-- FOREACH var in  ARRAY array_name

do 
$$
	declare
	 arr1 int[] := array[1,2,3]; 
	 i int; 
	begin
		foreach i in array arr1
		loop
			raise notice '%', i;
		end loop;
	
	end; 
$$
language plpgsql; 

-- while loop 
do 
$$
	declare
	 j int default 0; 
	begin
		while j< 10
		loop
			raise notice '%', j;
			j:= j+1;
		end loop;
	
	end; 
$$
language plpgsql; 