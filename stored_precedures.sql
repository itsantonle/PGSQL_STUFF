-- STORED PROCEDURES
-- doesn't return naything

create table past_due(
	id serial primary key, 
	cust_id integer not null, 
	balance numeric(6,2) not null
);

select * from customer;

insert into past_due(cust_id, balance)
values 
(1, 123.45),
(2, 324.50);

select * from past_due

create or replace procedure pr_debt_paid(
	past_due_id int, 
	payment numeric
	inout char  --You pass a value in, and the procedure can modify and return it.
) as
$$
	begin
		update past_due
		set balance = balance - payment
		where id = past_due_id;
		commit;
	end;
$$
language plpgsql;

call pr_debt_paid(1,10.00);


create or replace procedure procedure_name()
as
$$
declare
begin
end;
$$
language plpgsql;