--customers
create table names(
  id int primary key,
  first_name varchar2(32) not null,
  last_name varchar2(32) not null
)
/
create sequence names_seq start with 1 increment by 1
/
create or replace trigger names_trigger
before insert on names
for each row
begin
  if :new.id is null then
    select names_seq.nextval into :new.id from dual;
  end if;
end;
/

-- select * from ALL_DIRECTORIES;
declare
  v_file UTL_FILE.file_type;
  v_line varchar2(128);
  v_index int;
  v_fname CUSTOMERS.FIRST_NAME%type;
  v_lname CUSTOMERS.LAST_NAME%type;
begin
  v_file := UTL_FILE.fopen('PRDIR', 'names.csv', 'R');

  loop
    begin
      UTL_FILE.get_line(v_file, v_line);

      v_index := instr(v_line, ',');
      v_fname := trim(substr(v_line, 0, v_index -1));
      v_lname := trim(substr(v_line, v_index +1));

      insert into names(first_name, last_name) values(v_fname, v_lname);

      exception when No_Data_Found then exit;
    end;
  end loop;

  UTL_FILE.fclose(v_file);
  commit;
end;

declare
  Unique_Constraint_Violated exception;
  pragma exception_init(Unique_Constraint_Violated, -00001);

  v_fname CUSTOMERS.FIRST_NAME%type;
  v_lname CUSTOMERS.LAST_NAME%type;
  v_rand1 int;
  v_rand2 int;
  v_names_count int;

  v_rand3 int;
  v_email CUSTOMERS.EMAIL%type;
  v_password CUSTOMERS.PASSWORD%type;

  v_i int := 0;
begin
  select count(*) into v_names_count from names;
--todo: 4.5 milioane useri
  while v_i < 4500000 loop
    begin
      v_rand1 := DBMS_RANDOM.value(1, v_names_count);
      v_rand2 := DBMS_RANDOM.value(1, v_names_count);
      select first_name into v_fname from names where id = v_rand1;
      select last_name into v_lname from names where id = v_rand2;

      v_rand3 := DBMS_RANDOM.value(0, 10000);
      v_email := lower(v_fname || '.' || v_lname || v_rand3 || '@gmail.com');
      v_password := DBMS_RANDOM.string('a', 32);

      insert into customers(email, first_name, last_name, password) values(v_email, v_fname, v_lname, v_password);
      v_i := v_i + 1;
      exception when Unique_Constraint_Violated then continue;
    end;
  end loop;
  commit;
end;
/
drop table names
/
drop sequence names_seq
/

--select count(*) from CUSTOMERS;


--continents
begin
  insert into continents values('Europe');
  insert into continents values('North America');
  insert into continents values('South America');
  insert into continents values('Australia');
  insert into continents values('Asia');
  insert into continents values('Africa');
  insert into continents values('Antarctica');
end;


--countries
declare
  Reference_Constraint_Violated exception;
  pragma exception_init(Reference_Constraint_Violated, -2291);
  Unique_Constraint_Violated exception;
  pragma exception_init(Unique_Constraint_Violated, -00001);

  v_file UTL_FILE.file_type;
  v_line varchar2(128);
  v_index int;
  v_continentName COUNTRIES.CONTINENT%type;
  v_countryName COUNTRIES.NAME%type;
begin
  v_file := UTL_FILE.fopen('PRDIR', 'countries.csv', 'R');

  loop
    begin
      UTL_FILE.get_line(v_file, v_line);

      v_index := instr(v_line, ',');
      v_continentName := trim(substr(v_line, 0, v_index -1));
      v_countryName := trim(substr(v_line, v_index +1));

      insert into countries(name, continent) values(v_countryName, v_continentName);

      exception when No_Data_Found then exit;
                when Reference_Constraint_Violated then continue;
                when Unique_Constraint_Violated then continue;
    end;
  end loop;

  UTL_FILE.fclose(v_file);
  commit;
end;

-- select count(*) from COUNTRIES;
--
-- delete from COUNTRIES where 1=1;


--cities
declare
  Reference_Constraint_Violated exception;
  pragma exception_init(Reference_Constraint_Violated, -2291);
  Unique_Constraint_Violated exception;
  pragma exception_init(Unique_Constraint_Violated, -00001);

  v_file UTL_FILE.file_type;
  v_line varchar2(128);
  v_index int;
  v_countryName CITIES.COUNTRY%type;
  v_cityName CITIES.NAME%type;
  v_lat CITIES.LATITUDE%type;
  v_long CITIES.LONGITUDE%type;
begin
  v_file := UTL_FILE.fopen('PRDIR', 'cities.csv', 'R');

  loop
    begin
      UTL_FILE.get_line(v_file, v_line);

      v_index := instr(v_line, ',');
      v_countryName := trim(substr(v_line, 0, v_index -1));
      v_line := trim(substr(v_line, v_index +1));
      v_index := instr(v_line, ',');
      v_cityName := trim(substr(v_line, 0, v_index -1));
      v_line := trim(substr(v_line, v_index +1));
      v_index := instr(v_line, ',');

      v_lat := trim(substr(v_line, 0, v_index -1));
      v_long := trim(substr(v_line, v_index +1));

      insert into cities(name, latitude, longitude, country) values(v_cityName, v_lat, v_long, v_countryName);

      exception when No_Data_Found then exit;
                when Reference_Constraint_Violated then continue;
                when Unique_Constraint_Violated then continue;
    end;
  end loop;

  UTL_FILE.fclose(v_file);
  commit;
end;

-- select count(*) from cities;
--
-- delete from cities where 1=1;
--
--
--
--
-- select value
-- from nls_session_parameters
-- where parameter = 'NLS_NUMERIC_CHARACTERS';
--
--


--create temp hotel table with rowid for auto indexing and fast population

--hotels
create table INDEXED_COUNTRIES as select ROWNUM as id, CITIES.* from cities;
/
create index countries_id_index on INDEXED_COUNTRIES(id);
/

-- select * from INDEXED_COUNTRIES where id = 10;

declare
  v_name HOTELS.NAME%type;
  v_price HOTELS.PRICE%type;
  v_capacity HOTELS.CAPACITY%type;
  v_country HOTELS.COUNTRY%type;
  v_country_count int;
  v_rand int;
begin
  select count(*) into v_country_count from INDEXED_COUNTRIES;
  --todo: 500 000 hotels
  for v_i in 1..500000 loop
    v_rand := DBMS_RANDOM.value(1, v_country_count);
    select name into v_country from INDEXED_COUNTRIES where id = v_rand;

    v_name := 'Hotel no' || v_i;
    v_price := round(DBMS_RANDOM.value(50, 800), 2);
    v_capacity := floor(DBMS_RANDOM.value(100, 1000));

    insert into HOTELS(NAME, PRICE, CAPACITY, COUNTRY) values(v_name, v_price, v_capacity, v_country);
  end loop;
end;
/
drop table INDEXED_COUNTRIES;
/

-- select count(*) from HOTELS;
--
-- delete from HOTELS where 1=1;
--
-- select * from HOTELS;


--airports
declare
  Reference_Constraint_Violated exception;
  pragma exception_init(Reference_Constraint_Violated, -2291);
  Unique_Constraint_Violated exception;
  pragma exception_init(Unique_Constraint_Violated, -00001);

  v_file UTL_FILE.file_type;
  v_line varchar2(128);
  v_index int;
  v_cityName AIRPORTS.CITY%type;
  v_airportName AIRPORTS.NAME%type;
  v_code AIRPORTS.CODE%type;
begin
  v_file := UTL_FILE.fopen('PRDIR', 'airports.csv', 'R');

  loop
    begin
      UTL_FILE.get_line(v_file, v_line);

      v_index := instr(v_line, ',');
      v_cityName := trim(substr(v_line, 0, v_index -1));
      v_line := trim(substr(v_line, v_index +1));
      v_index := instr(v_line, ',');
      v_code := trim(substr(v_line, 0, v_index -1));
      v_airportName := trim(substr(v_line, v_index+1));

      insert into airports(code, name, city) values(v_code, v_airportName, v_cityName);

      exception when No_Data_Found then exit;
                when Reference_Constraint_Violated then continue;
                when Unique_Constraint_Violated then continue;

    end;
  end loop;

  UTL_FILE.fclose(v_file);
  commit;
end;


-- select count(*) from airports;
--
-- delete from AIRPORTS where 1=1;



--companies
declare
  Reference_Constraint_Violated exception;
  pragma exception_init(Reference_Constraint_Violated, -2291);
  Unique_Constraint_Violated exception;
  pragma exception_init(Unique_Constraint_Violated, -00001);

  v_file UTL_FILE.file_type;
  v_name COMPANIES.NAME%type;
begin
  v_file := UTL_FILE.fopen('PRDIR', 'companies.csv', 'R');

  loop
    begin
      UTL_FILE.get_line(v_file, v_name);

      insert into COMPANIES(name) values(v_name);

      exception when No_Data_Found then exit;
                when Reference_Constraint_Violated then continue;
                when Unique_Constraint_Violated then continue;
    end;
  end loop;

  UTL_FILE.fclose(v_file);
  commit;
end;

--select count(*) from COMPANIES;
--
-- delete from COMPANIES where 1=1;


--airplanesTypes
declare
  Reference_Constraint_Violated exception;
  pragma exception_init(Reference_Constraint_Violated, -2291);
  Unique_Constraint_Violated exception;
  pragma exception_init(Unique_Constraint_Violated, -00001);

  v_file UTL_FILE.file_type;
  v_model AIRPLANES_TYPES.MODEL%type;
  v_speed AIRPLANES_TYPES.SPEED%type;
  v_fuel_capacity AIRPLANES_TYPES.FUEL_CAPACITY%type;
  v_fuel_economy AIRPLANES_TYPES.FUEL_ECONOMY%type;
  v_capacity AIRPLANES_TYPES.CAPACITY%type;
begin
  v_file := UTL_FILE.fopen('PRDIR', 'airplanesTypes.csv', 'R');

  loop
    begin
      UTL_FILE.get_line(v_file, v_model);

      v_speed := DBMS_RANDOM.value(800, 1000);
      v_fuel_capacity := DBMS_RANDOM.value(25000, 30000);
      v_fuel_economy := DBMS_RANDOM.value(10, 40);
      v_capacity := DBMS_RANDOM.value(200, 400);

      insert into AIRPLANES_TYPES(MODEL, SPEED, FUEL_CAPACITY, FUEL_ECONOMY, CAPACITY) values(v_model, v_speed, v_fuel_capacity, v_fuel_economy, v_capacity);

      exception when No_Data_Found then exit;
                when Reference_Constraint_Violated then continue;
                when Unique_Constraint_Violated then continue;
    end;
  end loop;
  UTL_FILE.fclose(v_file);
  commit;
end;


--select count(*) from AIRPLANES_TYPES;
--
-- delete from AIRPLANES_TYPES where 1=1;


--airplanes
declare
  type models_array_t is varray(1024) of AIRPLANES.MODEL%type;
  type companies_array_t is varray(1024) of AIRPLANES.COMPANY%type;

  v_models models_array_t;
  v_models_count int;
  v_companies companies_array_t;
  v_companies_count int;

  v_model_index int;
  v_company_index int;
begin
  select model bulk collect into v_models from AIRPLANES_TYPES;
  select name bulk collect into v_companies from COMPANIES;

  v_models_count := v_models.COUNT;
  v_companies_count := v_companies.COUNT;
--todo: 100 000 airplanes
  for v_i in 1..100000 loop
    v_model_index := DBMS_RANDOM.value(1, v_models_count);
    v_company_index := DBMS_RANDOM.value(1, v_companies_count);

    insert into AIRPLANES(ID, MODEL, COMPANY) values(v_i, v_models(v_model_index), v_companies(v_company_index));
  end loop;
end;

-- select count(*) from AIRPLANES;
--
-- delete from AIRPLANES where 1=1;


--flights
declare
  type airports_array_t is varray(8192) of AIRPORTS.NAME%type;

  v_airports airports_array_t;
  v_airports_count int;

  v_departure_index int;
  v_arrival_index int;

  v_departure_time FLIGHTS.DEPARTURE_TIME%type;
  v_arrival_time FLIGHTS.ARRIVAL_TIME%type;

  v_airplane FLIGHTS.ID_AIRPLANE%type;
  v_airplane_count int;
begin
  select code bulk collect into v_airports from AIRPORTS;

  v_airports_count := v_airports.COUNT;
  select count(*) into v_airplane_count from AIRPLANES;
--todo: 100 000 flights
  for v_i in 1..100000 loop
    v_departure_index := DBMS_RANDOM.value(1, v_airports_count);
    loop
      v_arrival_index := DBMS_RANDOM.value(1, v_airports_count);
      exit when v_departure_index != v_arrival_index;
    end loop;

    v_departure_time := sysdate + DBMS_RANDOM.value(0, 1);
    loop
      v_arrival_time := sysdate + DBMS_RANDOM.value(0, 1);
      exit when v_departure_time < v_arrival_time;
    end loop;

    v_airplane := DBMS_RANDOM.value(1, v_airplane_count);
    select id into v_airplane from AIRPLANES where id = v_airplane;

    insert into FLIGHTS(ID, DEPARTURE_AIRPORT, ARRIVAL_AIRPORT, ID_AIRPLANE, DEPARTURE_TIME, ARRIVAL_TIME) values(v_i, v_airports(v_departure_index), v_airports(v_arrival_index), v_airplane, v_departure_time, v_arrival_time);
  end loop;
end;

-- select count(*) from FLIGHTS;
--
-- delete from FLIGHTS where 1=1;


--hotel_bookings
create table INDEXED_HOTELS as select ROWNUM as id, HOTELS.* from HOTELS;
/
create index hotels_id_index on INDEXED_HOTELS (id);
/

-- select * from INDEXED_HOTELS where id = 10;

declare
  Reference_Constraint_Violated exception;
  pragma exception_init(Reference_Constraint_Violated, -2291);

  v_customers_count int;
  v_hotels_count int;

  v_rand int;

  v_customer HOTEL_BOOKINGS.ID_CUSTOMER%type;
  v_hotel HOTEL_BOOKINGS.HOTEL%type;
  v_check_in HOTEL_BOOKINGS.CHECK_IN%type;
  v_check_out HOTEL_BOOKINGS.CHECK_OUT%type;

  v_i int := 0;
begin
  select count(*) into v_customers_count from CUSTOMERS;
  select count(*) into v_hotels_count from INDEXED_HOTELS;
--todo: 2 mil tickets
  while v_i < 2000000 loop
    begin
    v_rand := DBMS_RANDOM.value(1, v_hotels_count);
    select name into v_hotel from INDEXED_HOTELS where id = v_rand;

    v_customer := DBMS_RANDOM.value(1, v_customers_count);
    v_check_in := sysdate + DBMS_RANDOM.value(0 ,1);
    loop
      v_check_out := sysdate + DBMS_RANDOM.value(0, 1);
      exit when v_check_in < v_check_out;
    end loop;

    insert into HOTEL_BOOKINGS(ID_CUSTOMER, HOTEL, CHECK_IN, CHECK_OUT) values(v_customer, v_hotel, v_check_in, v_check_out);
    v_i := v_i + 1;
    exception when Reference_Constraint_Violated then continue;
    end;
  end loop;
end;
/
drop index hotels_id_index;
/
drop table INDEXED_HOTELS;
/

-- select count(*) from HOTEL_BOOKINGS;
--
-- delete from HOTEL_BOOKINGS where 1=1;

--tickets
declare
  Reference_Constraint_Violated exception;
  pragma exception_init(Reference_Constraint_Violated, -2291);

  v_customers_count int;
  v_flights_count int;

  v_customer TICKETS.ID_CUSTOMER%type;
  v_flight TICKETS.ID_FLIGHT%type;
  v_price TICKETS.PRICE%type;
  v_seat TICKETS.SEAT%type;
  v_class TICKETS.CLASS%type;

  v_i int := 0;
begin
  select count(*) into v_customers_count from CUSTOMERS;
  select count(*) into v_flights_count from FLIGHTS;
  --todo: 2 mil tickets
  while v_i < 2000000 loop
    begin
    v_customer := DBMS_RANDOM.value(1, v_customers_count);
    v_flight := DBMS_RANDOM.value(1, v_flights_count);

    v_price := DBMS_RANDOM.value(50, 250);
    v_seat := DBMS_RANDOM.value(1, 500);
    v_class := DBMS_RANDOM.value(1, 3);

    insert into TICKETS(ID_CUSTOMER, ID_FLIGHT, PRICE, SEAT, CLASS) values(v_customer, v_flight, v_price, v_seat, v_class);
    v_i := v_i + 1;
    exception when Reference_Constraint_Violated then continue;
    end;
  end loop;
end;

-- select count(*) from TICKETS;
--
-- delete from TICKETS where 1=1;


select 'AIRPLANES', count(*) from AIRPLANES
union
select 'AIRPLANES_TYPES', count(*) from AIRPLANES_TYPES
union
select 'AIRPORTS', count(*) from AIRPORTS
union
select 'CITIES', count(*) from CITIES
union
select 'COMPANIES', count(*) from COMPANIES
union
select 'CONTINENTS', count(*) from CONTINENTS
union
select 'COUNTRIES', count(*) from COUNTRIES
union
select 'CUSTOMERS', count(*) from CUSTOMERS
union
select 'FLIGHTS', count(*) from FLIGHTS
union
select 'HOTEL_BOOKINGS', count(*) from HOTEL_BOOKINGS
union
select 'HOTELS', count(*) from HOTELS
union
select 'TICKETS', count(*) from TICKETS;
