drop table customers
/
drop table tickets
/
drop table flights
/
drop table airplanes
/
drop table companies
/
drop table airports
/
drop table cities
/
drop table countries
/
drop table continents
/
drop table hotels
/
drop table rooms
/
drop table landmarks
/

create table customers (
  id int primary key,
  first_name varchar2(16) not null,
  last_name varchar2(16) not null,
  username varchar2(12) not null,
  password varchar2(8) not null,
  email varchar2(32) not null,
  constraint username_unique unique (username)
)
/

create table tickets (
  id int primary key,
  id_customer int not null,
  id_fligt int not null,
  price int not null,
  seat int not null,
  gate int not null,
  class char not null,
  constraint seat_unique unique (id_fligt, seat)
)
/

create table flights (
  id int primary key,
  id_from int not null,
  id_to int not null,
  id_plane int not null,
  departure_date date not null,
  departure_time timestamp not null
)
/

create table airplanes (
  id int primary key,
  id_company int,
  name varchar2(16) not null,
  capacity int not null
)
/

create table companies (
  id int primary key,
  name varchar2(16) not null,
  hq_address varchar2(32) not null,
  ceo_name varchar2(32) not null,
  constraint company_name_unique unique (name)
)
/

create table airports (
  id int primary key,
  id_city int not null,
  name varchar2(16) not null,
  IATA_Code varchar2(3) not null
)
/

create table cities (
  id int primary key,
  id_country int not null,
  name varchar2(16) not null
)
/

create table countries (
  id int primary key,
  id_continent int not null,
  name varchar2(16) not null
)
/

create table continents (
  id int primary key,
  name varchar2(16) not null,
  constraint continent_name_unique unique (name)
)
/

create table hotels (
  id int primary key,
  id_city int not null,
  name varchar2(16) not null,
  address varchar2(16) not null
)
/

create table rooms (
  id int primary key,
  id_hotel int not null,
  capacity int not null
)
/

create table landmarks (
  id int primary key,
  id_city int not null,
  name varchar2(16) not null,
  address varchar2(16) not null
)
/

drop sequence customers_seq
/
drop sequence tickets_seq
/
drop sequence flights_seq
/
drop sequence airplanes_seq
/
drop sequence companies_seq
/
drop sequence airports_seq
/
drop sequence cities_seq
/
drop sequence countries_seq
/
drop sequence continents_seq
/
drop sequence hotels_seq
/
drop sequence rooms_seq
/
drop sequence landmarks_seq
/

create sequence customers_seq start with 1 increment by 1
/
create sequence tickets_seq start with 1 increment by 1
/
create sequence flights_seq start with 1 increment by 1
/
create sequence airplanes_seq start with 1 increment by 1
/
create sequence companies_seq start with 1 increment by 1
/
create sequence airports_seq start with 1 increment by 1
/
create sequence cities_seq start with 1 increment by 1
/
create sequence countries_seq start with 1 increment by 1
/
create sequence continents_seq start with 1 increment by 1
/
create sequence hotels_seq start with 1 increment by 1
/
create sequence rooms_seq start with 1 increment by 1
/
create sequence landmarks_seq start with 1 increment by 1
/

create or replace trigger customers_trigger 
before insert on customers 
for each row
begin
  if :new.id is null then
    select customers_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger tickets_trigger 
before insert on tickets 
for each row
begin
  if :new.id is null then
    select tickets_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger flights_trigger 
before insert on flights
for each row
begin
  if :new.id is null then
    select flights_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger airplanes_trigger 
before insert on airplanes
for each row
begin
  if :new.id is null then
    select airplanes_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger companies_trigger 
before insert on companies
for each row
begin
  if :new.id is null then
    select companies_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger airports_trigger 
before insert on airports
for each row
begin
  if :new.id is null then
    select airports_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger cities_trigger 
before insert on cities
for each row
begin
  if :new.id is null then
    select cities_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger countries_trigger 
before insert on countries
for each row
begin
  if :new.id is null then
    select countries_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger continents_trigger 
before insert on continents
for each row
begin
  if :new.id is null then
    select continents_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger hotels_trigger 
before insert on hotels
for each row
begin
  if :new.id is null then
    select hotels_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger rooms_trigger 
before insert on rooms
for each row
begin
  if :new.id is null then
    select rooms_seq.nextval into :new.id from dual; 
  end if;
end;
/

create or replace trigger landmarks_trigger 
before insert on landmarks
for each row
begin
  if :new.id is null then
    select landmarks_seq.nextval into :new.id from dual; 
  end if;
end;
/

insert into customers(first_name, last_name, username, password, email) values('Bogdan', 'Istoc', 'bogdan', 'narcis', 'bogdan@yahoo.com');
insert into customers(first_name, last_name, username, password, email) values('Narcis', 'Zaharia', 'narcis', 'bogdan', 'narcis@gmail.com');

insert into companies(name, hq_address, ceo_name) values('BlueAir', 'Strada unu nr doi', 'Nelu Iordache');
insert into companies(name, hq_address, ceo_name) values('WizzAird', 'Strada prabusita nr 69', 'József Váradi');

insert into airplanes(id_company, name, capacity) values(1, 'boeing 777', 700);
insert into airplanes(id_company, name, capacity) values(2, 'airbus a380', 850);

insert into continents(name) values('Europa');
insert into continents(name) values('America de Nord');
insert into continents(name) values('America de Sud');
insert into continents(name) values('Australia');
insert into continents(name) values('Asia');
insert into continents(name) values('Africa');
insert into continents(name) values('Antarctica');

insert into countries(id_continent, name) values(1, 'Romania');
insert into countries(id_continent, name) values(1, 'Germania');
insert into countries(id_continent, name) values(1, 'Franta');
insert into countries(id_continent, name) values(1, 'UK');
insert into countries(id_continent, name) values(1, 'Suedia');
insert into countries(id_continent, name) values(1, 'Spania');
insert into countries(id_continent, name) values(1, 'Germania');
insert into countries(id_continent, name) values(2, 'USA');
insert into countries(id_continent, name) values(2, 'Canada');
insert into countries(id_continent, name) values(3, 'Mexic');
insert into countries(id_continent, name) values(3, 'Brazilia');
insert into countries(id_continent, name) values(4, 'Australia');
insert into countries(id_continent, name) values(5, 'India');
insert into countries(id_continent, name) values(5, 'China');
insert into countries(id_continent, name) values(6, 'Somalia');
insert into countries(id_continent, name) values(6, 'Egipt');


--		@/home/bogdan/Desktop/bazeDate.sql

select rownum as nr, table_name from user_tables
	where lower(table_name) in ('customers', 'tickets', 'flights', 'airplanes', 'companies', 'airports', 'cities', 'countries', 'continents', 'hotels', 'rooms', 'landmarks');

select rownum as nr, sequence_name from user_sequences
	where lower(sequence_name) in ('customers_seq', 'tickets_seq', 'flights_seq', 'airplanes_seq', 'companies_seq', 'airports_seq', 'cities_seq', 'countries_seq', 'continents_seq', 'hotels_seq', 'rooms_seq', 'landmarks_seq');

select rownum as nr, trigger_name from user_triggers
	where lower(trigger_name) in ('customers_trigger', 'tickets_trigger', 'flights_trigger', 'airplanes_trigger', 'companies_trigger', 'airports_trigger', 'cities_trigger', 'countries_trigger', 'continents_trigger', 'hotels_trigger', 'rooms_trigger', 'landmarks_trigger');

--todo: constraints for foreign keys
--populare tabele

select * from customers;
select * from tickets;setVerticalAlignment
select * from flights;
select * from airplanes;
select * from companies;
select * from airports;
select * from cities;
select * from countries;
select * from continents;
select * from hotels;
select * from rooms;
select * from landmarks;

 -- select * from airplanes a join companies c on a.id_company = c.id;