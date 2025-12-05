

create function trigger_function()
	returns trigger 
	language plpgsql
	as
	$$
	begin
	end;
	$$

--create the actual trigger 
create trigger trigger_name
 {BEFORE|AFTER} {event} insert update. truncate
 on table_name 
 for [each] {row|statement}
 execture procedure trigger_fucntion



create function trigger_function()
returns trigger 
language plpgsql
as 
$$
begin
end;
$$


create trigger trigger_name
before insert
on auth
foreach row 
execute procedure trigger_function

create table  distributor(
	id serial primary key,
	name varchar(100)
);

insert into distributor (name) values
('Parawholesale'), 
('J & B Sales'), 
('Steel City Clothing');

select * from distributor;

create table distributor_audit (
	id serial primary key,
	dist_id int not null, 
	name varchar(100) not null,  
	edit_date timestamp not null
	
);

create or replace function fn_log_distb_name_change()
	returns trigger
	language plpgsql
	as 
	$$
	begin
		if new.name <> old.name then
			insert into distributor_audit
			(dist_id, name, edit_date)
			values
			(old.id, old.name, now());
		end if;
		RAISE NOTICE 'Trigger Name       : %', TG_NAME;
		RAISE NOTICE 'Table Name         : %', TG_TABLE_NAME;
		RAISE NOTICE 'Operation          : %', TG_OP;
		RAISE NOTICE 'When Executed      : %', TG_WHEN;
		RAISE NOTICE 'Row or Statement   : %', TG_LEVEL;
		RAISE NOTICE 'Table Schema       : %', TG_TABLE_SCHEMA;
		return  new;
	end;
	$$

-- hook up trigger fucntion to trigger and attach to table 
create trigger tr_dist_name_changed
	before update 
	on distributor
	for each row 
	execute procedure fn_log_distb_name_change();

update distributor 
set name = 'Western Clothing'
where id = 2;

select * from distributor_audit;


create or replace function fn_block_weekend_changes()
returns trigger
language plpgsql
as
$$
begin
	raise notice 'No database changers allowed on the weekend';
	return null;
end;
$$

create trigger tr_block_weekend_changes
	before update or insert or delete or truncate
	on distributor
	
	for each statement 
	when (
		EXTRACT('DOW' from current_timestamp) between 6 and 7
	)
	execute procedure fn_block_weekend_changes();

drop event trigger tr_block_weekend_changes
 