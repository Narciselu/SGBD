drop table hotel_bookings
/
drop table tickets
/

drop table customers
/

drop table flights
/


drop table airplanes
/
drop table airplanes_types
/
drop table companies
/


drop table airports
/
drop table hotels
/


drop table cities
/
drop table countries
/
drop table continents
/


create table continents (
  name varchar2(64) primary key
)
/
create table countries (
  name varchar2(64) primary key,
  continent varchar2(64),
  constraint continent_ref foreign key (continent) references continents(name) on delete cascade
)
/
create table cities (
  name varchar2(64) primary key,
  latitude varchar2(64) not null,
  longitude varchar2(64) not null,
  country varchar2(64),
  constraint country_ref foreign key (country) references countries(name) on delete cascade
)
/

create table hotels (
  name varchar2(64) primary key,
  price float not null,
  capacity int not null,
  rating int,
  country varchar(64) not null,
  constraint city2_ref foreign key (country) references cities(name) on delete cascade
)
/
create table airports (
  code varchar2(8) primary key,
  name varchar2(64) not null,
  city varchar2(64) not null,
  constraint city_ref foreign key (city) references cities(name) on delete cascade
)
/


create table companies (
  name varchar2(64) primary key,
  rating int
)
/
create table airplanes_types (
  model varchar(64) primary key,
  speed int not null,
  fuel_capacity int not null,
  fuel_economy int not null,
  capacity int not null
)
/
create table airplanes (
  id int primary key,
  model varchar(64) not null,
  company varchar2(64) not null,
  constraint company_ref foreign key (company) references companies(name) on delete cascade,
  constraint model_ref foreign key (model) references airplanes_types(model) on delete cascade
)
/


create table flights (
  id int primary key,
  departure_airport varchar(8) not null,
  arrival_airport varchar(8) not null,
  id_airplane int not null,
  departure_time timestamp not null,
  arrival_time timestamp not null,
  constraint departure_ref foreign key (departure_airport) references airports(code) on delete cascade,
  constraint arrival_ref foreign key (arrival_airport) references airports(code) on delete cascade,
  constraint airplane_ref foreign key (id_airplane) references airplanes(id) on delete cascade
)
/


create table customers (
  id int primary key,
  email varchar2(96) not null,
  first_name varchar2(32) not null,
  last_name varchar2(32) not null,
  password varchar2(32) not null,
  constraint email_unique unique(email)
)
/

create table tickets (
  id_customer int not null,
  id_flight int not null,
  price int not null,
  seat int not null,
  class int not null,
  --constraint seat_unique unique (id_flight, seat),
  constraint customer_ref foreign key (id_customer) references customers(id) on delete cascade,
  constraint flight_ref foreign key (id_flight) references flights(id) on delete cascade
)
/
create table hotel_bookings (
  id_customer int not null,
  hotel varchar(64) not null,
  check_in timestamp not null,
  check_out timestamp not null,
  constraint customer2_ref foreign key (id_customer) references customers(id) on delete cascade,
  constraint hotel_ref foreign key (hotel) references hotels(name) on delete cascade
)
/


drop sequence customers_seq
/
drop sequence flights_seq
/
drop sequence airplanes_seq
/

create sequence customers_seq start with 1 increment by 1
/
create sequence flights_seq start with 1 increment by 1
/
create sequence airplanes_seq start with 1 increment by 1
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
