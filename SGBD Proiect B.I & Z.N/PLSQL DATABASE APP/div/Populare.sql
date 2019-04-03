CREATE TABLE "EVENTS"(
  EVENTID INTEGER NOT NULL,
  "SOURCE" VARCHAR2(50 ),
  TYPE VARCHAR2(50 ),
  EVENT_DATE DATE,
  DESCRIPTION VARCHAR2(100 )
);
/
BEGIN  
FOR loop_counter IN 1..1000 LOOP 
INSERT INTO "EVENTS" (EVENTID, "SOURCE", TYPE, EVENT_DATE, DESCRIPTION) 
VALUES (loop_counter, loop_counter, 'warning', 
        TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J') ,TO_CHAR(DATE '9999-12-31','J'))),'J')
        ,dbms_random.value(1,100)
       ); 
END LOOP; 
COMMIT; 
END;
/
select *from events;


//// --create table + insertion random.

CREATE TABLE "CUSTOMERS"(
  ID INTEGER NOT NULL,
  "FIRST_NAME" VARCHAR2(50),
  "LAST_NAME" VARCHAR2(50),
  "EMAIL" VARCHAR2(50),
  "PASSWORD" VARCHAR2(50)
);
/
BEGIN  
FOR loop_counter IN 1..30 LOOP 
INSERT INTO "CUSTOMERS" (ID, "FIRST_NAME", "LAST_NAME", "EMAIL", "PASSWORD") 
VALUES 
(
loop_counter, 
DBMS_RANDOM.STRING('x', 10), 
DBMS_RANDOM.STRING('x', 10), 
DBMS_RANDOM.STRING('a', 10),
DBMS_RANDOM.STRING('a', 6)
); 
END LOOP; 
COMMIT; 
END;
/

//////////// -- generate name, name and randomise.

select
(select MIN(table2.id) from table2) as minid, (select MAX(table2.id) from table2) as maxid, 
(select table2.firstname from table2 where table2.id >= dbms_random.value(minid,maxid) order by table2.id limit 1) as rnd_firstname, 
(select table2.lastname from table2 where table2.id >= dbms_random.value(minid,maxid) order by table2.id limit 1) as rnd_lastname;

/////--asta iti face random si le adauga daca nu ma insel

insert into table2
select A.firstname, B.lastname
  from table1 A, table1 B
 where not exists(select 1 from table1 C
                   where C.firstname=A.firstname and C.lastname=B.lastname)

