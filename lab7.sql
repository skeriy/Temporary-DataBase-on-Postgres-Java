DROP TABLE if exists firms_history cascade;
CREATE TABLE firms_history(
		like firms
		time_of_create timestamp without time zone,
  name_of_operation character varying(15)
);

DROP TABLE if exists contacts_history cascade;
CREATE TABLE contacts_history(
		like contacts
		time_of_create timestamp without time zone,
  name_of_operation character varying(15)
);

DROP TABLE if exists goods_history cascade;
CREATE TABLE goods_history(
		like goods
		time_of_create timestamp without time zone,
  name_of_operation character varying(15)
);

DROP TABLE if exists maintrance_history cascade;
CREATE TABLE maintrance_history(
		like maintrance
		time_of_create timestamp without time zone,
  name_of_operation character varying(15)
);

DROP TABLE if exists markets_history cascade;
CREATE TABLE markets_history(
		like markets
		time_of_create timestamp without time zone,
  name_of_operation character varying(15)
);

DROP TABLE if exists warehouse_history cascade;
CREATE TABLE warehouse_history(
		like warehouse
		time_of_create timestamp without time zone,
  name_of_operation character varying(15)
);
---------------------------------------------------------------------------------------------------------

----------------------------triggers---------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------

CREATE or replace function first_trigger_firms() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'insert';
    insert into firms_history values(new.id,new.name,new.city,new.address,new.telefon,tTime,nName);
            
    return null;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists firms_tr_1 on firms
CREATE TRIGGER firms_tr_1 
  AFTER INSERT ON firms FOR EACH ROW 
  EXECUTE PROCEDURE first_trigger_firms()

CREATE or replace function second_trigger_firms() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'update';
            --		update firms_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into firms_history values(new.id,new.name,new.city,new.address,new.telefon,tTime,nName);
    return new;
  END; 
  $$ LANGUAGE  plpgsql
  
drop trigger if exists firms_tr_2 on firms
CREATE TRIGGER firms_tr_2 
  AFTER UPDATE ON firms FOR EACH ROW 
  EXECUTE PROCEDURE second_trigger_firms()

CREATE or replace function third_trigger_firms() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'delete';
            --		update firms_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into firms_history values(old.id,old.name,old.city,old.address,old.telefon,tTime,nName);
    return old;
  END; 
  $$ LANGUAGE  plpgsql
  
drop trigger if exists firms_tr_3 on firms
CREATE TRIGGER firms_tr_3 
  AFTER DELETE ON firms FOR EACH ROW 
  EXECUTE PROCEDURE third_trigger_firms()
  
-----------------------------------------------------------------------------------------------------------

CREATE or replace function first_trigger_contacts() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'insert';
    insert into contacts_history values(new.id,new.first_name,new.name,new.second_name,new.telefon,new.firm_id,tTime,nName);
    return null;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists contacts_tr_1 on contacts
CREATE TRIGGER contacts_tr_1 
  AFTER INSERT ON contacts FOR EACH ROW 
  EXECUTE PROCEDURE first_trigger_contacts()

CREATE or replace function second_trigger_contacts() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'update';
            --		update contacts_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into contacts_history values(new.id,new.first_name,new.name,new.second_name,new.telefon,new.firm_id,tTime,nName);
    return new;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists contacts_tr_2 on contacts
CREATE TRIGGER contacts_tr_2 
  AFTER UPDATE ON contacts FOR EACH ROW 
  EXECUTE PROCEDURE second_trigger_contacts()

CREATE or replace function third_trigger_contacts() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'delete';
            --		update contacts_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into contacts_history values(old.id,old.first_name,old.name,old.second_name,old.telefon,old.firm_id,tTime,nName);
    return old;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists contacts_tr_3 on contacts
CREATE TRIGGER contacts_tr_3 
    AFTER DELETE ON contacts FOR EACH ROW 
    EXECUTE PROCEDURE third_trigger_contacts()

CREATE or replace function first_trigger_goods() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'insert';
    insert into goods_history values(new.id,new.name,new.firm_id,new.prime,new.number,new.warehouse_id,new.number_of_brought,tTime,nName);
    return null;
  END; 
  $$ LANGUAGE  plpgsql

------------------------------------------------------------------------------------------------------------

drop trigger if exists goods_tr_1 on goods
CREATE TRIGGER goods_tr_1 
  AFTER INSERT ON goods FOR EACH ROW 
  EXECUTE PROCEDURE first_trigger_goods()

CREATE or replace function second_trigger_goods() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'update';
            --		update goods_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into goods_history values(new.id,new.name,new.firm_id,new.prime,new.number,new.warehouse_id,new.number_of_brought,tTime,nName);
    return new;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists goods_tr_2 on goods
CREATE TRIGGER goods_tr_2 
  AFTER UPDATE ON goods FOR EACH ROW 
  EXECUTE PROCEDURE second_trigger_goods()

CREATE or replace function third_trigger_goods() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'delete';
            --		update goods_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into goods_history values(old.id,old.name,old.firm_id,old.prime,old.number,old.warehouse_id,old.number_of_brought,tTime,nName);
    return old;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists goods_tr_3 on goods
CREATE TRIGGER goods_tr_3 
  AFTER DELETE ON goods FOR EACH ROW 
  EXECUTE PROCEDURE third_trigger_goods()

CREATE or replace function first_trigger_maintrance() RETURNS trigger AS 
  $$
  DECLARE
  		tTime TIMESTAMP;
  		nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'insert';
    insert into maintrance_history values(new.id,new.first_name,new.name,new.second_name,new.telefon,new.market_id,tTime,nName);
    return null;
  END; 
  $$ LANGUAGE  plpgsql

---------------------------------------------------------------------------------------------------

drop trigger if exists maintrance_tr_1 on maintrance
CREATE TRIGGER maintrance_tr_1 
  AFTER INSERT ON maintrance FOR EACH ROW 
  EXECUTE PROCEDURE first_trigger_maintrance()

CREATE or replace function second_trigger_maintrance() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'update';
            --		update maintrance_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into maintrance_history values(new.id,new.first_name,new.name,new.second_name,new.telefon,new.market_id,tTime,nName);
    return new;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists maintrance_tr_2 on maintrance
CREATE TRIGGER maintrance_tr_2 
  AFTER UPDATE ON maintrance FOR EACH ROW 
  EXECUTE PROCEDURE second_trigger_maintrance()

CREATE or replace function third_trigger_maintrance() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'delete';
            --		update maintrance_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into maintrance_history values(old.id,old.first_name,old.name,old.second_name,old.telefon,old.market_id,tTime,nName);
    return old;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists maintrance_tr_3 on maintrance
CREATE TRIGGER maintrance_tr_3 
  AFTER DELETE ON maintrance FOR EACH ROW 
  EXECUTE PROCEDURE third_trigger_maintrance()

-------------------------------------------------------------------------------------------------------------

CREATE or replace function first_trigger_markets() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'insert';
    insert into markets_history values(new.id,new.address,new.telefon,tTime,nName);
    return null;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists markets_tr_1 on markets
CREATE TRIGGER markets_tr_1 
  AFTER INSERT ON markets FOR EACH ROW 
  EXECUTE PROCEDURE first_trigger_markets()

CREATE or replace function second_trigger_markets() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'update';
            --		update markets_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into markets_history values(new.id,new.address,new.telefon,tTime,nName);
    return new;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists markets_tr_2 on markets
CREATE TRIGGER markets_tr_2 
  AFTER UPDATE ON markets FOR EACH ROW 
  EXECUTE PROCEDURE second_trigger_markets()
CREATE or replace function third_trigger_markets() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'delete';
            --		update markets_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into markets_history values(old.id,old.address,old.telefon,tTime,nName);
    return old;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists markets_tr_3 on markets
CREATE TRIGGER markets_tr_3 
  AFTER DELETE ON markets FOR EACH ROW 
  EXECUTE PROCEDURE third_trigger_markets()

CREATE or replace function first_trigger_warehouse() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'insert';
    insert into warehouse_history values(new.id,new.address,new.market_id,tTime,nName);
    return null;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists warehouse_tr_1 on warehouse
CREATE TRIGGER warehouse_tr_1 
  AFTER INSERT ON warehouse FOR EACH ROW 
  EXECUTE PROCEDURE first_trigger_warehouse()

CREATE or replace function second_trigger_warehouse() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'update';
--		update warehouse_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into warehouse_history values(new.id,new.address,new.market_id,tTime,nName);
    return new;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists warehouse_tr_2 on warehouse
CREATE TRIGGER warehouse_tr_2 
  AFTER UPDATE ON warehouse FOR EACH ROW 
  EXECUTE PROCEDURE second_trigger_warehouse()

CREATE or replace function third_trigger_warehouse() RETURNS trigger AS 
  $$
  DECLARE
    tTime TIMESTAMP;
    nName varchar(15);
  BEGIN 
    tTime = clock_timestamp();
    nName = 'delete';
            --		update warehouse_history set name=new.name,city=new.city,address=new.address,telefon=new.telefon,time_of_create=tTime where id=new.id;
    insert into warehouse_history values(old.id,old.address,old.market_id,tTime,nName);
    return old;
  END; 
  $$ LANGUAGE  plpgsql

drop trigger if exists warehouse_tr_3 on warehouse
CREATE TRIGGER warehouse_tr_3 
  AFTER DELETE ON warehouse FOR EACH ROW 
  EXECUTE PROCEDURE third_trigger_warehouse()

---------------------------------------------------------------------------------------------------------

-----------------------------functions-------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE function firms_date(time_moment timestamp without time zone) RETURNS integer
AS $firms_date$ 
		DECLARE
				C1 cursor for select * from firms_history where time_of_create >= time_moment order by pk_temp desc;
				--c2 cursor for select pk_temp from firms_history where 
				i integer;
		BEGIN
				for i in	c1
				loop
						if i.name_of_operation = 'insert' then
								delete from firms where id = i.id;
						elsif i.name_of_operation = 'update' then
								update firms set name=i.name,city=i.city,address=i.address,telefon = i.telefon where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into firms values (i.id,i.name,i.city,i.address,i.telefon);
						end if;
				end loop;
				--delete from firms_history where id = i.id+1;
		return null;
		END;
		$firms_date$ 
		LANGUAGE plpgsql;
		
CREATE OR REPLACE function firms_num(num_operation integer) RETURNS integer
AS $$ 
		DECLARE
				C1 cursor for select * from firms_history order by time_of_create desc;
				i integer;
		BEGIN
				for i in	c1
				loop
						if num_operation=0 then
								exit;
						end if;
						if i.name_of_operation = 'insert' then
								delete from firms where id = i.id;
						elsif i.name_of_operation = 'update' then
								update firms set name=i.name,city=i.city,address=i.address,telefon = i.telefon where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into firms values (i.id,i.name,i.city,i.address,i.telefon);
						end if;
						num_operation = num_operation - 1;
				end loop;
				return 0;
		END;
		$$ 
		LANGUAGE plpgsql;
	
------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE function contacts_date(time_moment timestamp without time zone) RETURNS integer
AS $contacts_date$ 
		DECLARE
				C1 cursor for select * from contacts_history where time_of_create >= time_moment order by pk_temp desc;
				--c2 cursor for select pk_temp from contacts_history where 
				i integer;
		BEGIN
				for i in	c1
				loop
						if i.name_of_operation = 'insert' then
								delete from contacts where id = i.id;
						elsif i.name_of_operation = 'update' then
								update contacts set first_name = i.first_name, name=i.name, second_name = i.second_name, telefon = i.telefon, firm_id = i.firm_id where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into contacts values (i.id, i.first_name, i.name, i.second_name, i.telefon, i.firm_id);
						end if;
				end loop;
				--delete from contacts_history where id = i.id+1;
		return null;
		END;
		$contacts_date$ 
		LANGUAGE plpgsql;
		
CREATE OR REPLACE function contacts_num(num_operation integer) RETURNS integer
AS $$ 
		DECLARE
				C1 cursor for select * from contacts_history order by time_of_create desc;
				i integer;
		BEGIN
				for i in	c1
				loop
						if num_operation=0 then
								exit;
						end if;
						if i.name_of_operation = 'insert' then
								delete from contacts where id = i.id;
						elsif i.name_of_operation = 'update' then
								update contacts set first_name = i.first_name, name=i.name, second_name = i.second_name, telefon = i.telefon, firm_id = i.firm_id where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into contacts values (i.id, i.first_name, i.name, i.second_name, i.telefon, i.firm_id);
						end if;
						num_operation = num_operation - 1;
				end loop;
				return 0;
		END;
		$$ 
		LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE function goods_date(time_moment timestamp without time zone) RETURNS integer
AS $goods_date$ 
		DECLARE
				C1 cursor for select * from goods_history where time_of_create >= time_moment order by pk_temp desc;
				--c2 cursor for select pk_temp from goods_history where 
				i integer;
		BEGIN
				for i in	c1
				loop
						if i.name_of_operation = 'insert' then
								delete from goods where id = i.id;
						elsif i.name_of_operation = 'update' then
								update goods set name = i.name, firm_id = i.firm_id,prime = i.prime, number = i.number,warehouse = i.warehouse_id,number_of_brought = i.number_of_brought where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into goods values (i.id,i.name,i.firm_id,i.prime,i.number,i.warehouse_id,i.number_of_brought);
						end if;
				end loop;
				--delete from goods_history where id = i.id+1;
		return null;
		END;
		$goods_date$ 
		LANGUAGE plpgsql;
		
CREATE OR REPLACE function goods_num(num_operation integer) RETURNS integer
AS $$ 
		DECLARE
				C1 cursor for select * from goods_history order by time_of_create desc;
				i integer;
		BEGIN
				for i in	c1
				loop
						if num_operation=0 then
								exit;
						end if;
						if i.name_of_operation = 'insert' then
								delete from goods where id = i.id;
						elsif i.name_of_operation = 'update' then
								update goods set name = i.name, firm_id = i.firm_id,prime = i.prime, number = i.number,warehouse = i.warehouse_id,number_of_brought = i.number_of_brought where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into goods values (i.id,i.name,i.firm_id,i.prime,i.number,i.warehouse_id,i.number_of_brought);
						end if;
						num_operation = num_operation - 1;
				end loop;
				return 0;
		END;
		$$ 
		LANGUAGE plpgsql;

---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE function maintrance_date(time_moment timestamp without time zone) RETURNS integer
AS $maintrance_date$ 
		DECLARE
				C1 cursor for select * from maintrance_history where time_of_create >= time_moment order by pk_temp desc;
				--c2 cursor for select pk_temp from maintrance_history where 
				i integer;
		BEGIN
				for i in	c1
				loop
						if i.name_of_operation = 'insert' then
								delete from maintrance where id = i.id;
						elsif i.name_of_operation = 'update' then
								update maintrance set first_name = i.first_name, name=i.name, second_name = i.second_name, telefon = i.telefon, market_id = i.market_id where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into contacts values (i.id, i.first_name, i.name, i.second_name, i.telefon, i.market_id);
						end if;
				end loop;
				--delete from maintrance_history where id = i.id+1;
		return null;
		END;
		$maintrance_date$ 
		LANGUAGE plpgsql;
		
CREATE OR REPLACE function maintrance_num(num_operation integer) RETURNS integer
AS $$ 
		DECLARE
				C1 cursor for select * from maintrance_history order by time_of_create desc;
				i integer;
		BEGIN
				for i in	c1
				loop
						if num_operation=0 then
								exit;
						end if;
						if i.name_of_operation = 'insert' then
								delete from maintrance where id = i.id;
						elsif i.name_of_operation = 'update' then
								update maintrance set first_name = i.first_name, name=i.name, second_name = i.second_name, telefon = i.telefon, market_id = i.market_id where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into contacts values (i.id, i.first_name, i.name, i.second_name, i.telefon, i.market_id);
						end if;
						num_operation = num_operation - 1;
				end loop;
				return 0;
		END;
		$$ 
		LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE function markets_date(time_moment timestamp without time zone) RETURNS integer
AS $markets_date$ 
		DECLARE
				C1 cursor for select * from markets_history where time_of_create >= time_moment order by pk_temp desc;
				--c2 cursor for select pk_temp from markets_history where 
				i integer;
		BEGIN
				for i in	c1
				loop
						if i.name_of_operation = 'insert' then
								delete from markets where id = i.id;
						elsif i.name_of_operation = 'update' then
								update markets set address=i.address,telefon = i.telefon where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into markets values (i.id,i.address,i.telefon);
						end if;
				end loop;
				--delete from markets_history where id = i.id+1;
		return null;
		END;
		$markets_date$ 
		LANGUAGE plpgsql;
		
CREATE OR REPLACE function markets_num(num_operation integer) RETURNS integer
AS $$ 
		DECLARE
				C1 cursor for select * from markets_history order by time_of_create desc;
				i integer;
		BEGIN
				for i in	c1
				loop
						if num_operation=0 then
								exit;
						end if;
						if i.name_of_operation = 'insert' then
								delete from markets where id = i.id;
						elsif i.name_of_operation = 'update' then
								update markets set address=i.address,telefon = i.telefon where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into markets values (i.id,i.address,i.telefon);
						end if;
						num_operation = num_operation - 1;
				end loop;
				return 0;
		END;
		$$ 
		LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE function warehouse_date(time_moment timestamp without time zone) RETURNS integer
AS $warehouse_date$ 
		DECLARE
				C1 cursor for select * from warehouse_history where time_of_create >= time_moment order by pk_temp desc;
				--c2 cursor for select pk_temp from warehouse_history where 
				i integer;
		BEGIN
				for i in	c1
				loop
						if i.name_of_operation = 'insert' then
								delete from warehouse where id = i.id;
						elsif i.name_of_operation = 'update' then
								update warehouse set address=i.address,market_id = i.market_id where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into warehouse values (i.id,i.address,i.market_id);
						end if;
				end loop;
				--delete from warehouse_history where id = i.id+1;
		return null;
		END;
		$warehouse_date$ 
		LANGUAGE plpgsql;
		
CREATE OR REPLACE function warehouse_num(num_operation integer) RETURNS integer
AS $$ 
		DECLARE
				C1 cursor for select * from warehouse_history order by time_of_create desc;
				i integer;
		BEGIN
				for i in	c1
				loop
						if num_operation=0 then
								exit;
						end if;
						if i.name_of_operation = 'insert' then
								delete from warehouse where id = i.id;
						elsif i.name_of_operation = 'update' then
								update warehouse set address=i.address,market_id = i.market_id where id = i.id;
						elsif i.name_of_operation = 'delete' then
								insert into warehouse values (i.id,i.address,i.market_id);
						end if;
						num_operation = num_operation - 1;
				end loop;
				return 0;
		END;
		$$ 
		LANGUAGE plpgsql;

----------------------------------------------------------------------------------------------------------
insert into firms values(12,'name_12','city_12','adress_12','phone_12');
update firms set name = '12_name_12' where id = 12;


