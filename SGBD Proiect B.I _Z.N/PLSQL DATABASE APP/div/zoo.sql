DROP TABLE EMPLOYEES CASCADE CONSTRAINTS
/
DROP TABLE VISITORS CASCADE CONSTRAINTS
/
DROP TABLE ZOO_KEEPERS CASCADE CONSTRAINTS
/
DROP TABLE GUIDES CASCADE CONSTRAINTS
/
DROP TABLE PERSONS CASCADE CONSTRAINTS
/
DROP TABLE SPECIES CASCADE CONSTRAINTS
/
DROP TABLE SUBSPECIES CASCADE CONSTRAINTS
/
DROP TABLE ANIMALS CASCADE CONSTRAINTS
/
DROP TABLE ZOO_ZONES CASCADE CONSTRAINTS
/
DROP TABLE TICKETS CASCADE CONSTRAINTS
/
DROP TABLE ZONE_PROGRAM CASCADE CONSTRAINTS
/
DROP TABLE SUBSPECIES_MEALS CASCADE CONSTRAINTS
/
DROP TABLE MEALS_PROGRAM CASCADE CONSTRAINTS
/
DROP VIEW view_guides
/
DROP VIEW view_zoo_keepers
/
DROP VIEW view_child_visitors
/
DROP VIEW view_student_visitors
/
DROP VIEW view_pensionary_visitors
/
DROP VIEW view_normal_visitors
/
----------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE TICKETS(
ticket_type_id int NOT NULL,
ticket_type VARCHAR2(30) NOT NULL,
ticket_price NUMBER NOT NULL,
CONSTRAINT ticket_pk PRIMARY KEY (ticket_type_id)
);
/
--generare automata a cheii primare, la inserarea in tabel--
-----------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE tickets_sequence;
/
CREATE SEQUENCE tickets_sequence;
/
-----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER tickets_on_insert
  BEFORE INSERT ON TICKETS
  FOR EACH ROW
BEGIN
  SELECT tickets_sequence.nextval
  INTO :new.ticket_type_id
  FROM dual;
END;
/

------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE PERSONS(
person_id int NOT NULL ,
first_name VARCHAR2(40) NOT NULL,
last_name VARCHAR2(40) NOT NULL,
address VARCHAR2(70) DEFAULT NULL,
date_of_birth DATE NOT NULL,
phone_number VARCHAR2(30) NOT NULL,
CONSTRAINT PERSON_PK PRIMARY KEY (person_id)
)
/
----------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE persons_sequence;
/
CREATE SEQUENCE persons_sequence;
/

---------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER persons_on_insert
  BEFORE INSERT ON PERSONS
  FOR EACH ROW
BEGIN
  SELECT persons_sequence.nextval
  INTO :new.person_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE EMPLOYEES(
employee_id int NOT NULL,
employee_identity int NOT NULL,
hire_date DATE default sysdate,
salary NUMBER,
CONSTRAINT employee_pk PRIMARY KEY (employee_id),
CONSTRAINT fk_employee_identity FOREIGN KEY (employee_identity) REFERENCES PERSONS(person_id)
ON DELETE CASCADE
);
/

---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE employees_sequence;
/
CREATE SEQUENCE employees_sequence;
/
--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER employees_on_insert
  BEFORE INSERT ON EMPLOYEES
  FOR EACH ROW
BEGIN
  SELECT employees_sequence.nextval
  INTO :new.employee_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE GUIDES(
  guide_id int NOT NULL,
  employee_id int NOT NULL,
  CONSTRAINT guide_pk PRIMARY KEY (guide_id),
  CONSTRAINT fk_guide_identity FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
  ON DELETE CASCADE
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE guides_sequence;
/
CREATE SEQUENCE guides_sequence;
/
----------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER guides_on_insert
  BEFORE INSERT ON GUIDES
  FOR EACH ROW
BEGIN
  SELECT guides_sequence.nextval
  INTO :new.guide_id
  FROM dual;
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE VISITORS(
ticket_number int NOT NULL,
ticket_details_id int NOT NULL,
visitor_id int NOT NULL,
visit_date DATE default sysdate,
guide_assigned_id int not null,
CONSTRAINT VISITOR_PK PRIMARY KEY (ticket_number),
CONSTRAINT fk_visitor_identity FOREIGN KEY (visitor_id) REFERENCES PERSONS(person_id) ON DELETE CASCADE,
CONSTRAINT fk_ticket_details FOREIGN KEY (ticket_details_id) REFERENCES TICKETS(ticket_type_id) ON DELETE CASCADE,
CONSTRAINT fk_guide_id FOREIGN KEY (guide_assigned_id) REFERENCES GUIDES(guide_id) ON DELETE CASCADE
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE tickets_number_sequence;
/
CREATE SEQUENCE tickets_number_sequence;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER visitors_on_insert
  BEFORE INSERT ON VISITORS
  FOR EACH ROW
BEGIN
  SELECT tickets_number_sequence.nextval
  INTO :new.ticket_number
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ZOO_ZONES(
zone_id int NOT NULL,
zone_name VARCHAR2(25) NOT NULL,
zone_surface VARCHAR2(10),
zone_location VARCHAR2(30),
visiting_start_h VARCHAR2(10),
visiting_close_h VARCHAR2(10),
CONSTRAINT zone_pk PRIMARY KEY (zone_id)
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE zones_sequence;
/
CREATE SEQUENCE zones_sequence;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER zones_on_insert
  BEFORE INSERT ON ZOO_ZONES
  FOR EACH ROW
BEGIN
  SELECT zones_sequence.nextval
  INTO :new.zone_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ZOO_KEEPERS(
keeper_id int NOT NULL,
employee_id int NOT NULL,
zone_id int default NULL,
CONSTRAINT keeper_pk PRIMARY KEY (keeper_id),
CONSTRAINT fk_keeper_identity FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
ON DELETE CASCADE,
CONSTRAINT fk_zone_assigned FOREIGN KEY (zone_id) REFERENCES ZOO_ZONES(zone_id)
ON DELETE CASCADE
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE zoo_keepers_sequence;
/
CREATE SEQUENCE zoo_keepers_sequence;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER keepers_on_insert
  BEFORE INSERT ON ZOO_KEEPERS
  FOR EACH ROW
BEGIN
  SELECT zoo_keepers_sequence.nextval
  INTO :new.keeper_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SPECIES(
species_id int NOT NULL,
latin_name VARCHAR2(35),
species_name VARCHAR2(35) NOT NULL,
medium_height NUMBER,
medium_weight NUMBER,
medium_age int,
-- zone_id int NOT NULL,
CONSTRAINT species_pk PRIMARY KEY (species_id)
-- CONSTRAINT fk_species_zone FOREIGN KEY (species_id) REFERENCES ZOO_ZONES(zone_id)
-- ON DELETE CASCADE
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE species_sequence;
/
CREATE SEQUENCE species_sequence;
/

---------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER species_on_insert
  BEFORE INSERT ON SPECIES
  FOR EACH ROW
BEGIN
  SELECT species_sequence.nextval
  INTO :new.species_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SUBSPECIES(
subspecies_id int NOT NULL,
subspecies_name VARCHAR2(50) not null,
species_id int NOT NULL,
zone_id int not null,
CONSTRAINT subspecies_pk PRIMARY KEY (subspecies_id),
CONSTRAINT fk_subspecies_zone FOREIGN KEY (zone_id) REFERENCES ZOO_ZONES(zone_id)
ON DELETE CASCADE,
CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES SPECIES(species_id)
ON DELETE CASCADE
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE subspecies_sequence;
/
CREATE SEQUENCE subspecies_sequence;
/

---------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER subspecies_on_insert
  BEFORE INSERT ON SUBSPECIES
  FOR EACH ROW
BEGIN
  SELECT subspecies_sequence.nextval
  INTO :new.subspecies_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE ANIMALS(
animal_id int NOT NULL,
age int,
gender VARCHAR2(10),
subspecies_id int not null,
admission_date date,
CONSTRAINT animal_pk PRIMARY KEY (animal_id),
CONSTRAINT fk_animal_subspecies FOREIGN KEY (subspecies_id) REFERENCES SUBSPECIES(subspecies_id)
ON DELETE CASCADE
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE animals_sequence;
/
CREATE SEQUENCE animals_sequence;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER animals_on_insert
  BEFORE INSERT ON ANIMALS
  FOR EACH ROW
BEGIN
  SELECT animals_sequence.nextval
  INTO :new.animal_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE MEALS_PROGRAM(
meal_id int NOT NULL,
feed_hour VARCHAR2(20) NOT NULL,
food_type VARCHAR2(50) NOT NULL,
CONSTRAINT submeal_pk PRIMARY KEY (meal_id)
);
/
--generare automata a cheii primare, la inserarea in tabel--
---------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP SEQUENCE meals_program_sequence;
/
CREATE SEQUENCE meals_program_sequence;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER meals_on_insert
  BEFORE INSERT ON MEALS_PROGRAM
  FOR EACH ROW
BEGIN
  SELECT meals_program_sequence.nextval
  INTO :new.meal_id
  FROM dual;
END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE SUBSPECIES_MEALS(
subspecies_id int NOT NULL,
meal_id int NOT NULL,
CONSTRAINT fk_subspecies_id FOREIGN KEY (subspecies_id) REFERENCES SUBSPECIES(subspecies_id)
ON DELETE CASCADE,
CONSTRAINT fk_meal_id FOREIGN KEY (meal_id) REFERENCES MEALS_PROGRAM(meal_id)
ON DELETE CASCADE
);
/

------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------VIEWS----------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW view_guides AS
  SELECT guide_id as Guide_id, first_name as FirstName, last_name as LastName, salary as Salary
  FROM
  guides g join employees e on g.employee_id=e.employee_id
  join persons p on e.employee_identity=p.person_id;


CREATE OR REPLACE VIEW view_zoo_keepers AS
  SELECT keeper_id AS Keeper_id, first_name as FirstName, last_name as LastName, salary AS Salary, zone_id as Zone_id, zone_name as Assigned_Zone_Name
  FROM
  zoo_keepers k join employees e on k.employee_id=e.employee_id
  join persons p on e.employee_identity=p.person_id
  join zoo_zones z on k.zone_id=z.zone_id;


CREATE OR REPLACE VIEW view_child_visitors AS
  SELECT ticket_number, ticket_type, ticket_price, p.first_name||' '||p.last_name as Visitor_Name,
  floor((SYSDATE-p.date_of_birth)/365) AS Visitor_Age, p2.first_name||' '||p2.last_name as Guide_Name, visit_date
  from visitors v join persons p on v.visitor_id=p.person_id
  join guides g on v.guide_assigned_id=g.guide_id
  join employees e on g.employee_id=e.employee_id
  join persons p2 on e.employee_identity=p2.person_id
  join tickets t on v.ticket_details_id=t.ticket_type_id and ticket_type like '%child%'
  order by ticket_number;



CREATE OR REPLACE VIEW view_student_visitors AS
  SELECT ticket_number, ticket_type, ticket_price, p.first_name||' '||p.last_name as Visitor_Name,
  floor((SYSDATE-p.date_of_birth)/365) AS Visitor_Age, p2.first_name||' '||p2.last_name as Guide_Name, visit_date
  from visitors v join persons p on v.visitor_id=p.person_id
  join guides g on v.guide_assigned_id=g.guide_id
  join employees e on g.employee_id=e.employee_id
  join persons p2 on e.employee_identity=p2.person_id
  join tickets t on v.ticket_details_id=t.ticket_type_id and ticket_type like '%student%'
  order by ticket_number;


CREATE OR REPLACE VIEW view_pensionary_visitors AS
  SELECT ticket_number, ticket_type, ticket_price, p.first_name||' '||p.last_name as Visitor_Name,
  floor((SYSDATE-p.date_of_birth)/365) AS Visitor_Age, p2.first_name||' '||p2.last_name as Guide_Name, visit_date
  from visitors v join persons p on v.visitor_id=p.person_id
  join guides g on v.guide_assigned_id=g.guide_id
  join employees e on g.employee_id=e.employee_id
  join persons p2 on e.employee_identity=p2.person_id
  join tickets t on v.ticket_details_id=t.ticket_type_id and ticket_type like '%pensionary%'
  order by ticket_number;


CREATE OR REPLACE VIEW view_normal_visitors AS
  SELECT ticket_number, ticket_type, ticket_price, p.first_name||' '||p.last_name as Visitor_Name,
  floor((SYSDATE-p.date_of_birth)/365) AS Visitor_Age, p2.first_name||' '||p2.last_name as Guide_Name, visit_date
  from visitors v join persons p on v.visitor_id=p.person_id
  join guides g on v.guide_assigned_id=g.guide_id
  join employees e on g.employee_id=e.employee_id
  join persons p2 on e.employee_identity=p2.person_id
  join tickets t on v.ticket_details_id=t.ticket_type_id and ticket_type like '%normal%'
  order by ticket_number;


----------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------inserare persoane->PERSONS-------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------

--SET SERVEROUTPUT ON;

DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_nume varr := varr('De Hailes','Gail','Edland','Dable','Crass','Welden','Loftin','Redolfi','Ranby','Weblin','Mundwell','Klaaassen','Merrill','Bredee','Heiss','Knatt','Aldren','Kettleson','Stredder','Fowlds','Eastgate','Gault','Rubinowitch','Kristufek','Wanek','Mercy','Huygens','Red','Elmore','Mitskevich','Madill','Wharlton','Gerriet','Tiddy','Norvell','Wigin','Delagnes','Tolemache','Pidcock','Stegel','Daglish','Domelow','Bly','Jennison','Matusson','McClary','Pammenter','Kincla','De Caroli','Collip','Nanelli','Tully','Applewhite','Gotthard','Oscroft','Dumberrill','Selbie','Amery','Brave','Palfreyman','Taberer','Woodruff','Keiley','Brewerton','Veronique','Booeln','Murden','Mcall','Ruseworth','Wickardt','Martinet','Andrag','Paquet','Brightwell','Millmore','Fance','Trollope','Sturgis','Buddington','Delgado','Boyland','Haverty','Salvin','Whaley','Peers','Lombardo','Woof','Tuckey','Joron','Wrey','Diglin','Knewstub','Dyke','Gwilliam','Knibbs','Glashby','Billo','Venour','Caughte','Tuite','Cissen','Mead','Luxon','Dessent','Stormonth','Goffe','Kanzler','McDonald','Gillbard','Stokoe','Winley','Farrant','Crolla','Boulds','Siddall','Tuberfield','Anthoine','Pickersgill','Bogays','Swinden','Mixhel','Schoenrock','Orpen','Hassur','Torry','McClements','Milson','Foulsham','Stetlye','Camplejohn','Hamil','Gunthorp','Vell','Dumke','Reiling','Winslow','Fairnie','Albarez','Kemmis','Patient','Swaddle','Greenrod','Capponer','Hayfield','Perch','Martinon','Teggin','Helling','Heasly','Piniur','Simonutti','Frascone','Rowbury','Woolager','Griffitts','Purton','Orrett','Weepers','Lowden','Robart','Parsand','Leggs','Greenleaf','Witherby','Penk','Sempill','Quant','De Vries','De Dei','Billiard','Pendre','Davenhill','Burbury','Alennikov','Bridgwater','Pitford','Stennett','Pourveer','Braferton','Cullinan','Tixier','Santino','Ruter','Dysart','Guilloux','Jones','Kleuer','Roderick','Edmeades','Brown','Yakhin','Momford','Westoff','Grzeskowski','Orwin','Petken','Murricanes','Coady','Curtoys','Pieche','Gaspero','McIver','Schirach','Yorston','Fursey','Stampe','Okey','Tollet','Rockwell','Cowitz','Wager','Creevy','McAline','Mellem','Shipway','Selbie','Oxenden','Chicchelli','Camolli','Somerled','Bjerkan','MacLaverty','McClure','Linnett','Catlow','Goldstraw','Woodes','Haster','Eyckelbeck','Shurrock','Petru','De Freyne','Gales','Lidgett','Ruffell','Screwton','de Almeida','Donhardt','Sommerled','Lorenz','Dalwood','Confort','Basterfield','Gwyneth','Lenchenko','Doblin','Fritchly','Jesse','Vittet','Follows','Awdry','Banasevich','Parchment','Semple','Caizley','Duffill','Whorlow','Farnhill','Spinney','Robbie','Mercy','Alvarez','Frend','Lepper','Rabjohns','Mallam','Miklem','Matt','Reimer','MacCurlye','Attlee','Otley','Lineker','Proudlove','Houson','De Vaar','Girvin','Presshaugh','Langford','Hallas','Duckels','Claybourn','Porson','Meran','Mechic','Pullan','Parnby','Grane','Dibson','Loftus','Gillman','Paladini','Clayson','Dutnell','MacBrearty','Linguard','Keynd','Stansbie','McGarel','Roycroft','Wolford','Mattimoe','Clamp','Manna','Cottle','Danielsson','Langabeer','Sweetlove','Newgrosh','Tweed','Smalman','Speirs','Godmer','Pittam','Sime','Monkman','Izzett','Sill','Attwooll','Blodgett','Sand','Fetherston','Blackall','Sanpher','Danick','Brandreth','Shutt','Sabbatier','Streader','Alsopp','Broseke','Schach','Waple','Jurasz','Syversen','Georges','Brinsford','Brilleman','Bourne','Bobasch','Tucknott','Arenson','Overlow','Livezey','Trahair','Clines','Coggen','Pridmore','Criple','Fitzmaurice','Lademann','Prys','Peddie','Goodricke','Mendonca','McCool','Geal','Guesford','Deppe','Grimsey','Opfer','Huckerbe','Moen','Haigh','Clayal','Braidon','Conew','Gouge','McGurk','Venart','Flamank','Grinsted','Cauley','Whissell','Selesnick','Beastall','Warlowe','Greenwell','Noddles','McCarty','Metcalf','Sara','Sage','O''Doherty','Clawsley','Hellwing','Exroll','Arling','Bilovsky','Teare','de Lloyd','Sidney','Cleaver','Malkin','Leroux','Wyllie','Pallaske','Joanaud','Hoggin','Issacoff','Tirkin','Stockings','Gayter','Croisdall','Sacaze','Osband','Tawton','Lindwasser','Dulanty','Nelsey','Thackray','Dewdney','Lemmer','Aughton','Bourdis','MacElharge','Vooght','Coupman','Bewley','Fishley','Van der Velden','Brozsset','Stamp','Weatherhead','Mayling','Garmans','Grigoriev','Vink','Benton','Harlett','Guitton','Bridie','Arnot','Legge','Camerati','Carslaw','Freiburger','Silkstone','Lean','O''Fogarty','Axelby','Tenaunt','MacDunlevy','Charpling','Mustarde','Banger','Salerno','Collar','Tellenbrook','Bonaire','Beauly','Kirkhouse','Antley','Giron','Clibbery','Rikkard','Gunn','Ettridge','Danbye','Winram','Newbury','Herche','Breakey','Lorrimer','Huyge','Di Frisco','Colleford','Verdie','Armes','Shanklin','Dornin','Allender','de la Tremoille','Stocking','Cluer','Espadas','Bessent','Enrietto','Matthessen','Sircomb','Couzens','Livett','Starmore','Blackader','Seeviour','Bemlott','Windmill','Webburn','Inett','Agiolfinger','Wanley','McConway','Stachini','Dightham','Allner','Iveson','Gages','Aiken','Quarmby','Goldthorpe','Garrioch','Ramsbottom','Di Franceshci','Garz','Morter','Breslin','Blazey','Label','Pietesch','Nicholas','Baelde','Farman','Besnardeau','Lodemann','Jindacek','Bellringer','Aldington','Kamienski','Escalero','Searle','Surmeir','Rumens','MacFarlane','Bergstrand','Le Leu','Glasper','Plante','Fluger','Collingworth','Thorndale','Genders','Varnham','Treanor','Crum','Ingray','Thewles','Brazil','Kilby','Midford','Satch','Gladwell','Brough','Elington','Reveley','Bursnoll','Scatcher','Itzakovitz','Abbotson','Otton','Morgans','Mougenel','Fogel','Byk','Rawling','Oldred','Alleyn','Murrhardt','Whipple','Brislane','Happer','Hawkswood','Glasman','Dunnet','Kimber','Jedrzej','Vannacci','Colleran','Harrema','Dornin','Henrionot','Grene','Cluet','Lowthorpe','St. Ledger','Americi','Boorer','Innerstone','Heinsh','Watkiss','Tye','Andrichak','Buttler','Booij','Bradnocke','Castro','Ventom','Oselton','Gahagan','Grishelyov','Berridge','Harraway','Halsho','Likely','Brimicombe','Rubinovici','Clemenzo','Kennifeck','Jobke','Moehler','McAuslene','McKerton','Pantridge','de Voiels','Vian','Stamps','Brookhouse','Gockelen','Hudel','Couzens','Dell''Abbate','Murrum','Whinney','Steddall','Andrzej','Lightowler','Mangam','Gowthrop','McGloin','Hallibone','Perkinson','Tarr','Padillo','Atterley','Annandale','Dagger','Hunn','Kermott','Cotelard','Grimolbie','Just','Keattch','Leddy','Lawles','Chaffey','Mayler','Andrieu','Sowood','Mowson','Wellesley','Cornell','Compford','Kollaschek','Eilhart','Giffaut','McIlmorow','Berth','Ludewig','Stairs','Carlesi','Winfield','Goldthorpe','Rumble','Craigmile','Goodier','McLaine','Stuchburie','Tansill','Welfair','Ivankin','Furbank','Aaronson','MacTrustie','Kull','Berk','Elson','Sasser','Barbery','Reaman','Deeman','Wallbutton','Zum Felde','Schneidau','Christofle','Tumber','Canwell','Czaple','Savege','Heinzel','Philliskirk','Scrivener','Gretton','Toman','Gagie','Bladesmith','Morican','Wreford','Devenny','Dobsons','Stevens','Samber','Youll','O''Ruane','Lazenby','Blindt','Awin','Rohan','D''Elia','Levee','Seymark','Colebeck','Smedley','Frowde','Brosetti','Glenton','Colleymore','Hopfer','Phizackerly','Pybus','Grigorian','Hollier','Fairbeard','Von Der Empten','Kelledy','Myles','Bellows','Escalero','Dunsmore','Geldard','Boobier','Shippard','Dansie','de Chastelain','Bramley','McGinnell','Danzig','Mathwen','Edmead','Balchen','Klus','Mollindinia','Breznovic','Weinmann','Coppard','Bovaird','Grandham','Grono','Blesing','Errichelli','Gallaccio','Fattorini','Bache','Goodban','Rannald','Flello','Culwen','Jeannesson','Scrase','Rosengarten','Garrettson','Ripsher','Izakson','Shelly','Lorenzini','Carleton','Syne','Speeding','Jonk','Treppas','Flye','Ephgrave','Dominik','Dacombe','Loney','Eberdt','Jouanot','Gonet','Rosenstein','Durkin','Philpot','Beddis','Conahy','Burberow','Schneidau','Frounks','Finkle','Harlock','Erskine','Sampson','Clench','Schukraft','Reichelt','Boyne','Sepey','Boriston','Meers','Buckel','Birkby','Crighton','Norcliff','Pimme','Dorcey','Radnage','Rosenboim','Beacock','Abramovitch','McDiarmid','Layson','Martschke','Byng','Cescot','MacKeever','Feitosa','Shinefield','Gino','Elintune','Smallpeace','Cosker','Easen','Foley','Playhill','Ottawell','Curm','O''Lahy','Pascoe','Ropp','Suart','Mee','Bolle','Billborough','Evreux','Coopman','Haacker','Gleasane','Oldfield','Lytle','MacAdie','Craigheid','Larham','Grange','Ziems','Mangenot','Coverly','Barker','Cadamy','Thairs','Porch','Antushev','Brampton','Okell','Esparza','Diggin','Vatini','Knoton','Seden','Lafranconi','Dimitriev','Benne','Rushman','Roslen','Bugdale','Lambard','Longdon','Kmiec','Matteuzzi','Lantaff','Hirtz','Ferreli','Trasler','Allcroft','Atkinson','MacPaden','Gleed','Ahlf','Tebbs','Dinsell','Eskriet','Ealden','Dunlap','Wilber','Salter','Ballendine','Fittall','Porcher','Hudd','Youll','McAuslene','Curphey','Zorzi','Domenici','Boustred','Jallin','Bottlestone','Gleave','Hatherell','Cogley','Blanchet','Probart','Hendrik','Preon','Maskall','Cluatt','Been','Raynes','Hinsch','Lambert-Ciorwyn','Wapples','Flade','Matthiesen','Ambroisin','MacCard','Muzzullo','Rillatt','Chinnick','Merigeau','Togher','Lancashire','Ludovico','Keefe','Quigg','Devanny','Huyge','Smallbone','Smith','Ruskin','Coppard','Extal','Wilkin','Popescu','Ruben','Simms','Danit','Brookes','Whines','Orrice','Briddock','Hatcher','Bloxholm','Worcs','Vaun','Smees','Shee','Randerson','Eldered','Fairbank','Scade','Bunstone','Towner','Champney','Baiden','Gillison','Eastup','Forkan','Colkett','Ponten','Sutterfield','Halbord','Cutchee','Scroggie','Honisch','Paynter','Rust','Oxtaby','Glenny','Engeham','Masser','Labusquiere','Bilham','Sadler','Hawick','Dainty','Grimoldby','Bygott','Boig','Prescot','Ragsdale','Petrushanko','Hargroves','Twiddy','Sutworth','Quinnelly','Toller','Linner','Wainman','Daymont','Demelt','Peotz','Squibbs','Barthelemy','Van Der Weedenburg','Antonik','Cremin','Rissen','Cammomile','Kennally','Fancutt','Flattman','Whyte','Vanyatin','Lanney','Leupoldt','Scoone','Filchagin','Beauly','Postle','Dobrowlski','Izkoveski','Rutley','Killcross','Cridland','Astman');
  lista_prenume varr := varr('Ally','Toddy','Leonerd','Stevana','Arluene','Geralda','Gilberto','Gualterio','Wyatan','Eldredge','Caritta','Mandi','Emlen','Gusta','Davy','Pren','Cecilio','Reid','Kelby','Artemas','Krystal','Katey','Chancey','Gannon','Ezechiel','Britte','Maribeth','Felice','Thatch','Marietta','Pattin','Jocelin','Laurent','Eveleen','Veriee','Dicky','Val','Hetty','Rosella','Almeda','Jackelyn','Christye','Burk','Aldric','Hilary','Cherey','Lenore','Ivett','Guillermo','Enrique','Sergei','Shaw','Sheila-kathryn','Muriel','Erek','Iseabal','Boony','Tatum','Bendix','Aviva','Anette','Chloette','Katerina','Huey','Annalise','Corbie','Casar','Harmon','Alvina','Dorothee','Nolan','Thea','Sissy','Gabriell','Silvanus','Garrett','Trina','Imogene','Myrvyn','Harri','Barth','Trescha','Chrystel','Cybill','Cherey','Sandie','Vonni','Harman','Gayel','Sutherlan','Doreen','Jaquelin','Sonia','Cordi','Ange','Kit','Jules','Cleveland','Orly','D''arcy','Becca','Denney','Bernadina','Chrisy','Rosabella','Paquito','Jermaine','Sadye','Clotilda','Jasper','Kalinda','Artemis','Holmes','Robbyn','Elvira','Megen','Helenelizabeth','Peterus','Sorcha','Rufe','Dorian','Zechariah','Delmar','Russell','Daisy','Charmine','Daryle','Dev','Corrie','Lazarus','Harv','Aleen','Charisse','Silas','Griffy','Noami','Heywood','Ranna','Eleanore','Jan','Jacynth','Eileen','Alana','Johnnie','Cully','Yetta','Abigael','Drew','Celia','Yoshiko','Rozanna','Eadith','Rickey','Lesley','Domingo','Tessa','Fredek','Gayel','Xylina','Melosa','Mackenzie','Janenna','Karine','Sherlocke','Pate','Annalee','Lanie','Archibald','Goober','Gavrielle','Noam','Timmy','Kevin','Radcliffe','Blake','Elli','Petey','Geneva','Hinze','Karalee','Blondell','Laura','Demetri','Shaughn','Maureene','Steffie','Berkie','Kay','Paulo','Calla','Jaymie','Alan','Jade','Wayland','Theressa','Angelita','Nefen','Torie','Eleanora','Mallorie','Alphonso','Theo','Minne','Gwenny','Aguistin','Silvio','Baron','Merle','Gage','Fons','Engracia','Rina','Justis','Sol','Corabel','Inglebert','Pammy','Jodie','Natassia','Bidget','Monti','Shanta','Banky','Mari','Eda','Kara','Salaidh','Corinne','Alonso','Meredithe','Raquela','Billie','Tamiko','Leicester','Elroy','Hobey','Gray','Bert','Alleyn','Maddalena','Meagan','Kennie','Fee','Cathryn','Elianora','Edyth','Fionna','Giraldo','Rona','Krystle','Dietrich','Beverly','Moira','Marlin','Melamie','Lilllie','Odelinda','Janetta','Carmine','Stephenie','Bride','Deloria','Inessa','Elisha','Windham','Adriano','Kipp','Felicia','Nerita','Avery','Drusy','Humfrid','Hedwig','Anthony','Opal','Paola','Gerrilee','Finn','Zorah','Dominica','Bronson','Fielding','Estele','Leon','Nelie','Aviva','Marillin','Caldwell','Alric','Sallyann','Robby','Rudyard','Marje','Lisabeth','Keefe','Harcourt','Tris','Katey','Wrennie','Clareta','Mirelle','Cissy','Jodie','Flossie','Nessi','Teirtza','Frasquito','Kristoforo','Andreas','Shelly','Sayres','Codi','Tawnya','Corby','Marlon','Reg','Pearla','Sayers','Junie','Ailene','Spencer','Lulita','Lazaro','Tatiana','Lucky','Celestyna','Leona','Loreen','Jodie','Aime','Selena','Maxim','Berne','Bettine','Ingar','Mylo','Diena','Ev','Saunder','Kris','Staford','Abbie','Dorella','Urbanus','Ashley','Camila','Dorey','Kikelia','Standford','Morgana','Welch','Cyb','Cullin','Fedora','Barbey','Goran','Elnora','Marin','Loren','Lemmy','Elie','Rodrigo','Tallie','Alla','Ennis','Paulie','Leora','Putnam','Stephine','Earvin','Malinda','Rodolfo','Keith','Bernardina','Isahella','Shantee','Gaile','Mort','Rickie','Rutherford','Carma','Blondy','Julia','Vlad','Siana','Maurise','Prentice','Karoly','Fanya','Erie','Betsey','Idaline','Jorry','Maurise','Andres','Clarke','Sanford','Cymbre','Zsazsa','Jojo','Milissent','Sollie','Nikki','Barbe','Reagen','Ramonda','Devondra','Monah','Olga','Daisy','Juline','Aeriela','Mahalia','Trip','Tobie','Reggi','Cull','Madalyn','Amanda','Lannie','Torrence','Constantine','Jdavie','Cindelyn','Caroline','Denis','Timothy','Daron','Othelia','May','Olvan','Bernita','Cassi','Sella','Adolphus','Lory','Fianna','Meryl','Claudie','Elias','Ode','Mitchael','Paola','Fenelia','Alejandro','Ramsay','Emmalyn','Tracie','Beverly','Gabriele','Jorge','Kassey','Patty','Boote','Harmonie','Danit','Adelina','Virgina','Rosalinda','Paige','Eberhard','Gerta','Allard','Nancee','Stanfield','Calla','Elberta','Hettie','Elspeth','Iormina','Sileas','Codee','Demetre','Corinna','Rorke','Gayle','Jesselyn','Artair','Brynne','Hadleigh','Colette','Amanda','Carly','Cristal','Mickie','Ketti','Tess','Biddie','Tabb','Emelina','Janaya','Orelia','Curcio','Dalt','Oswell','Rolph','Vern','Adolpho','Caritta','Jenifer','Milt','Lora','Tomkin','Lawrence','Abigail','Ced','Gwendolen','Misty','Thain','Tomasine','Wilow','Ambros','Sidonia','Allys','Brendin','Myca','Rori','Inigo','Jerrie','Chane','Basilius','Imogene','Kailey','Clemence','Any','Stevie','Kaye','Willetta','Taylor','Chilton','Noelyn','Manon','Rafe','Evey','Ginevra','Joel','Vivi','Lombard','Joey','Kelley','Thedrick','Bari','Evelina','Garold','Alexandros','Austina','Gwyneth','Elke','Louella','Shara','Aleda','Gwendolin','Dag','Beatrisa','Gradeigh','Tommy','Linnie','Kelly','Britt','Merrily','Ann-marie','Elden','Jocko','Cary','Roxanne','Othella','Warde','Arman','Tammy','Erma','Ferdy','Randy','Ralf','Halsey','Petr','Delbert','Doyle','Flori','Germain','Peter','Noel','Marguerite','Mycah','Aland','Rollie','Cindy','Kalila','Ambur','Chrystal','Jean','Robert','Prescott','Gloria','Jimmie','Mag','Norris','Susi','Mareah','Carmina','Silas','Almire','Goober','Natividad','Maynard','Horst','Dionysus','Karee','Camella','Gib','Brynn','Nadia','Cyndie','Arv','Vania','Denyse','Renault','Mabel','Lazaro','Donnie','Tersina','Sibyl','Katharina','Victoria','Nettie','Sadye','Klarrisa','Ewell','Lothaire','Quent','Luise','Dorelle','Loren','Agneta','Coletta','Giffy','Berny','Tisha','Lorenza','Oswald','Isa','Giff','Laureen','Addie','Lorant','Vasilis','Emmy','Merwyn','Fonzie','Quinta','Phedra','Quinn','Dominique','Bernita','Noak','Lacy','Rhianna','Nani','Frasco','Tamma','Carmencita','Wendeline','Michale','Kristofer','Nolie','Lonnard','Ilise','Rosemaria','Daryl','Adler','Kittie','Gail','Farly','Poul','Elicia','Boyce','Pooh','Roxie','Barris','Barbi','Torrin','Eimile','Filbert','Helaina','Elbertina','Abbie','Agustin','Elsinore','Ursuline','Roxy','Carmelle','Zane','Sibelle','Madelyn','Elsworth','Ardene','Lyndsey','Alexandro','Merrill','Engracia','Gloriana','Chan','Lorna','Kit','Dino','Emanuele','Reube','Gwenny','Kellia','Maryl','Morgan','Cobb','Cleavland','Bernelle','Cloe','Mallissa','Jacinda','Harwell','Ethe','Torrin','Belle','Oralia','Dmitri','Corny','Kent','Zonnya','Aurore','Zea','Rickert','Maure','Salvatore','Mahalia','Linette','Barnett','Julianna','Auria','Marcia','Romona','Welsh','Ailee','Barron','Beverlie','Dominique','Kandace','Viviene','Glenna','Sinclair','L;urette','Farlay','Harri','Letty','Kelly','Biddy','Kary','Chandler','Zak','Dolly','Leeann','Wilt','Veronica','Annmarie','Belicia','Temple','Petunia','Brinn','Mitch','Veronica','Marnia','Joell','Alexandrina','Berton','Calvin','Denyse','Francklyn','Raquel','Keslie','Jo-ann','Shari','Stephana','Blondelle','Shanon','Gerda','Hermann','Vasilis','Jojo','Denys','Tracie','Tymothy','Tallulah','Barrett','Devina','Layla','Emilio','Brandy','Constantine','Alaric','Andris','Fons','Henrik','Keeley','Galvan','Ernesto','Lou','Cesar','Briana','Murry','Launce','Francesco','Gran','Garald','Cecilio','Edmund','Alasdair','My','Deane','Hetti','Welch','Hirsch','Silvia','Gifford','Fleur','Hersch','Harwilll','Rabi','George','Con','Linus','Ewen','Kalli','Corrina','Bengt','Gwenette','Erek','Karleen','Kaja','Grazia','Barnett','Byrom','Lucretia','Lesli','Seumas','Tiler','Emmy','Javier','Amelia','Emera','Cecil','Eadie','Borg','Eadmund','Brandy','Jolene','Fletch','Luelle','Hervey','Cyndia','Nero','Jemmie','Tonie','Eadmund','Theodoric','Welbie','Son','Darby','Glynda','Karena','Jefferey','Quintin','Sandro','Lillis','Burch','Ingaborg','Anya','Cly','Keefer','Karee','Dale','Gertrudis','Riley','Darbie','Derron','Benny','Arie','Vikki','Cassie','Virgina','Minda','Gray','Baird','Cheslie','Doti','Kris','Rafaelita','Tiler','Christoffer','Kariotta','Odella','Frazier','Karla','Reg','Doretta','Zandra','Melloney','Betsy','Rick','Murvyn','Maye','Jenica','Catina','Morgun','Guglielmo','Ophelie','Tabbie','Gerry','Duane','Christiana','Lanny','Ranee','Shalne','Halsey','Mignonne','Stanley','Lula','Troy','Fidelio','Shauna','Ami','Simonne','Modestia','Alexandros','Rory','Kara-lynn','Crichton','Jere','Joletta','Derrik','Doti','Jinny','Charyl','Weidar','Allyn','Mendel','Othella','Sibeal','York','Jonathon','Kristoffer','Mata','Kirsten','Miranda','Norine','Faulkner','Blane','Paulita','Benji','Aaren','Chip','Margalo','Floyd','Amargo','Ingar','Joan','Creighton','Kane','Patton','Hedy','Winston','Mariann','Chrotoem','Appolonia','Gary','Portie','Stern','Moise','Farlay','Leroy','Danell','Corbin','Claresta','Jarrid','Stormi','Rivkah','Rodrigo','Birgitta','Cara','Kassandra','Elene','Delainey','Sid','Trish','Yolanthe','Ediva','Gwynne','Wash','Sisely','Vanda','Annette','Jonell','Wilek','Dorthea','Weider');
  lista_adrese varr := varr('83 Orin Junction','06139 Dawn Way','188 Forest Run Road','3 Vernon Avenue','593 Dapin Avenue','89 David Place',
    '1064 Tomscot Alley','730 Farragut Street','86 Summerview Circle','71394 Chive Crossing','324 Karstens Way','102 Westend Trail','347 Anthes Parkway','19645 Hovde Crossing','98 Buena Vista Trail','6288 Anhalt Parkway',
    '4057 Fallview Trail','1 Fuller Park','6491 Stephen Court','005 Shasta Parkway','13 Sutteridge Point','8605 Arrowood Plaza','42452 Waubesa Crossing','9 Union Road','41 Colorado Parkway','3376 Dahle Crossing','2 Carioca Crossing','85 Petterle Trail','1782 Spaight Lane','0 Farragut Drive','42646 Leroy Street','8 Bluestem Place','5648 Charing Cross Drive','29 Fordem Parkway',
    '90506 Rigney Drive','145 Eggendart Street','3 Bunting Crossing','4590 Bellgrove Terrace','78 Maple Wood Alley','0805 Northwestern Drive','142 Jackson Terrace','69084 Northland Center','1893 Westridge Drive','38 Onsgard Plaza','0 Sunfield Circle','01348 Fair Oaks Street','13 Westport Lane',
    '630 Village Place','88 Kedzie Road','08455 Atwood Lane','5418 Maple Wood Terrace','11986 Truax Way','45 Dunning Drive','43 Arkansas Parkway','9755 Boyd Hill','6 Mosinee Park','607 Talisman Plaza','514 Forest Run Hill','4 Artisan Lane','0585 Carpenter Point','394 Golf View Drive','55 Jenifer Hill','520 Paget Park',
    '0779 Green Center','70 Larry Street','70306 Lakeland Place','5 Roxbury Terrace','2751 Donald Way','75361 Declaration Junction','154 Laurel Drive','8564 Fallview Drive',
    '75 Victoria Place','92812 Algoma Road','12 Prairie Rose Road','685 Onsgard Crossing','134 Hoepker Crossing','4 Canary Junction','94779 Village Center','14785 Maple Avenue',
    '1896 American Street','7 Chinook Park','5871 Summerview Trail','0 Shoshone Road','6286 Truax Hill','66 Del Sol Hill','961 Mariners Cove Parkway','00272 Schlimgen Lane','18 Buena Vista Alley','3665 Eastlawn Avenue','10796 Little Fleur Street','84151 Erie Trail','201 Del Sol Trail','3 Sauthoff Alley','53 Ludington Park',
    '7 Fallview Crossing','88 Roxbury Trail','2 Columbus Terrace','514 Sommers Center','5953 Knutson Hill','49 Blackbird Terrace','81197 8th Park','14615 Cardinal Plaza','26412 Cherokee Lane','4850 Stone Corner Place','7943 Burrows Crossing','3847 Redwing Place','4 Milwaukee Lane','01843 Havey Hill','290 Lake View Way','642 Forest Avenue','04 Pankratz Park','36482 Old Shore Court','68442 Warner Park','5 Grasskamp Center','75 Tomscot Park','7 Beilfuss Pass','93810 Monica Circle','8 Schiller Way','1 Judy Court','0 Kensington Lane','66 Gerald Pass','149 Cherokee Center','784 Darwin Pass','264 Morrow Center','7 Birchwood Hill','373 Rusk Park','8488 Loomis Center','762 Northland Road',
    '7 Londonderry Drive','8 Eggendart Street','9 Jana Park','35 Sachtjen Court','96448 Spaight Plaza','998 7th Road','8 Waywood Park','840 Arrowood Park','44652 Thierer Street',
    '6971 Sachs Point','475 Monica Place','3172 Esch Terrace','2292 Transport Alley','79601 Lakewood Gardens Circle','77 Laurel Trail','290 5th Way','02 Brown Point','574 Meadow Vale Way','24842 Straubel Court','98031 Larry Trail','3014 Heath Circle','44 Old Gate Crossing','40258 Village Green Place','56219 Mockingbird Point','9235 American Street','736 Memorial Hill','37 Ridgeview Center','255 Golf Course Parkway','3434 Red Cloud Circle','6998 Crescent Oaks Park','9081 Roxbury Plaza',
    '694 Fieldstone Circle','915 Sauthoff Drive','629 Colorado Way','86000 Barnett Plaza','946 Stoughton Plaza','1562 Kim Plaza','344 Barnett Hill','8 Bashford Junction','1 Merry Hill','397 Colorado Parkway','70648 Esker Center','49036 Hanover Alley','097 Brentwood Park','0 Mccormick Circle','32956 Springs Crossing','35243 Sauthoff Pass','63379 Hoard Lane','26215 Portage Alley','9 Canary Avenue','77 Riverside Terrace','655 Heath Point','68 Kingsford Hill','1 Bluestem Road','6 Fairfield Terrace','453 West Terrace','8 Loftsgordon Court','024 Sommers Parkway','2273 Elka Parkway','304 Milwaukee Trail','4764 Morrow Street',
    '86685 Anthes Trail','9 Nobel Parkway','6328 Clemons Avenue','649 Ridgeview Parkway','403 Merchant Terrace','4961 Farmco Place','30979 Anthes Place','205 1st Court','179 Basil Avenue','8 Riverside Avenue','35236 Vidon Parkway','4345 Pine View Drive','37 Florence Center','27354 Mallory Parkway','9643 Crest Line Road','37 Westport Center','32 Thierer Court','8 Karstens Pass','45003 Mayfield Avenue','641 Lunder Street','29028 Northview Alley','7597 Namekagon Alley','6006 Aberg Plaza','3 Express Drive','87 5th Terrace','41 Red Cloud Terrace','5525 Loomis Drive','38 Glendale Alley','0 Everett Court','4833 Crescent Oaks Trail','299 Ruskin Alley','100 Dawn Circle','66 Blackbird Point','5 Lukken Parkway','0367 Fairview Circle','02975 Kings Place','9517 Sachs Junction','2754 Lerdahl Way','7 Clemons Way','8 Kings Drive','40837 Northport Trail','81 Park Meadow Drive','4 8th Avenue','0 Springview Pass','37455 Old Gate Alley','2 Lunder Park','97238 Arkansas Hill','12 Loeprich Junction','53283 Eastlawn Terrace','2519 5th Alley','86 Karstens Lane','230 Center Alley','1007 Sundown Circle','8269 Redwing Plaza','3 Di Loreto Court','898 Mcbride Alley','94 Canary Alley','1 Dottie Center','3348 Fair Oaks Trail','9 Saint Paul Place','56 Donald Drive','64 Trailsway Hill','052 Doe Crossing Lane','11 Morningstar Plaza','2 Holmberg Terrace','20 Forest Run Court','63 Novick Road','2744 Burrows Terrace','5 Packers Hill','357 Sunnyside Drive','39191 Burning Wood Hill','43223 Kropf Terrace','2 Texas Terrace','1247 Toban Avenue','19036 Blackbird Terrace','071 Quincy Alley','64524 Sutherland Road','353 Montana Hill','2 Tennessee Parkway','125 Surrey Parkway','02927 4th Way','05 Westerfield Drive','78 Darwin Plaza','9 High Crossing Crossing','163 Briar Crest Crossing','40 Larry Hill','9 Brickson Park Road','02625 Spenser Plaza','5583 Vahlen Trail','83 Caliangt Hill','4189 Stuart Street','28500 Beilfuss Hill','90925 Morrow Plaza','53640 Bultman Street','28218 Delladonna Trail','3 Riverside Road','93 Karstens Hill','75939 Mandrake Drive','56 Montana Point','84479 Carioca Center','1 Wayridge Trail','57 Esker Street','11664 Miller Street','56 Green Ridge Plaza','06 7th Parkway','018 Lindbergh Park','383 Prairieview Hill','57 Lunder Way','133 Butterfield Pass','64 Shoshone Park','76 Forest Hill','5 School Point','33013 Sachtjen Parkway','4 Brentwood Junction','846 Melody Point','1689 Dexter Way','93905 Starling Road','9441 Monica Pass','0 Lawn Avenue','269 Hayes Avenue','3948 Oneill Center','84 Hudson Plaza','56464 Mitchell Pass','326 Hooker Trail','21 Towne Avenue','0 Mitchell Point','37 Oneill Center','9837 Elka Center','8860 Morning Alley','80 Brickson Park Circle','93 Loftsgordon Crossing','40820 Dottie Trail','8055 Lindbergh Circle','81825 Cordelia Park','34 7th Hill','162 Mosinee Circle','36989 Summerview Terrace','7 Northview Way','63 David Trail','509 International Circle','60707 Derek Terrace','39839 Oak Hill','6946 Grim Crossing','8328 Alpine Pass','5 Sloan Hill','218 Chinook Street','8 Petterle Lane','30336 Bashford Parkway','727 Katie Pass','33 Green Parkway','07876 Waxwing Center','03536 Fairview Street','29685 Browning Road','96 Crescent Oaks Drive','416 Golf Road','1730 Stephen Alley','2192 Shoshone Court','7 Cordelia Avenue','0862 4th Crossing','73 Thompson Parkway','5923 Waywood Hill','10 Stephen Circle','1353 Canary Court','63 Mandrake Terrace','44 Express Circle','59607 Debra Street','2924 Miller Junction','515 International Junction','040 Eastwood Place','07492 Orin Alley','7292 Jay Center','2799 Redwing Center','230 Larry Crossing','16762 Sage Avenue','5767 5th Parkway','6835 High Crossing Park','38 Kingsford Way','971 Grasskamp Parkway','8 Pond Pass','14 Meadow Valley Road','443 Coleman Trail','6 Manley Plaza','2070 Arapahoe Terrace','48 Anniversary Hill','3 Lakewood Terrace','246 Packers Road','08 Jay Circle','8324 Reinke Circle','584 Union Lane','2046 Mcbride Avenue','4301 Bayside Hill','126 Oak Junction','7287 Waxwing Parkway','8381 Norway Maple Pass','70087 Ilene Street','7 Troy Terrace','2466 Warrior Way','99119 Beilfuss Place','1 Melody Pass','846 Reindahl Drive','9 Wayridge Drive','71495 Hallows Crossing','40380 1st Road','1 Sloan Hill','285 Brentwood Trail','8650 4th Crossing','8 Maywood Park','6 Buhler Pass','39289 Thackeray Center','51 Surrey Place','91 Merchant Trail','21760 Dorton Parkway','678 Dottie Terrace','9414 Buhler Plaza','08718 Myrtle Plaza','4674 Londonderry Court','406 Brickson Park Circle','01 Almo Terrace','3 Randy Pass','5974 Ronald Regan Pass','179 Cottonwood Junction','760 Tennessee Park','22 Forster Park','9527 Summer Ridge Place','12 Arkansas Way','281 Kennedy Road','54 Autumn Leaf Way','637 5th Lane','3912 Muir Court','839 Crowley Place','328 Meadow Valley Terrace','7729 Oneill Road','6 Pennsylvania Place','6971 Annamark Street','40633 Kim Street','94 Stephen Hill','8 Main Pass','51 Vera Terrace','8 Graedel Trail','84 Armistice Trail','7838 Eastlawn Terrace','7 Chinook Avenue','4627 Luster Center','5 Prairieview Center','798 Sullivan Avenue','6 Hollow Ridge Trail','3 Corry Place','1 Sullivan Court','0757 Ilene Park','93 Ridgeway Center','6808 Ridgeview Trail','27697 Paget Way','2 Toban Parkway','6438 Merchant Trail','0 Loftsgordon Crossing','39 Jenifer Drive','97 Sachs Junction','0914 Barnett Point','953 Maple Point','2347 Prairie Rose Park','0 Manitowish Crossing','2 Veith Point','2 Surrey Lane','581 Hanover Place','32 Lukken Trail','075 Merchant Terrace','9 Lien Court','669 Bowman Lane','4016 Oak Valley Park','7 Marcy Drive','43 Boyd Crossing','38649 Merrick Lane','7713 Maryland Terrace','58 Oakridge Crossing','616 Stang Junction','93187 Susan Hill','8799 South Lane','4 Bluejay Circle','2 Del Sol Terrace','6 Butterfield Way','95003 Tennyson Parkway','954 Springview Plaza','86814 Grayhawk Circle','2365 Dunning Point','98223 Crescent Oaks Street','90314 Monument Terrace','24 Ludington Plaza','6 Hoepker Point','875 Russell Park','24 Grover Place','094 Delaware Trail','58 Nobel Plaza','23 Northland Pass','405 Ramsey Drive','06 Hanson Pass','6 Loftsgordon Plaza','5 Talisman Park','157 Lakewood Gardens Street','29951 Steensland Parkway','12864 Butternut Parkway','95881 Mendota Trail','6438 Elka Park','77699 Manitowish Pass','2 Westend Point','64436 Little Fleur Pass','6 Katie Park','43154 Parkside Parkway','415 Dottie Street','0 Welch Avenue','82 Nova Hill','6861 Moland Avenue','0 Arizona Plaza','2075 Paget Trail','4270 Warrior Junction','04 Chinook Alley','077 Badeau Center','523 Onsgard Parkway','233 Brown Trail','345 Ridgeway Hill','5388 Center Hill','89 Oak Parkway','66 Rutledge Street','162 High Crossing Park','7703 Buena Vista Way','73782 Monica Junction','86 Twin Pines Court','7497 Carberry Park','00889 Susan Trail','313 Lyons Plaza','6 Rutledge Lane','72 Westridge Junction','02743 Almo Place','95726 Banding Junction','1 Stoughton Drive','09187 Di Loreto Road','465 Boyd Lane','8213 Crowley Drive','5061 Ridgeway Court','27012 Mallory Center','1893 Dryden Park','1 Annamark Court','7 Forster Terrace','449 Karstens Lane','741 Dwight Parkway','12483 Dottie Point','6814 Jay Parkway','68087 Leroy Crossing','6 Mandrake Place','23 Dwight Place','8 Paget Plaza','301 Reindahl Lane','90298 Colorado Court','4198 Swallow Drive','0968 Claremont Alley','25 Stoughton Alley','6219 Claremont Hill','340 Union Trail','6224 Pond Crossing','454 Delladonna Trail','25081 Nancy Court','325 Duke Crossing','2 Sutherland Circle','65961 Rieder Point','4355 Dakota Lane','27324 Clarendon Terrace','8376 Kedzie Junction','03377 Meadow Vale Crossing','9970 Hintze Point','4 Hudson Avenue','9908 Forest Run Plaza','59 Grasskamp Hill','68 Stuart Park','6327 Birchwood Park','1 Johnson Street','43943 Clarendon Point','11584 Victoria Plaza','9 Mallory Crossing','3817 Utah Park','1 Dorton Street','1802 Crowley Way','307 Jenna Alley','4 Independence Street','599 Roth Point','83 Mcguire Junction','8 Bonner Road','723 Logan Junction','150 Mayer Place','85536 Barnett Pass','32652 Kipling Circle','11077 Shelley Lane','472 Victoria Park','82 Moose Trail','4 Holy Cross Parkway','0 Dixon Junction','512 Garrison Junction','76249 Washington Road','364 Buena Vista Hill','25725 Texas Court','7 Bashford Trail','04910 Dryden Circle','06643 Kim Junction','25 Monterey Pass','24750 Mosinee Street','9852 Chinook Pass','38 Nelson Terrace','78217 Northland Plaza','16720 Claremont Crossing','449 Scofield Pass','5435 Grayhawk Drive','79 Vera Center','555 Mosinee Way','478 Carey Hill','5 Monterey Drive','2 Merrick Hill','0774 Maple Wood Lane','9097 Almo Junction','2 Main Drive','223 Beilfuss Court','951 East Drive','9 Bunting Point','7508 Nevada Terrace','4 Bluejay Street','69566 Anzinger Lane','92470 West Place','21 Bunker Hill Circle','06612 Holmberg Hill','1 Kingsford Pass','3423 Magdeline Way','3507 Oak Valley Court','22963 Hoffman Plaza','46 Veith Road','791 Manley Plaza','0 Ohio Pass','0 Walton Alley','41 Mosinee Road','9284 Grayhawk Lane','7345 Chinook Avenue','62420 Reindahl Pass','91 Lawn Trail','6284 Holmberg Drive','67 Macpherson Place','818 Scott Terrace','2 Hovde Circle','52861 American Ash Street','5 Vahlen Alley','9 Mosinee Center','1888 Crest Line Street','4 Northland Street','514 Oxford Crossing','12338 Sherman Street','78820 Schiller Drive','9797 Arapahoe Circle','22787 Commercial Place','53 Menomonie Way','12914 Brentwood Trail','82 Lake View Street','27 Caliangt Drive','9460 Kipling Alley','75093 Pennsylvania Junction','67933 Victoria Circle','8 Gateway Hill','1 Spohn Terrace','72965 Spohn Drive','2739 Crest Line Street','6874 Aberg Center','4614 Algoma Junction','003 Johnson Park','428 Harper Point','2 Gina Trail','2 Myrtle Drive','68748 Bayside Avenue','6739 6th Junction','36 Browning Road','55455 Lillian Hill','258 Elgar Pass','3440 Gateway Road','6121 Forster Lane','345 Evergreen Trail','530 Hollow Ridge Trail','0948 Donald Center','36 Village Avenue','86 Crowley Hill','32 Grasskamp Park','30 Pine View Crossing','3 Prairie Rose Court','38370 Dryden Trail','7 Graceland Circle','103 Vahlen Point','47 Mallory Circle','6 Reinke Road','41763 Toban Alley','80 Boyd Alley','92 Kensington Street','5346 Esch Terrace','7633 Dennis Street','7798 Hagan Point','04 4th Hill','42 Red Cloud Alley','34 8th Parkway','021 Crest Line Pass','0 Express Place','9 Morrow Junction',
    '57 Havey Junction','15612 Schiller Pass','9 Autumn Leaf Center','9 Fuller Parkway','1 Cordelia Pass','49895 3rd Way','79 Norway Maple Circle','6307 Steensland Plaza','82790 Butternut Way','77 Basil Crossing','69523 Hudson Court','9126 Red Cloud Center','71200 Havey Alley','1872 Cherokee Pass','286 Kennedy Place','67750 Buell Road','6520 Manley Road','4187 2nd Hill','3705 Forest Run Plaza','0277 3rd Pass','54 Maywood Plaza','3 Amoth Place','8729 Vahlen Place','58 Gale Trail','901 Hayes Terrace','0051 Esch Crossing','77 Bonner Avenue','10 Talmadge Center','08 Pine View Terrace','33887 Hintze Street','95050 Clove Pass','3 Sauthoff Road','3 Eliot Drive','6517 Chive Street','564 Grover Terrace','4587 Fremont Parkway','9964 Crescent Oaks Avenue','2 Eagan Hill','6 Pearson Hill','76 Chive Parkway','5090 Basil Road','728 Lunder Drive','561 Mcguire Lane','2 Bowman Drive','5 Kings Circle','735 Warbler Center','011 Ramsey Alley','393 Pawling Trail','55898 Sugar Hill','43013 Pankratz Crossing','25942 Beilfuss Pass','044 Rusk Street','12 Lillian Crossing','09 Sundown Circle','522 Ilene Pass','656 Blackbird Crossing','4 Melody Center','515 Bellgrove Avenue','959 Manitowish Road','4857 Westend Crossing','8 Lotheville Place','162 Summit Drive','447 Red Cloud Trail','698 Harbort Pass','87 Arkansas Park','0 Anniversary Crossing','33581 Golf Plaza','53 Grayhawk Center','855 Mcguire Parkway','33 Becker Hill','39847 Carberry Center','151 Morrow Pass','5394 Meadow Ridge Terrace','3774 Farmco Center','945 Kensington Pass','63 Memorial Junction','86675 Mitchell Plaza','7594 Village Point','5 Texas Street','0101 Shoshone Parkway','239 Mifflin Plaza','0842 Iowa Lane','4959 Twin Pines Alley','19 Mcguire Hill','48 Dryden Circle','089 Straubel Terrace','32285 Bluestem Parkway','257 Porter Road','72 Dennis Circle','0 Elmside Court','6325 Hoard Avenue','0 Bartillon Crossing','295 Stoughton Center','67334 Pond Circle','1648 Columbus Way','03 Manley Avenue','020 Parkside Hill','517 Mitchell Alley','600 Blaine Hill','7 Crownhardt Avenue','83456 Gina Parkway','8 Talmadge Place','1 Lakewood Gardens Crossing','39914 Oak Terrace','98064 Macpherson Avenue','1817 Macpherson Way','74099 Heffernan Junction','7 Duke Avenue','6429 Bowman Park','488 Forest Run Way','03 Meadow Ridge Junction','88724 Garrison Court','054 Larry Point','98337 Hoepker Lane','86 Annamark Crossing','23 Roxbury Center','6418 Debra Street','56 Grasskamp Park','4 Buell Alley','982 Holy Cross Parkway','77937 Debra Place','31334 Maple Wood Hill','6 Farragut Plaza','46 Sherman Terrace','03106 Susan Junction','9158 Valley Edge Trail','38 Sherman Road','5306 Arkansas Pass','547 Bowman Point','78 Green Ridge Hill','5 Elka Lane','54708 Ridgeway Avenue','12 Doe Crossing Plaza','60 Fallview Street','420 Hudson Way','9 Mallard Circle','3279 Algoma Center','78804 Cordelia Drive','16481 Forster Terrace','75564 Pleasure Terrace','5 Aberg Circle','591 Sommers Hill','15997 Village Green Street','0 Green Circle','05 Clarendon Trail','60365 Beilfuss Place','48 Dapin Parkway','614 Lighthouse Bay Crossing','99096 Sage Court','9 Buhler Park','7 Corry Crossing','831 Sundown Crossing','613 La Follette Center','60 Pond Drive','35 Dovetail Drive','38 Portage Parkway','55727 Sachs Place','07875 Orin Street','0996 Transport Pass','2 Continental Crossing','991 Nancy Junction','49 Russell Hill','34380 Eliot Court','8 Calypso Point','49 Lien Terrace','17532 Troy Court','1 Atwood Junction','77 Stuart Road','91 Stang Street','5 Delaware Place','32631 Namekagon Court','586 Springview Center','5867 Hansons Parkway','051 Fairview Circle','22 Manley Road','77264 Muir Junction','93 Melby Street','16 Derek Center','97 Melrose Hill','6 Anderson Parkway','35 Maywood Place','0 Maryland Pass','9 Bayside Pass','27 Vernon Park','0165 Cascade Trail','204 Rockefeller Place','12 Larry Point','29 Maryland Parkway','3 Nevada Road','9848 Graedel Avenue','64 Farwell Park','733 Raven Circle','265 Grasskamp Lane','556 Bashford Crossing','4 Dapin Hill','2 Vernon Park','6060 Clyde Gallagher Center','947 Onsgard Drive','811 Mayfield Point','6348 Redwing Road','32474 Glendale Junction','672 Park Meadow Alley','8 Banding Crossing','3170 Grover Place','006 Westerfield Avenue','7247 Kedzie Place','269 Hoard Avenue','44 Becker Park','72566 Morrow Place','64091 Beilfuss Hill','0526 Schlimgen Park','600 Utah Avenue','4 Glendale Hill','41099 Melvin Point','643 Saint Paul Court','230 Norway Maple Plaza','996 Comanche Crossing','3 Bultman Avenue','3 Vahlen Park','8791 Dwight Crossing','81 Dryden Point','0 8th Place','63 Farmco Parkway','60 La Follette Place','556 Dapin Road','911 Fuller Court','90270 Bartillon Point','984 Bonner Court','28523 Independence Road','032 Northridge Alley','6661 Merchant Center','0179 Raven Trail','92 Clemons Park','1053 Independence Avenue','776 Eggendart Point','8 Hintze Road','71037 Waywood Place','648 Ludington Avenue','310 Esker Park','3133 Pine View Road','581 Waxwing Street','19871 Dwight Park','39563 Little Fleur Point','15658 Acker Street','198 Hoffman Trail','5721 Lindbergh Circle','38098 Tomscot Trail','380 Crescent Oaks Alley','9443 Hintze Place','88 Basil Way','52623 Summit Parkway','1398 Russell Park','4073 Brentwood Road','90 Nevada Way','913 Thackeray Circle','4 Upham Pass','9583 Linden Center','08 Esker Place','001 Daystar Lane','0691 Menomonie Junction','5 Trailsway Center','54877 Pawling Street','25 Quincy Road','5 Ryan Trail','8 Bashford Drive','9 Buell Parkway','4655 Packers Way','8 Merchant Lane','03 Victoria Trail','5 Melvin Hill','15903 Quincy Pass','0 Crownhardt Point','9141 Melrose Hill','2973 Mallory Court','16 Nevada Alley','3 Golf Course Park','6598 Mccormick Crossing','7 Claremont Lane','55 Ruskin Way','7138 Mallard Center','20032 Oak Valley Street','25372 Straubel Junction','05 Waxwing Hill','7 Vahlen Junction','649 4th Hill','644 Jana Circle','051 Arkansas Parkway','213 Manley Center','65 Morrow Pass','993 Columbus Street','4 Columbus Place','40002 Cascade Street','05082 Mayfield Alley','83 Roxbury Park','4 Butterfield Parkway','637 Corscot Park','68 Kingsford Trail','81429 Becker Terrace','75 Jenna Trail','34462 Grim Hill','4729 Grasskamp Center','71858 Derek Alley','7097 Westerfield Road','2913 Donald Alley','1642 Magdeline Way','5474 Lakewood Gardens Plaza','36987 Park Meadow Court','9829 Lighthouse Bay Trail','879 Mccormick Parkway');
lista_dob varr := varr('10/11/1970','2/23/1962','3/14/1980','9/30/1958','12/24/2003','4/13/2012','2/24/2011','5/23/2016','4/28/2015','7/3/1973','1/2/1948','10/7/2006','9/10/1971','12/10/1969','5/22/2009','4/25/1957','1/31/2019','1/12/2006','6/1/1965','3/3/1988','8/2/1975','7/11/2005','3/30/1985','3/12/1989','7/18/1985','8/16/1963','4/17/1946','6/25/1966','11/4/2006','10/3/2018','11/28/1950','9/7/1961','12/20/1961','7/26/1959','2/12/1980','4/7/1963','2/6/1984','5/24/2005','9/7/2009','9/24/1950','1/30/1962','7/18/2008','12/27/1976','2/27/1965','6/24/1985','9/14/1971','7/29/1953','5/3/1978','10/16/2017','9/14/1997','12/13/2008','9/7/1985','6/19/1976','7/11/1985','3/1/1965','3/12/2006','7/13/1992','4/30/1995','10/4/1970','9/14/1948','3/25/1976','6/14/1962','10/6/2006','5/7/1965','8/11/2001','11/3/2004','1/5/1987','12/15/1962','8/31/2004','9/24/1967','3/9/1996','7/27/1948','10/17/1991','1/13/1986','4/12/1992','4/12/1983','12/12/1950','10/2/1972','5/29/2015','12/25/1978','9/15/1987','8/15/2005','1/1/1971','6/23/1948','7/13/1955','11/16/2010','4/1/2014','6/17/1957','1/2/2005','9/30/1981','5/31/2016','1/16/1947','4/18/1953','6/24/1990','3/25/1982','7/28/1960','8/4/2002','3/10/1987','12/3/2010','2/26/1982','9/26/1970','7/19/1982','5/30/1981','3/1/1947','9/10/1983','3/29/2013','6/1/1994','6/3/1983','7/17/2008','5/2/2007','2/1/1976','10/5/1992','11/13/1976','6/3/2000','3/10/1957','5/2/1974','8/28/1950','1/8/2016','9/10/1986','3/24/1963','2/22/1997','8/21/1978','2/12/1956','6/27/2002','1/8/1962','11/14/1951','12/1/2001','12/22/1964','6/5/1960','9/26/1954','11/15/2015','3/8/1962','7/28/1963','12/14/1998','11/24/2001','2/24/1978','1/29/1969','5/15/2006','1/12/2018','4/2/1992','7/10/1998','4/25/1965','8/18/1973','6/20/2005','3/23/1998','5/9/2016','4/21/1998','7/22/1964','5/7/2001','8/25/2011','7/14/1996','3/16/1982','8/6/1985','8/20/2002','4/8/1980','2/13/1961','5/16/1985','9/6/2009','9/5/1988','2/13/2012','5/5/1977','6/28/2010','7/5/1960','12/21/1976','1/6/2009','7/24/2018','9/12/1994','5/25/2008','7/25/2018','6/1/1961','8/3/1989','3/23/1957','2/1/1998','3/7/2013','10/19/2004','1/19/1972','5/16/2014','6/20/1981','6/26/1975','7/22/1973','3/7/1991','10/15/2005','8/17/2018','7/16/1996','2/23/1987','3/20/1980','1/4/1946','9/26/1994','4/14/2008','6/8/1997','9/4/1963','6/20/1977','3/14/1949','6/26/1978','7/5/1960','4/23/1988','8/19/2008','5/29/1987','12/13/2012','5/31/1997','10/4/1964','10/30/1974','3/9/1966','3/4/1950','8/7/1957','10/28/1979','3/17/2000','12/22/1997','6/12/1972','12/31/2018','8/7/2017','5/8/1957','7/21/1972','4/9/1974','8/17/1994','8/31/1945','11/10/2014','8/20/2014','3/17/1976','10/4/1965','2/6/1951','7/10/2011','8/27/2010','11/27/1950','1/17/1995','7/2/1993','9/10/2001','10/28/1955','5/27/1948','4/2/2002','7/8/1962','7/15/1956','4/21/1964','10/8/1973','9/19/1985','7/20/2015','4/15/2012','6/11/1958','5/31/1975','5/28/1978','7/11/1953','7/29/2004','10/3/1969','8/11/1968','7/13/1982','4/15/2011','6/20/2011','8/23/2001','8/31/1971','8/7/1954','10/11/1973','12/30/2014','2/25/1966','9/16/1963','6/3/2018','1/21/2002','7/3/2007','5/12/2016','12/1/1991','1/15/1965','11/30/1975','1/10/1957','2/10/2006','1/18/1964','5/15/1969','9/29/1989','11/12/1977','8/11/2000','4/14/1984','12/13/1947','5/21/2012','2/6/1982','3/6/1995','5/16/1954','7/15/1966','11/21/2003','8/29/1986','6/29/1994','3/5/1977','11/22/1993','6/24/2009','5/12/1956','12/5/1967','5/16/1967','4/2/1983','6/4/1948','12/28/2015','12/2/1952','3/20/1956','8/14/2013','9/12/1987','8/24/1958','5/26/1990','6/9/2014','8/13/1974','5/23/1946','4/10/1959','7/20/2018','1/7/1956','4/5/2009','3/8/1999','9/7/1957','9/27/1972','12/17/1947','3/20/1973','7/15/1951','12/13/1973','1/9/1960','2/16/1962','7/8/2004','1/5/2010','3/17/2002','9/9/1948','4/4/1960','4/28/1970','9/17/2007','9/27/1984','9/1/1949','5/15/2018','10/30/2018','8/4/1976','1/21/1979','8/4/1957','5/25/2000','4/1/1994','12/21/1974','9/2/1971','11/10/1996','4/10/1989','1/9/1961','2/14/1962','12/6/2003','4/8/2017','1/12/1983','9/11/1994','12/14/1969','7/17/2003','12/17/1945','1/15/1980','12/15/2018','12/22/1979','2/27/1977','2/19/2017','7/8/1988','1/14/1947','6/30/2008','2/18/1959','10/27/2000','1/13/2012','2/7/1962','2/28/2002','6/11/2000','3/7/1974','10/24/1997','1/24/1991','4/29/1996','11/27/1973','12/30/1957','2/25/1949','11/2/1983','7/25/1998','11/15/1970','3/13/1958','11/9/2015','5/19/1962','11/2/1994','3/4/1981','1/20/1988','4/18/1979','7/26/1984','1/1/1977','1/27/2010','9/15/1967','11/10/1999','4/9/1961','3/30/1973','10/6/2016','7/18/2012','8/9/2016','3/6/1986','3/8/1948','11/22/1962','7/19/2007','9/16/1980','2/18/2017','12/7/1995','1/17/1980','3/2/1947','2/8/2009','12/23/1946','7/28/1970','4/27/2008','11/30/1975','2/7/1954','1/9/1968','7/15/2017','10/20/1971','12/4/2011','3/15/1968','6/19/2012','9/13/1966','5/28/1992','3/1/1951','11/26/1969','11/11/2009','10/29/1954','2/3/1985','10/12/2012','8/29/1956','3/1/1975','7/25/1952','6/18/1968','7/26/1977','2/6/2009','9/17/1971','9/28/1991','1/19/2019','4/29/1956','7/13/1968','3/10/2008','6/26/1995','5/30/1956','6/21/2015','12/12/1955','10/5/1978','2/18/1967','12/16/1957','1/29/2008','1/22/1975','11/5/2001','10/15/1948','1/8/1958','11/23/2010','9/18/2006','8/4/1947','7/28/1967','5/30/1989','5/1/1987','3/15/1958','10/28/1952','2/12/1976','8/15/1958','12/28/1947','8/24/1986','4/18/1975','12/12/1981','6/30/2008','6/20/1968','6/24/2000','12/31/2016','8/2/1998','6/7/1980','1/17/1973','11/24/1995','7/21/1975','7/15/2014','1/12/1979','10/22/1948','10/12/1975','8/8/2004','1/22/1979','11/27/1953','4/1/1981','3/20/1960','2/6/1979','8/11/1961','6/6/1978','4/3/1969','4/3/1969','8/10/1963','4/20/2005','2/16/2012','4/29/1988','8/24/2004','8/28/2006','11/21/2000','12/13/1955','4/29/1977','11/9/1974','11/13/1948','1/23/1998','1/4/1956','8/28/1964','7/18/1982','11/26/1966','4/22/2008','8/11/1973','7/20/1966','2/22/2004','11/25/1968','4/26/1948','10/26/1953','7/18/1963','7/16/1989','8/15/1967','5/10/2001','5/28/1953','11/10/1945','6/10/1945','1/30/2008','4/5/1949','9/30/1958','3/14/1954','10/2/1973','5/28/1986','3/8/2012','9/23/1979','5/1/1960','12/10/1956','6/25/2017','8/7/1979','8/25/1983','9/1/1972','12/13/1978','5/10/1954','12/13/2000','12/20/1960','12/8/1981','5/6/1988','3/18/2001','10/4/1965','7/30/2013','5/23/1951','9/16/1972','2/25/1953','10/25/1985','4/11/2003','9/15/1964','11/22/1977','1/10/1986','11/5/1961','1/13/1951','11/3/1949','10/25/1975','10/13/1979','6/10/1992','6/18/1953','9/17/2015','1/15/2017','8/17/1984','9/26/1966','10/7/2018','10/13/1969','10/26/1993','6/23/1947','11/2/1950','11/19/1964','1/10/2015','12/5/1949','11/27/1969','5/15/1996','12/3/1976','10/16/2012','1/18/1975','6/12/1966','3/1/1986','4/13/2006','7/15/1956','10/7/1978','3/9/1966','3/13/1972','7/26/1962','4/2/1945','6/12/1973','7/9/1964','4/10/2017','1/6/1951','11/13/1991','5/2/1994','10/25/1975','11/28/1961','4/6/2012','6/3/2003','6/18/1965','8/30/1949','6/16/1989','11/15/1986','8/7/1951','4/26/2014','1/10/1960','1/26/1962','11/28/1965','11/3/1993','6/4/1981','9/5/1984','11/8/1948','9/19/1991','2/21/2000','11/22/1947','2/23/2019','9/16/2002','3/17/1960','6/30/1952','10/24/2003','11/25/1967','2/25/2017','2/17/1988','3/8/1995','6/24/1980','7/25/1990','2/24/2003','5/2/1996','9/17/1950','3/27/2015','10/30/1986','5/5/1957','12/13/1966','10/16/1998','2/9/1954','8/21/2011','12/19/1975','11/13/1967','3/23/1972','11/27/2009','11/29/1998','1/7/2009','4/30/1975','11/22/1994','8/7/1987','7/30/1976','5/10/1987','4/10/2010','4/26/1948','10/18/1997','12/17/2002','7/13/1969','10/20/1978','12/4/1975','11/17/1992','7/23/1984','5/16/1959','10/13/1996','4/12/2002','1/7/1963','11/2/1954','11/25/1952','9/15/1991','10/13/1947','7/22/1967','3/6/1954','10/1/1971','2/25/1971','1/30/1973','10/29/1997','11/1/1998','5/30/1987','6/28/2006','9/13/1985','10/2/2008','1/8/1989','8/3/1983','1/22/2018','1/12/2014','12/10/2012','11/25/1994','4/8/1977','3/3/1972','10/21/1955','5/24/2013','10/30/1991','11/30/1979','9/2/2001','3/2/2011','9/5/1964','12/19/2006','1/11/1982','10/18/2003','6/1/1958','10/24/2001','3/19/1978','7/10/2010','2/2/1983','5/7/1963','8/15/2005','10/20/1966','3/20/1973','6/19/1971','3/24/2004','7/1/1997','11/25/1996','2/8/1986','1/1/1974','4/24/1978','9/21/1962','1/24/1948','4/21/1993','12/24/1956','10/18/1992','1/11/2014','11/8/1960','10/3/2001','3/5/2006','12/14/1969','4/18/1948','1/16/2015','11/12/1957','4/18/1951','4/20/2016','7/14/1979','2/19/2007','2/22/1978','2/11/1945','10/27/1967','8/9/1977','7/14/2015','11/8/1988','2/10/1958','2/13/2018','6/24/1975','11/23/1974','11/23/1967','9/22/1969','1/16/2012','10/24/1972','5/16/2006','1/13/2007','3/21/2014','4/23/1958','10/30/1967','3/16/1963','4/11/1966','9/22/1978','2/15/2011','12/4/1988','7/4/2005','8/30/2007','6/30/1964','7/26/1994','6/18/2007','3/19/2013','3/24/2003','12/24/1957','6/26/1974','3/29/2009','3/22/1992','11/17/1959','6/25/1991','9/9/1995','1/3/1988','6/1/1957','12/2/2007','5/15/1966','10/30/1998','8/6/1964','10/5/1990','2/15/1973','9/5/2000','9/21/1961','11/26/1991','3/15/2002','8/11/1982','10/28/1949','9/10/1952','9/16/1956','7/15/2017','11/1/1978','1/23/1985','2/24/1985','9/4/2015','10/22/2008','1/21/1991','6/18/1989','11/12/2001','9/20/2015','12/12/2015','8/16/1987','4/16/2010','5/22/1946','2/12/1991','1/15/1965','10/24/1953','10/15/1974','11/11/2011','12/19/2016','2/12/1995','8/3/1987','10/8/2013','11/6/1955','2/16/1972','8/20/1995','1/16/1999','2/21/1966','5/16/1984','8/11/1984','7/3/1977','7/25/1988','1/3/2015','6/23/2018','6/24/2005','8/28/2016','2/11/2008','12/13/1960','4/21/1980','7/14/1968','12/7/2003','8/30/1981','10/9/1951','4/29/1977','5/15/2011','5/19/1955','3/10/1950','9/9/1992','4/10/2012','12/10/1950','4/27/1985','11/5/1967','8/29/1978','11/27/1954','1/19/1990','1/29/2003','1/17/2001','2/26/1991','6/4/1964','10/24/1948','2/4/1951','5/27/1951','12/28/1967','1/2/1993','7/6/1987','7/1/1996','2/23/1975','3/30/1999','2/3/1994','4/5/1958','3/3/2004','8/21/2015','3/16/1950','1/14/1992','3/11/1971','3/16/1976','9/1/1969','9/22/1955','5/6/2010','4/18/1966','1/22/1998','12/16/2008','7/23/1991','9/18/1989','3/3/2016','12/15/1972','3/2/2013','6/29/1998','9/16/1961','12/30/1984','9/22/2016','5/3/1965','11/6/1996','8/24/1982','11/27/1957','8/6/1974','7/19/1978','8/20/1988','12/7/1958','8/22/1946','8/18/2001','2/28/2008','8/19/1983','2/18/1991','3/9/2011','8/6/1971','2/26/2014','8/12/2015','10/12/1974','11/3/2018','6/23/1970','10/31/1988','9/13/1964','11/23/1951','7/18/1956','8/31/1950','6/5/1992','1/30/1987','8/3/1985','9/1/1950','6/23/2008','10/11/1972','10/20/1983','5/3/1969','2/24/2003','6/26/1995','11/14/1990','12/25/1975','10/8/1947','2/21/2000','12/10/1981','11/26/1967','8/2/1946','6/22/2014','4/12/1951','6/1/1945','1/1/1955','8/4/1991','8/12/1957','10/25/1959','1/3/1957','10/11/1987','6/3/2007','1/1/1949','9/8/1977','5/2/1999','4/30/1995','8/28/1997','12/19/1960','2/2/1956','3/3/2004','9/4/1987','1/1/1984','3/9/1996','8/26/1993','1/28/1959','7/16/1963','6/4/1990','7/11/2013','8/11/1974','7/8/1977','6/3/1990','2/23/1959','7/19/2018','11/7/1992','8/10/1963','11/16/1945','5/6/2008','2/7/1982','5/22/1966','12/31/1988','9/26/1975','11/19/1959','8/1/2002','2/23/1988','7/6/1993','5/26/2013','10/7/1960','12/13/1948','3/12/1945','11/18/1981','2/19/1960','9/12/1978','9/2/1968','5/21/1965','11/14/1951','2/27/2002','1/20/2017','11/2/2004','2/16/1994','5/21/1999','7/13/2010','5/22/1947','8/15/1968','3/17/1963','6/6/1951','10/2/1996','8/2/2003','7/26/2003','5/26/2007','6/1/1956','8/6/1960','10/5/2003','7/6/1951','4/25/2014','6/3/1994','9/15/1969','1/21/2016','3/5/1994','8/28/1977','2/16/2010','4/17/1973','3/16/2006','5/14/1989','11/2/2018','10/15/1990','5/31/1971','6/14/1964','10/27/1991','3/21/2006','5/8/1999','5/31/1995','3/24/1972','9/27/2008','4/10/1960','3/15/1993','4/4/1973','5/4/1967','7/14/2003','7/29/1948','2/15/2009','5/1/1946','1/24/1955','6/15/1962','12/26/1946','5/12/1972','10/8/1969','1/14/1963','3/23/2016','5/10/1967','6/4/1964','10/25/1990','4/2/1980','10/6/2016','6/30/1977','1/16/1978');


v_nume PERSONS.first_name%type;
v_prenume PERSONS.last_name%type;
v_adresa PERSONS.address%type;
v_dob PERSONS.date_of_birth%type;
v_tel PERSONS.phone_number%type;


BEGIN

   DBMS_OUTPUT.PUT_LINE('Inserarea a 80000 persoane...');
  FOR v_i IN 1..80000 LOOP

      v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
      v_prenume := lista_prenume(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume.count))+1);
      v_adresa := lista_adrese(TRUNC(DBMS_RANDOM.VALUE(0,lista_adrese.count))+1);
      v_dob:= to_date(lista_dob(TRUNC(DBMS_RANDOM.VALUE(0,lista_dob.count))+1),'mm/dd/yyyy');
      v_tel := FLOOR(DBMS_RANDOM.VALUE(100,999)) || '-' || FLOOR(DBMS_RANDOM.VALUE(100,999)) || '-' || FLOOR(DBMS_RANDOM.VALUE(1000,9999));

      insert into PERSONS(first_name,last_name,address,date_of_birth,phone_number)  values(v_prenume, v_nume, v_adresa,v_dob, v_tel);
  END LOOP;
   DBMS_OUTPUT.PUT_LINE('Inserarea a 80000 persoane... GATA !');


  insert into TICKETS(ticket_type,ticket_price) values ('normal', 10);
  insert into TICKETS(ticket_type,ticket_price) values ('child', 3);
  insert into TICKETS(ticket_type,ticket_price) values ('student', 5);
  insert into TICKETS(ticket_type,ticket_price) values ('pensionary', 5);

  insert into PERSONS(first_name,last_name,address,date_of_birth,phone_number) values ('Georgiana','Andries','21 Rozelor',to_date('03/22/1998','mm/dd/yyyy'),'0749800634');
  insert into PERSONS(first_name,last_name,address,date_of_birth,phone_number) values ('Amalia','Damoc','256 Strugurilor',to_date('06/30/1998','mm/dd/yyyy'),'0778695233');



  insert into ZOO_ZONES(zone_name, zone_surface, zone_location, visiting_start_h, visiting_close_h) values ('Frozen-Zone','300mp','North','12:00','20:00');
  insert into ZOO_ZONES(zone_name, zone_surface, zone_location, visiting_start_h, visiting_close_h) values ('Tropical-Zone','250mp','South-East','11:00','16:00');
  insert into ZOO_ZONES(zone_name, zone_surface, zone_location, visiting_start_h, visiting_close_h) values ('Bird-Paradise','200mp','East', '10:00','16:00');
  insert into ZOO_ZONES(zone_name, zone_surface, zone_location, visiting_start_h, visiting_close_h) values ('Aquatic-Zone','300mp','Center','12:00','20:00');
  insert into ZOO_ZONES(zone_name, zone_surface, zone_location, visiting_start_h, visiting_close_h) values ('Earth-Zone','500mp','West','10:00','18:00');
  insert into ZOO_ZONES(zone_name, zone_surface, zone_location, visiting_start_h, visiting_close_h) values ('Dessert-Zone','200mp','South','12:00','18:00');

END;
 /

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------INSERARE ANGAJATI----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE

   TYPE varr IS VARRAY(1000) OF varchar2(255);
  hire_dates  varr := varr ('4/28/2018','5/22/2017','1/15/2018','11/19/2014','12/15/2016','4/8/2018','1/25/2016','6/27/2018','7/2/2016','1/17/2017','3/24/2016','5/10/2016','3/12/2014','9/17/2017','6/1/2015','9/16/2018','11/26/2014','7/24/2014','11/9/2015','1/6/2016','1/12/2016','1/29/2017','9/13/2017','10/23/2016','2/27/2019','10/9/2017','10/17/2018','8/19/2017','7/15/2017','7/31/2017','10/9/2015','11/13/2018','6/13/2018','9/30/2014','1/25/2016','3/18/2014','10/30/2016','7/31/2018','11/23/2015','10/26/2016','10/13/2015','5/20/2014','12/6/2018','6/21/2016','12/9/2015','2/4/2017','1/24/2016','5/18/2017','1/11/2014','12/18/2015','11/21/2015','2/19/2016','10/20/2014','12/21/2016','8/11/2015','3/14/2019','7/31/2014','7/29/2014','10/30/2016','8/7/2015','12/31/2018','5/11/2018','8/31/2017','1/12/2014','1/20/2018','4/8/2018','5/19/2018','2/15/2017','3/22/2017','1/10/2018','12/19/2016','8/12/2016','2/9/2018','3/18/2019','2/26/2019','12/10/2014','7/8/2015','7/19/2018','12/17/2018','2/28/2016','3/10/2015','11/24/2017','12/5/2014','12/18/2017','7/14/2014','6/15/2016','4/25/2017','1/4/2015','12/16/2015','12/28/2014','4/29/2016','9/26/2018','3/24/2018','4/30/2018','8/20/2014','4/21/2017','2/14/2014','4/1/2018','1/7/2015','12/1/2014','12/6/2016','3/11/2019','12/5/2015','7/30/2018','4/10/2016','7/6/2014','3/22/2019','3/30/2017','8/24/2018','10/21/2014','12/22/2016','7/19/2018','3/1/2014','7/31/2015','10/2/2014','12/13/2018','7/13/2018','5/28/2017','12/29/2016','10/30/2014','7/19/2014','2/24/2019','7/21/2018','8/29/2017','10/31/2015','3/26/2014','12/18/2018','10/18/2018','10/15/2018','8/4/2016','10/10/2015','10/15/2014','4/8/2018','9/30/2016','1/3/2019','12/22/2014','4/30/2015','3/3/2014','2/22/2016','6/4/2016','4/17/2016','8/27/2014','7/13/2017','4/16/2014','6/1/2015','7/9/2018','6/28/2017','12/24/2014','4/13/2016','10/9/2014','7/19/2017','3/20/2017','9/19/2017','7/27/2018','11/1/2014','3/16/2019','7/17/2018','11/19/2018','2/23/2019','3/27/2016','9/13/2017','3/9/2016','3/4/2016','4/8/2018','7/30/2017','2/14/2019','2/11/2019','6/15/2018','2/20/2015','2/16/2019','10/6/2015','7/19/2014','3/30/2016','10/11/2014','2/17/2019','4/25/2015','11/9/2018','6/10/2017','6/4/2015','4/15/2016','8/28/2017','4/22/2016','1/13/2018','11/16/2018','2/23/2017','4/11/2017','4/23/2016','3/30/2017','8/14/2018','9/8/2014','6/23/2017','1/28/2015','10/2/2016','10/17/2017','12/12/2018','5/6/2015','9/17/2017','3/7/2016','6/20/2015','6/30/2014','5/19/2017','4/25/2014','3/31/2016','11/22/2015','11/19/2018','2/21/2018','12/4/2018','2/10/2016','7/20/2014','3/13/2014','7/19/2014','10/31/2014','12/11/2017','11/20/2016','8/30/2014','1/29/2015','11/15/2014','3/23/2015','6/1/2015','12/23/2018','2/4/2018','1/11/2017','10/19/2016','10/10/2015','12/16/2015','2/3/2019','5/17/2015','3/10/2017','3/29/2016','2/3/2018','5/3/2017','1/9/2019','7/17/2018','8/18/2014','11/19/2018','6/17/2018','2/26/2014','3/8/2016','7/23/2016','5/17/2014','4/17/2018','1/5/2017','3/6/2019','11/8/2016','3/19/2018','6/7/2015','7/30/2018','5/16/2016','2/11/2014','7/19/2016','3/5/2014','4/19/2016','5/10/2018','9/23/2016','2/4/2019','8/21/2016','6/21/2014','10/30/2015','3/6/2019','3/20/2018','10/12/2018','12/5/2014','1/10/2018','1/6/2018','10/19/2014','7/2/2015','8/30/2017','1/13/2016','4/30/2015','8/4/2014','6/19/2018','9/30/2014','11/20/2015','7/2/2015','9/8/2018','4/28/2018','12/23/2016','9/2/2016','12/29/2015','8/7/2014','1/20/2015','6/19/2018','1/13/2014','6/7/2018','6/13/2016','1/3/2018','11/22/2014','3/3/2016','3/10/2017','3/15/2018','3/4/2015','12/11/2017','9/18/2017','11/4/2016','4/10/2017','4/7/2017','12/24/2015','1/24/2018','11/8/2014','11/30/2018','4/8/2017','3/4/2017','8/9/2015','4/22/2016','12/8/2016','9/7/2015','7/2/2014','5/28/2015','1/31/2016','10/23/2014','7/20/2014','2/22/2015','2/27/2014','9/1/2017','11/1/2015','12/24/2017','2/6/2017','1/11/2015','3/2/2019','9/3/2015','4/28/2018','8/22/2017','1/25/2017','2/7/2015','1/28/2019','7/22/2014','9/13/2018','6/3/2015','6/19/2015','11/19/2014','8/21/2018','9/30/2014','1/24/2017','6/28/2018','10/3/2018','5/27/2017','12/18/2014','4/29/2016','3/6/2017','3/23/2016','8/16/2016','4/19/2018','5/9/2015','8/12/2017','1/10/2015','9/6/2014','1/25/2018','6/11/2018','7/29/2015','2/2/2018','8/31/2014','3/1/2015','2/23/2014','2/24/2016','3/10/2015','8/18/2017','12/25/2015','12/17/2014','2/19/2015','11/27/2016','6/19/2017','4/16/2017','6/15/2016','9/3/2015','8/21/2014','5/17/2018','7/27/2017','9/7/2015','2/22/2017','3/20/2015','1/16/2017','6/13/2018','10/20/2016','2/12/2018','11/7/2017','6/24/2018','4/7/2018','5/30/2016','3/2/2016','7/7/2017','7/31/2018','11/6/2017','10/14/2018','9/7/2014','10/2/2018','6/27/2017','5/11/2015','5/12/2016','2/13/2018','2/3/2014','6/16/2015','8/21/2016','7/5/2018','11/3/2015','10/19/2015','11/17/2018','12/9/2017','12/24/2017','12/15/2014','11/24/2016','12/18/2014','6/19/2015','8/1/2017','3/28/2016','11/15/2018','2/24/2019','11/28/2017','2/4/2018','9/27/2017','1/4/2018','6/18/2015','5/19/2015','2/5/2017','7/29/2017','10/28/2017','5/15/2014','8/9/2018','6/30/2015','5/13/2018','10/9/2015','8/2/2016','1/22/2016','9/24/2014','10/28/2017','10/26/2018','9/10/2014','11/17/2016','5/2/2016','8/30/2015','3/20/2014','7/22/2014','11/11/2016','8/5/2018','4/24/2018','3/20/2016','7/13/2015','9/23/2015','2/9/2017','10/30/2016','7/4/2016','12/23/2018','1/12/2019','5/28/2014','3/2/2015','10/8/2015','8/17/2016','2/6/2018','11/1/2017','4/24/2016','10/26/2017','12/9/2017','3/14/2014','3/13/2016','11/2/2017','9/22/2015','12/15/2016','10/18/2016','9/17/2017','5/3/2014','1/23/2017','9/7/2016','4/12/2015','2/17/2017','11/6/2014','2/27/2015','5/8/2016','11/8/2018','2/19/2019','2/25/2014','5/19/2016','12/22/2015','3/25/2016','7/15/2014','5/15/2017','1/29/2015','11/8/2016','12/3/2014','3/7/2015','12/29/2018','7/3/2015','7/22/2017','9/17/2017','3/26/2014','5/26/2017','5/3/2017','7/19/2017','9/6/2017','10/3/2018','8/24/2014','2/3/2017','6/26/2018','7/17/2016','11/11/2015','2/6/2019','11/16/2016','8/11/2016','4/23/2014','10/7/2014','9/20/2015','7/21/2018');

   v_employee_identity  EMPLOYEES.employee_identity%type; --fk
   v_hire_date EMPLOYEES.hire_date%type;
   v_salary EMPLOYEES.salary%type;

    BEGIN

 DBMS_OUTPUT.PUT_LINE('Inserarea a 40000 angajati...');
FOR v_i IN 1..40000
LOOP
  -----Orice angajat este o persoana, iar identitatea lui o vom stoca in tabelul de persoane-----
  SELECT person_id INTO v_employee_identity FROM
  (SELECT person_id, ROWNUM AS line_number FROM PERSONS)
  WHERE line_number=v_i;

  v_hire_date:= to_date(hire_dates(TRUNC(DBMS_RANDOM.VALUE(0,hire_dates.count))+1),'mm/dd/yyyy');

  v_salary:=TRUNC(DBMS_RANDOM.VALUE(1,5)*1000);

  INSERT INTO EMPLOYEES (employee_identity, hire_date, salary)
  VALUES (v_employee_identity, v_hire_date, v_salary);

END LOOP;
DBMS_OUTPUT.PUT_LINE('Inserarea a 40000 angajati...GATA');

COMMIT;
END;
/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------INSERARE GHIZI-----------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE
  v_employee_id  GUIDES.employee_id%type; --fk

    BEGIN
DBMS_OUTPUT.PUT_LINE('Inserarea a 10000 GHIZI...');
FOR v_i IN 1..10000
LOOP

    SELECT employee_id INTO v_employee_id FROM
    (SELECT employee_id, ROWNUM AS line_number FROM EMPLOYEES)
    WHERE line_number=v_i ;

    INSERT INTO GUIDES (employee_id)
    VALUES (v_employee_id);

END LOOP;
DBMS_OUTPUT.PUT_LINE('Inserarea a 10000 GHIZI...GATA');
END;
/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- zoo-keepers
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE
  v_employee_id  ZOO_KEEPERS.employee_id%type; --fk
  v_zone_id ZOO_ZONES.zone_id%type;
  v_line_count int;
  v_curent_line int;

    BEGIN

  DBMS_OUTPUT.PUT_LINE('Inserarea a 29999 GHIZI...');
  FOR v_i IN 10001..40000
  LOOP

    SELECT employee_id INTO v_employee_id FROM
    (SELECT employee_id, ROWNUM AS line_number FROM EMPLOYEES)
    WHERE line_number=v_i ;

    SELECT COUNT(*)INTO v_line_count FROM ZOO_ZONES;
    v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);
    SELECT zone_id INTO v_zone_id FROM
    (SELECT zone_id, ROWNUM AS line_number FROM ZOO_ZONES)
    WHERE line_number=v_curent_line;

    INSERT INTO ZOO_KEEPERS (employee_id, zone_id)
    VALUES (v_employee_id, v_zone_id);

  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Inserarea a 29999 GHIZI...GATA');

END;
/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------INSERARE VIZITATORI--------------------------------------------------------------------------------------------------------------------------------------

 DECLARE

TYPE varr IS VARRAY(200) OF varchar2(255);
visit_dates varr := varr ('5/1/2019','4/26/2019','5/15/2019','4/21/2019','4/9/2019','4/10/2019','5/11/2019','4/30/2019','5/1/2019',
  '4/20/2019','4/22/2019','5/5/2019','5/14/2019','4/13/2019','4/15/2019','4/21/2019','4/30/2019','4/8/2019','4/28/2019',
  '4/20/2019','4/11/2019','5/16/2019','5/6/2019','4/26/2019','4/22/2019','4/19/2019','5/14/2019','4/18/2019','4/22/2019','4/19/2019','5/19/2019','5/18/2019',
  '5/1/2019','5/7/2019','5/2/2019','5/5/2019','5/5/2019','4/23/2019','4/21/2019','5/17/2019','4/10/2019','4/27/2019','5/14/2019','5/4/2019','4/30/2019','4/25/2019',
  '5/9/2019','5/19/2019','4/19/2019','5/19/2019','4/14/2019','4/30/2019','4/29/2019','5/13/2019','5/8/2019','5/17/2019','4/30/2019','4/25/2019','5/5/2019','5/5/2019','4/20/2019',
  '5/11/2019','4/26/2019','5/16/2019','4/13/2019','5/6/2019','5/9/2019','4/22/2019','5/5/2019','4/28/2019','4/25/2019','4/28/2019','5/10/2019','4/7/2019','5/4/2019','5/11/2019',
  '5/1/2019','4/7/2019','5/18/2019','4/12/2019','4/15/2019','4/23/2019','5/19/2019','5/7/2019','4/29/2019','4/26/2019','4/20/2019','5/5/2019','4/26/2019','4/8/2019','5/14/2019','4/15/2019','4/19/2019','4/8/2019','4/23/2019','5/4/2019','4/29/2019','4/13/2019','4/16/2019','4/22/2019');


  v_ticket_details_id  VISITORS.ticket_details_id%type; --fk
  v_visitor_id VISITORS.visitor_id%type; --fk
  v_visit_date VISITORS.visit_date%type;
  v_guide_assigned_id VISITORS.guide_assigned_id%type; --fk
  v_line_count int;
  v_curent_line int;

  BEGIN

    DBMS_OUTPUT.PUT_LINE('Inserarea a 39999 VIZITATORI...');

  FOR v_i IN 40001..80000
  LOOP


    SELECT person_id INTO v_visitor_id FROM
    (SELECT person_id, ROWNUM AS line_number FROM PERSONS)
    WHERE line_number=v_i ;

    SELECT COUNT(*)INTO v_line_count FROM GUIDES;
    v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);
    SELECT guide_id INTO v_guide_assigned_id FROM
    (SELECT guide_id, ROWNUM AS line_number FROM GUIDES)
    WHERE line_number=v_curent_line;

    SELECT COUNT(*)INTO v_line_count FROM TICKETS;
    v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);
    SELECT ticket_type_id INTO v_ticket_details_id FROM
    (SELECT ticket_type_id, ROWNUM AS line_number FROM TICKETS)
    WHERE line_number=v_curent_line;

    v_visit_date:= to_date(visit_dates(TRUNC(DBMS_RANDOM.VALUE(0,visit_dates.count))+1),'mm/dd/yyyy');

    INSERT INTO VISITORS (ticket_details_id, visitor_id, visit_date, guide_assigned_id )
    VALUES (v_ticket_details_id, v_visitor_id, v_visit_date, v_guide_assigned_id);

    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Inserarea a 39999 VIZITATORI...GATA');

    END;
   /

---------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------ Populare SPECIES---------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------

 --SET SERVEROUTPUT ON;

 DECLARE
   TYPE varr IS VARRAY(10000) OF varchar2(255);
  lista_species_name varr := varr('Aardvark','Albatross','Alligator','Alpaca','Ant','Anteater','Antelope','Ape','Armadillo','Ass/donkey','Baboon','Badger','Barracuda','Bat','Bear ','Beaver','Bee','Bird ','Bison','Boar','Buffalo','Butterfly','Camel','Caribou','Cassowary','Cat ','Caterpillar','Cattle','Chameleon','Chamois','Cheetah','Chicken ','Chimpanzee','Chinchilla','Chough','Coati','Cobra','Cockroach','Cod','Cormorant','Coyote','Crab','Crane','Crocodile','Crow','Curlew','Deer','Dog ','Dogfish','Dolphin','Donkey ','Dotterel','Dove','Dragonfly','Duck ','Dugong','Dunlin','Eagle','Echidna','Eel','Eland','Elephant','Elephant seal','Elk (wapiti)','Emu','Falcon','Ferret','Finch','Fish ','Flamingo','Fly','Fox','Frog','Gaur','Gazelle','Gerbil','Giant panda','Giraffe','Gnat','Gnu','Goat ','Goldfinch','Goosander','Goose','Gorilla','Goshawk','Grasshopper','Grouse','Guanaco','Guinea fowl','Guinea pig','Gull','Hamster','Hare','Hawk','Hedgehog','Heron','Herring','Hippo','Hornet','Horse (list)','Hummingbird','Hyena','Ibex','Ibis','Impala','Jackal','Jaguar','Jay','Jellyfish','Kangaroo','Kinkajou','Koala','Komodo dragon','Kouprey','Kudu','Lapwing','Lark','Lemur','Leopard','Lion','Llama','Lobster','Locust','Loris','Louse','Lyrebird','Magpie','Mallard','Mammoth','Manatee','Mandrill','Mink','Mole','Mongoose','Monkey','Moose','Mosquito','Mouse','Narwhal','Newt','Nightingale','Nine-banded armadillo','Octopus','Okapi','Opossum','Ostrich','Otter','Owl','Oyster','Panda','Panther','Parrot','Partridge','Peafowl','Pelican','Penguin','Pheasant','Pig ','Pigeon','Polar bear','Pony','Porcupine','Porpoise','Prairie dog','Pug','Quail','Quelea','Quetzal','Rabbit','Raccoon','Ram','Rat ','Raven','Red deer','Red panda','Reindeer ','Rhinoceros','Rook','Salamander','Salmon','Sand dollar','Sandpiper','Sardine','Sea lion','Seahorse','Seal','Shark','Sheep','Shrew','Siamang','Skunk','Sloth','Snail','Snake  ','Spider  ','Squid','Squirrel','Starling','Stegosaurus','Swan','Tapir','Tarsier','Termite','Tiger','Toad','Turkey ','Turtle','Vicuña','Wallaby','Walrus','Wasp','Water buffalo','Weasel','Whale','Wolf','Wolverine','Wombat','Wren','Yak','Zebra');-----sunt tot in latina trb schimbate

  lista_latin_name varr := varr('Gorilla gorilla','Pseudalopex gymnocercus','Coluber constrictor','Nyctanassa violacea','Sarkidornis melanotos','Trichosurus vulpecula',
    'Pycnonotus nigricans','Tauraco porphyrelophus','Falco peregrinus','Macropus rufogriseus','Sarkidornis melanotos','Cordylus giganteus','Mazama americana',
    'Lepus arcticus','Pycnonotus nigricans','Pan troglodytes','Dicrostonyx groenlandicus','Propithecus verreauxi','Macaca nemestrina','Mycteria ibis','Cynomys ludovicianus',
    'Macropus eugenii','Corvus brachyrhynchos','Petaurus norfolcensis','Erinaceus frontalis','Funambulus pennati','Dasyurus viverrinus','Centrocercus urophasianus','Suricata suricatta',
    'Uraeginthus angolensis','Globicephala melas','Conolophus subcristatus','Alopex lagopus','Diomedea irrorata','Petaurus norfolcensis','Damaliscus lunatus','unavailable','Ammospermophilus nelsoni','Bugeranus caruncalatus','Corvus albicollis','Eremophila alpestris',
    'Dasyurus viverrinus','Acinynox jubatus','Lasiodora parahybana','Vulpes vulpes','Macaca nemestrina','Anitibyx armatus','Larus fuliginosus','Aonyx capensis','Crotalus cerastes','Phylurus milli','Seiurus aurocapillus','Macropus rufogriseus','Lasiodora parahybana','Aonyx cinerea','Pitangus sulphuratus','Pterocles gutturalis','Coracias caudata','Snycerus caffer',
    'Podargus strigoides','Uraeginthus granatina','Limnocorax flavirostra','Vanellus chilensis','Cordylus giganteus','Trachyphonus vaillantii','Ovis ammon','Ephippiorhynchus mycteria','Cabassous sp.','Lamprotornis nitens','Castor fiber','Columba palumbus','Aegypius occipitalis','Martes pennanti','Nectarinia chalybea','Aonyx capensis','Halcyon smyrnesis','Psittacula krameri',
    'Genetta genetta','Microcebus murinus','Mustela nigripes','Capreolus capreolus','Bassariscus astutus','Papio ursinus','Milvus migrans','Dasyurus maculatus','Carduelis pinus','Neotis denhami','Macropus rufogriseus','Alopex lagopus','Tachybaptus ruficollis','Ardea cinerea','Cracticus nigroagularis','Agelaius phoeniceus','Antilocapra americana','Coendou prehensilis','Felis concolor','Elephas maximus bengalensis','unavailable','Bubo virginianus','Vombatus ursinus','Pycnonotus nigricans','Nesomimus trifasciatus','Catharacta skua','Procyon cancrivorus','Sterna paradisaea','Stenella coeruleoalba','Pteronura brasiliensis','Columba livia','Trichoglossus haematodus moluccanus','Herpestes javanicus','Nasua nasua','Geochelone elephantopus','Parus atricapillus','Tamandua tetradactyla','Nesomimus trifasciatus','Limosa haemastica','Tachyglossus aculeatus','Antidorcas marsupialis','Ciconia episcopus','Marmota monax','Felis wiedi or Leopardus weidi',
    'Ploceus rubiginosus','Loxodonta africana','Francolinus coqui','Phalacrocorax varius','Cervus duvauceli','Phalacrocorax albiventer','Antidorcas marsupialis','Spermophilus parryii','Tayassu tajacu','Anastomus oscitans','Ursus arctos','Phalacrocorax carbo','Felis caracal','Macaca radiata','Crotalus cerastes','Cervus canadensis','Coendou prehensilis','Connochaetus taurinus','Pteronura brasiliensis','Dasyurus maculatus','Spermophilus armatus','Litrocranius walleri','Varanus sp.','Dasypus septemcincus','Ardea golieth','Microcebus murinus','Macaca mulatta','Anitibyx armatus','Neotis denhami','Pseudalopex gymnocercus','Meleagris gallopavo','Varanus sp.','Echimys chrysurus','Anas bahamensis','Papio ursinus','Paradoxurus hermaphroditus','Felis silvestris lybica','Haematopus ater','Oryx gazella','Tauraco porphyrelophus','Procyon cancrivorus','Meles meles','Colaptes campestroides','Bettongia penicillata','Chionis alba','Mazama americana','Phoenicopterus ruber','Damaliscus lunatus','Semnopithecus entellus','Columba palumbus','Upupa epops','Neophron percnopterus','Laniarius ferrugineus','Cyrtodactylus louisiadensis','Coluber constrictor foxii','Theropithecus gelada','Pan troglodytes','Coluber constrictor','Semnopithecus entellus','Epicrates cenchria maurus','Megaderma spasma','Galictis vittata','Sagittarius serpentarius','Hippotragus equinus','Isoodon obesulus','Capreolus capreolus','Diceros bicornis','Phalaropus fulicarius','Martes americana','Meles meles','Genetta genetta','Larus fuliginosus','Spizaetus coronatus','Xerus sp.','Grus antigone','Motacilla aguimp','Colaptes campestroides','Haematopus ater','Canis mesomelas','Philetairus socius','Cereopsis novaehollandiae','Phoca vitulina','Castor canadensis','Trichoglossus haematodus moluccanus','Dasyprocta leporina','Macropus agilis','Lamprotornis nitens','Anthropoides paradisea','Psophia viridis','Orcinus orca','Rangifer tarandus','Bucephala clangula','Papio cynocephalus','Columba palumbus','Ara ararauna','Tockus flavirostris','Castor fiber','Dasyurus maculatus','Graspus graspus','Trichoglossus haematodus moluccanus','Mazama gouazoubira','Antilope cervicapra','Ateles paniscus','Genetta genetta','Catharacta skua','Melanerpes erythrocephalus','Phascogale calura','Felis caracal','Phoca vitulina','Macropus rufogriseus','Isoodon obesulus','Acanthaster planci','Ciconia episcopus','Lophoaetus occipitalis','Phasianus colchicus','unavailable','Vanellus chilensis','Chauna torquata','Streptopelia senegalensis','Vanellus sp.','Varanus sp.','Neophoca cinerea','Pandon haliaetus','Madoqua kirkii','Sylvicapra grimma','Aegypius tracheliotus','Felis serval','Bison bison','Odocoileus hemionus','Columba livia','Paroaria gularis','Anitibyx armatus','Anas punctata','Vulpes chama','Pandon haliaetus','Trichoglossus chlorolepidotus','Toxostoma curvirostre','Mirounga leonina','Centrocercus urophasianus','Lutra canadensis','Pterocles gutturalis','Hippotragus equinus','Chauna torquata','Cervus duvauceli','Heloderma horridum','Felis concolor','Sula nebouxii','Conolophus subcristatus','Lamprotornis chalybaeus','Aonyx capensis','Dasypus novemcinctus','Choloepus hoffmani','Anas bahamensis','Procyon cancrivorus','Fulica cristata','Cygnus buccinator','Loxodonta africana','Dasyurus viverrinus','Castor fiber','Sarcophilus harrisii','Pycnonotus nigricans','Larus fuliginosus','Nasua narica','Chordeiles minor','Macropus fuliginosus','Sarcorhamphus papa','Oncorhynchus nerka','Gyps bengalensis','Equus hemionus','Nyctanassa violacea','Phascolarctos cinereus','Cracticus nigroagularis','Alcelaphus buselaphus caama','Macropus agilis','Sciurus vulgaris','Odocoilenaus virginianus','Colaptes campestroides','Smithopsis crassicaudata','Macropus eugenii','Stenella coeruleoalba','unavailable','Dasyurus viverrinus','Dendrocitta vagabunda','Lybius torquatus','Zenaida asiatica','Hystrix cristata','Damaliscus lunatus','Acridotheres tristis','Panthera leo persica','Madoqua kirkii','Cynictis penicillata','Morelia spilotes variegata','Sarcorhamphus papa','Geochelone radiata','Speothos vanaticus','Potamochoerus porcus','Pandon haliaetus','Ara chloroptera','Phoenicopterus chilensis','Eolophus roseicapillus','Ciconia ciconia','Cygnus buccinator','Aonyx capensis','Eolophus roseicapillus','Casmerodius albus','Centrocercus urophasianus','Meles meles','Tauraco porphyrelophus','Corvus albicollis','Corvus brachyrhynchos','Haliaetus leucogaster','Papio cynocephalus','Leptoptilos crumeniferus','Acrantophis madagascariensis','Porphyrio porphyrio','Gymnorhina tibicen','Motacilla aguimp','Butorides striatus','Helogale undulata','Panthera onca','Casmerodius albus','Porphyrio porphyrio','Echimys chrysurus','Coracias caudata','Dusicyon thous','Nyctea scandiaca','Bubalus arnee','Psophia viridis','Carduelis uropygialis','Chelodina longicollis','Sarcophilus harrisii','Psittacula krameri','Naja haje','Leptoptilus dubius','Trichoglossus haematodus moluccanus','Eubalaena australis','Coluber constrictor','Mazama gouazoubira','Dendrocitta vagabunda','Pteropus rufus','Mellivora capensis','Chelodina longicollis','Limosa haemastica','Eudromia elegans','Anastomus oscitans','Hippopotamus amphibius','Trichosurus vulpecula','Alces alces','Acrantophis madagascariensis','Epicrates cenchria maurus','Varanus sp.','Melursus ursinus','Connochaetus taurinus','Agkistrodon piscivorus','Antilope cervicapra','Varanus sp.','Eolophus roseicapillus','Cynictis penicillata','Acrantophis madagascariensis','Pteropus rufus','Dusicyon thous','Mycteria ibis','Acridotheres tristis','Gyps fulvus','Coluber constrictor','Vulpes vulpes','Rhabdomys pumilio','Lama pacos','Pseudocheirus peregrinus','Bison bison','Oreamnos americanus','Spizaetus coronatus','Haliaeetus leucoryphus','Cygnus atratus','Columba livia','Anathana ellioti','Corvus albicollis','Neotis denhami','Oryx gazella','Nyctanassa violacea','Bassariscus astutus','Trichosurus vulpecula','Vulpes chama','Melursus ursinus','Francolinus coqui','Zosterops pallidus','Smithopsis crassicaudata','Gopherus agassizii','Cervus canadensis','Tachyglossus aculeatus','Myrmecophaga tridactyla','Eremophila alpestris','Boa constrictor mexicana','Bassariscus astutus','Sciurus vulgaris','Bettongia penicillata','unavailable','Choloepus hoffmani','Bos taurus','Lemur fulvus','Turtur chalcospilos','Scolopax minor','Grus canadensis','Pedetes capensis','Colobus guerza','Ephippiorhynchus mycteria','Ictalurus furcatus','Mirounga angustirostris','Libellula quadrimaculata','Anas punctata','Acrantophis madagascariensis','Phalacrocorax carbo','Hippopotamus amphibius','Varanus sp.','Himantopus himantopus','Bucorvus leadbeateri','Anser anser','Ursus americanus','Acrobates pygmaeus','Ara chloroptera','Graspus graspus','Otaria flavescens','Lorythaixoides concolor','Elephas maximus bengalensis','Felis silvestris lybica','Dicrurus adsimilis','Neophoca cinerea','Lemur catta','Merops nubicus','Phoca vitulina','Capra ibex','Zenaida asiatica','Bucorvus leadbeateri','Acridotheres tristis','Helogale undulata','Naja haje','Oxybelis fulgidus','Pteronura brasiliensis','Paroaria gularis','unavailable','Mycteria ibis','Canis lupus baileyi','unavailable','Picoides pubescens','Sciurus niger','Damaliscus dorcas','Colaptes campestroides','Ciconia episcopus','Psophia viridis','Petaurus breviceps','Macropus fuliginosus','Cyrtodactylus louisiadensis','Uraeginthus granatina','Streptopelia decipiens','Hystrix cristata','Nesomimus trifasciatus','Falco peregrinus','Prionace glauca','Turtur chalcospilos','Lybius torquatus','Ninox superciliaris','Irania gutteralis','Tetracerus quadricornis','Varanus albigularis','Trichoglossus haematodus moluccanus','Ovis canadensis','Alces alces','Streptopelia senegalensis','Bubo virginianus','Milvus migrans','Psittacula krameri','Axis axis','Nyctea scandiaca','Leprocaulinus vipera','Catharacta skua','Pelecanus conspicillatus','Larus novaehollandiae','Upupa epops','Uraeginthus angolensis','Francolinus coqui','Tiliqua scincoides','Paradoxurus hermaphroditus','Speothos vanaticus','Creagrus furcatus','Paroaria gularis','Aegypius occipitalis','Zenaida galapagoensis','Pelecans onocratalus','Vulpes cinereoargenteus','Myrmecophaga tridactyla','Priodontes maximus','Melophus lathami','Felis yagouaroundi','Psophia viridis','Equus burchelli','Anthropoides paradisea','Elephas maximus bengalensis','Marmota caligata','Ciconia episcopus','Paradoxurus hermaphroditus','Otaria flavescens','Physignathus cocincinus','Lama guanicoe','Meleagris gallopavo','Haliaeetus leucocephalus','Bubulcus ibis','Tursiops truncatus','Actophilornis africanus','Phalacrocorax albiventer','Aegypius tracheliotus','Potos flavus','Anser caerulescens','Paraxerus cepapi','Tadorna tadorna','Coluber constrictor foxii','Redunca redunca','Canis aureus','Hystrix cristata','Ephipplorhynchus senegalensis','Chauna torquata','Rhea americana','Corallus hortulanus cooki','Ceratotherium simum','Grus rubicundus','Cygnus atratus','Canis lupus baileyi','Coluber constrictor','Tockus flavirostris','Psophia viridis','Drymarchon corias couperi','Psophia viridis','Lemur catta','Phalacrocorax carbo','Macropus parryi','Aegypius occipitalis','Mephitis mephitis','Bradypus tridactylus','Motacilla aguimp','Bucephala clangula','Dendrohyrax brucel','Dendrocitta vagabunda','Ninox superciliaris','Pteropus rufus','Melophus lathami','Chlamydosaurus kingii','Varanus salvator','Dromaeus novaehollandiae','Pelecanus occidentalis','Madoqua kirkii','Tayassu tajacu','Plectopterus gambensis','Pseudocheirus peregrinus','Antilope cervicapra','Varanus sp.','Isoodon obesulus','Ursus americanus','Bubo sp.','Ursus maritimus','Ploceus intermedius','Himantopus himantopus','Fratercula corniculata','Lutra canadensis','Buteo regalis','Procyon lotor','Lepus arcticus','Gazella granti','Trachyphonus vaillantii','Cervus duvauceli','Rangifer tarandus','Cebus apella','Nucifraga columbiana','Oreotragus oreotragus','Neotis denhami','Ploceus intermedius','Cebus nigrivittatus','Tiliqua scincoides','Stenella coeruleoalba','Cercatetus concinnus','Pelecanus conspicillatus','Ornithorhynchus anatinus','Ovis canadensis','Spermophilus parryii','Martes americana','Lamprotornis nitens','Dendrocygna viduata','Geococcyx californianus','Panthera leo persica','Bos taurus','Leptoptilos crumeniferus','Geococcyx californianus','Vulpes vulpes','Lutra canadensis','Morelia spilotes variegata','Laniarius ferrugineus','Anas bahamensis','Tockus erythrorhyncus','Sciurus niger','Uraeginthus angolensis','Theropithecus gelada','Cervus canadensis','Trichosurus vulpecula','Philetairus socius','Canis mesomelas','Dendrocitta vagabunda','Macropus robustus',
    'Plocepasser mahali','Mabuya spilogaster','Dusicyon thous','Centrocercus urophasianus','Lycaon pictus','Pseudocheirus peregrinus','Giraffe camelopardalis','Macropus fuliginosus','Corvus albus','Ammospermophilus nelsoni','Macropus fuliginosus','Vicugna vicugna','Tachyglossus aculeatus','Dicrostonyx groenlandicus','Sarcorhamphus papa','Pycnonotus barbatus','Echimys chrysurus','Acrantophis madagascariensis','Cacatua tenuirostris','Larus novaehollandiae','Tamandua tetradactyla','Alopex lagopus','Pavo cristatus','unavailable','Struthio camelus','Macaca fuscata','Acrobates pygmaeus','Leipoa ocellata','Felis concolor','Agelaius phoeniceus','Macropus rufogriseus','Columba livia','Graspus graspus','Gyps fulvus','Eubalaena australis','Castor fiber','Haliaeetus leucocephalus','Mirounga angustirostris','Alouatta seniculus','Felis rufus','Tachyglossus aculeatus','Lutra canadensis','Ictonyx striatus','Felis silvestris lybica','Boa constrictor mexicana','Cereopsis novaehollandiae','Nasua nasua','Tayassu pecari','Chlidonias leucopterus','Milvus migrans','Cynictis penicillata','Mazama americana','Amblyrhynchus cristatus','Procyon lotor','Cracticus nigroagularis','Gazella granti','Ratufa indica','Butorides striatus','Felis libyca','Phacochoerus aethiopus','Callipepla gambelii','Alopex lagopus','Erinaceus frontalis','Branta canadensis','Eolophus roseicapillus','Anas bahamensis','Ctenophorus ornatus','Hystrix cristata','Petaurus norfolcensis','Procyon lotor','Mirounga angustirostris','Aonyx capensis','Chloephaga melanoptera','Naja sp.','Mazama gouazoubira','Cygnus atratus','Funambulus pennati','Cracticus nigroagularis','Limosa haemastica','Cereopsis novaehollandiae','Myrmecobius fasciatus','Milvago chimachima','Nannopterum harrisi','Pitangus sulphuratus','Snycerus caffer','Phasianus colchicus','Anser anser','Vulpes cinereoargenteus','Alcelaphus buselaphus cokii','Antilope cervicapra','Cebus nigrivittatus','Phoenicopterus ruber','Paraxerus cepapi','Axis axis','Geochelone elegans','Vulpes vulpes','Arctogalidia trivirgata','Bos frontalis','Tamiasciurus hudsonicus','Nucifraga columbiana','Ceryle rudis','Nectarinia chalybea','Lamprotornis superbus','Gyps bengalensis','Libellula quadrimaculata','Laniaurius atrococcineus','Hymenolaimus malacorhynchus','Mabuya spilogaster','Alopochen aegyptiacus','Ovis dalli stonei','Diceros bicornis','Agouti paca','Macropus agilis','Zonotrichia capensis','Upupa epops','Coluber constrictor','Elephas maximus bengalensis','Cynictis penicillata','Eolophus roseicapillus','Haliaetus vocifer','Gyps fulvus','Felis concolor','Galago crassicaudataus','Charadrius tricollaris','Vanessa indica','Rangifer tarandus','Procyon lotor','Pytilia melba','Chlamydosaurus kingii','Amphibolurus barbatus','Amblyrhynchus cristatus','Ictonyx striatus','Ramphastos tucanus','Notechis semmiannulatus','Vulpes chama','Tadorna tadorna','Madoqua kirkii','Redunca redunca','Neophoca cinerea','Sitta canadensis','Taurotagus oryx','Buteo jamaicensis','Sitta canadensis','Ovis dalli stonei','Varanus sp.','Ovis dalli stonei','Cathartes aura','Cynictis penicillata','Anas bahamensis','unavailable','Geochelone elegans','Vombatus ursinus','Himantopus himantopus','Ardea cinerea','Motacilla aguimp','Ctenophorus ornatus','Pelecans onocratalus','Ninox superciliaris','Canis aureus','Trachyphonus vaillantii','Rhea americana','Mycteria leucocephala','Fregata magnificans','Neophoca cinerea','Cebus albifrons','Laniaurius atrococcineus','Dusicyon thous','Falco peregrinus','Sceloporus magister','Myrmecophaga tridactyla','Actophilornis africanus','Scolopax minor','Laniarius ferrugineus','Felis concolor','Drymarchon corias couperi','Crotalus triseriatus','Merops nubicus','Ciconia episcopus','Naja haje','Canis mesomelas','Lophoaetus occipitalis','Phalacrocorax niger','Tamiasciurus hudsonicus','Alcelaphus buselaphus caama','Ammospermophilus nelsoni','Pavo cristatus','Isoodon obesulus','Paraxerus cepapi','Corallus hortulanus cooki','Sula dactylatra','Phalaropus lobatus','Smithopsis crassicaudata','Chauna torquata','Scolopax minor','Platalea leucordia','Pelecanus conspicillatus','Coluber constrictor','Grus rubicundus','Columba livia','Macaca mulatta','unavailable','Chlidonias leucopterus','Macaca nemestrina','Anhinga rufa','Thalasseus maximus','Hyaena brunnea','Lasiodora parahybana','Marmota caligata','Papio cynocephalus','Petaurus norfolcensis','Thamnolaea cinnmomeiventris','Buteo galapagoensis','unavailable','Gerbillus sp.','Pterocles gutturalis','Papio cynocephalus','Mungos mungo','Lama glama','Pteronura brasiliensis','Butorides striatus','Alopex lagopus','Cabassous sp.','Heloderma horridum','Dusicyon thous','Xerus sp.','Uraeginthus angolensis','Paroaria gularis','Uraeginthus angolensis','Numida meleagris','Canis mesomelas','Castor canadensis','Hystrix indica','Hippopotamus amphibius','Terathopius ecaudatus','Limnocorax flavirostra','Anastomus oscitans','Dicrurus adsimilis','Lemur fulvus','Bos frontalis','Ammospermophilus nelsoni','Corvus brachyrhynchos','Alopex lagopus','Cebus nigrivittatus','Tyto novaehollandiae','Ardea golieth','Pseudocheirus peregrinus','Phalaropus fulicarius','Dacelo novaeguineae','Phascogale calura','Pycnonotus nigricans','Megaderma spasma','Tamandua tetradactyla','Ramphastos tucanus','Felis pardalis','Irania gutteralis','Kobus vardonii vardoni','Pseudocheirus peregrinus','Dendrohyrax brucel','Vulpes vulpes','Tayassu tajacu','Deroptyus accipitrinus','Phalacrocorax brasilianus','Rhea americana','Ceratotherium simum','Himantopus himantopus','Ploceus rubiginosus','Ammospermophilus nelsoni','Streptopelia senegalensis','Haematopus ater','Raphicerus campestris','Fratercula corniculata','Felis caracal','Pteropus rufus','Carduelis pinus','Lamprotornis sp.','Ammospermophilus nelsoni','Pseudocheirus peregrinus','Boa constrictor mexicana','Phascogale calura','Giraffe camelopardalis','Uraeginthus angolensis','Isoodon obesulus','Gazella thompsonii','Bos mutus','Pteropus rufus','Alopochen aegyptiacus','Zonotrichia capensis','Chloephaga melanoptera','Chionis alba','Coluber constrictor','Redunca redunca','Coendou prehensilis','Felis serval','Buteo regalis','Felis chaus','Vulpes chama','Uraeginthus granatina','Tamandua tetradactyla','Lemur fulvus','Spermophilus parryii','Creagrus furcatus','Chelodina longicollis','Pituophis melanaleucus','Pycnonotus nigricans','Cervus canadensis','Dicrostonyx groenlandicus','Macropus agilis','Grus canadensis','Antilocapra americana','Dicrostonyx groenlandicus','Cereopsis novaehollandiae','Notechis semmiannulatus','Orcinus orca','Felis silvestris lybica','Mycteria ibis','Pycnonotus barbatus','Meleagris gallopavo','Hymenolaimus malacorhynchus','Bucephala clangula','Ara ararauna','Panthera pardus','Melophus lathami','Sagittarius serpentarius','Boa constrictor mexicana','Echimys chrysurus','Lama guanicoe','Ratufa indica','Lophoaetus occipitalis','Grus rubicundus','Rangifer tarandus','Eolophus roseicapillus','Anitibyx armatus','Paraxerus cepapi','Creagrus furcatus','Thamnolaea cinnmomeiventris','Erethizon dorsatum','Varanus sp.','Neotoma sp.','Cynictis penicillata','Macropus robustus','Macropus robustus','Eolophus roseicapillus','Ateles paniscus','Oryx gazella','Morelia spilotes variegata','Bucorvus leadbeateri','Tadorna tadorna','Oxybelis sp.','Tamiasciurus hudsonicus','Lemur catta','Dasypus novemcinctus','unavailable','Phalacrocorax varius','Dicrurus adsimilis','Nyctereutes procyonoides','Ceratotherium simum','Hippotragus niger','Rangifer tarandus','Dendrocygna viduata','Hippotragus equinus','Alouatta seniculus','Tyto novaehollandiae','Psittacula krameri','Boa caninus','Spheniscus magellanicus','Bradypus tridactylus','Lasiorhinus latifrons',
    'Butorides striatus','Alopex lagopus','Speotyte cuniculata','Pteronura brasiliensis','Semnopithecus entellus','Megaderma spasma');


 v_species_name SPECIES.species_name%type;
 v_latin_name SPECIES.latin_name%type;
 v_medium_height  SPECIES.medium_height%type;
 v_medium_weight SPECIES.medium_weight%type;
 v_medium_age SPECIES.medium_age%type;

 BEGIN

    DBMS_OUTPUT.PUT_LINE('Inserarea 1000 specii ...');
    FOR v_i IN 1..1000 LOOP

       v_species_name := lista_species_name(TRUNC(DBMS_RANDOM.VALUE(0,lista_species_name.count))+1);
       v_latin_name := lista_latin_name(TRUNC(DBMS_RANDOM.VALUE(0,lista_latin_name.count))+1);
       v_medium_height := DBMS_RANDOM.VALUE(1,10)*10;
       v_medium_weight := DBMS_RANDOM.VALUE(0,2);
       v_medium_age := TRUNC(DBMS_RANDOM.VALUE(2,10));

       insert into SPECIES(species_name, latin_name, medium_height, medium_weight, medium_age)  values(v_species_name, v_latin_name, v_medium_height, v_medium_weight, v_medium_age);

    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Inserarea a 100 species... GATA !');

  END;
  /
---------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- Populare SUBSPECIES------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------
--SET SERVEROUTPUT ON;

 DECLARE
   TYPE varr IS VARRAY(1500) OF varchar2(255);
   lista_subspecies_name varr := varr ('Gila monster','Wildebeest blue','Azara s zorro','Squirrel indian giant','Onager','Australian sea lion','Monitor two-banded',
  'Little brown dove','Tawny frogmouth','Giant anteater','Common boubou shrike','Beisa oryx','Tortoise asian foreset','American marten',
  'African red-eyed bulbul','Greater flamingo','Shark blue','Coot red-knobbed','Zorilla','Downy woodpecker','Uinta ground squirrel',
  'Red-capped cardinal','Squirrel, richardsons ground','Black and white colobus','Beaver, eurasian','Klipspringer','Wolf, common',
  'Purple grenadier','Peacock, indian','Kingfisher, pied','Marine iguana','Guanaco','Mountain goat','California sea lion','Killer whale','Ring-tailed lemur',
  'Steenbok','Radiated tortoise','African fish eagle','Kookaburra, laughing','Rhinoceros, black','Small-spotted genet','Bustard, denhams','Gambels quail',
  'Nilgai','Bee-eater, nubian','Egret, great','Lion, southern sea','Gull, silver','Savannah deer','Hanuman langur','Deer, red','Springhare','Weaver, red-billed buffalo',
  'Carpet python','Asian false vampire bat','Caracara, yellow-headed','Hippopotamus','Marmot, yellow-bellied','Tropical buckeye butterfly','Crimson-breasted shrike','Swan, black',
  'Tailless tenrec','Goose, canada','North American porcupine','Puna ibis','Royal tern','Brown capuchin','Dragon, frilled','Shark, blue','Vulture, white-rumped',
  'Emerald-spotted wood dove','Grey fox','Tern, royal','Wagtail, african pied','Wattled crane','Lorikeet, scaly-breasted','Glossy ibis','Ocelot','Wallaby, bennetts','Mouse, four-striped grass','African clawless otter','Ibis, glossy','Manatee','Collared lemming','Kirks dik dik','Dolphin, common','Hornbill, red-billed',
  'Nelson ground squirrel','White-bellied sea eagle','Chipmunk, least','Chipmunk, least','Long-billed cockatoo','Vulture, bengal','Sage grouse','Asian water dragon',
  'Cockatoo, long-billed','Bent-toed gecko','Great white pelican','Cape Barren goose','Sulfur-crested cockatoo','Bateleur eagle','Jaeger, long-tailed','Blue catfish',
  'Little brown dove','Squirrel, european red','Curve-billed thrasher','Tamandua, southern','Collared lizard','Rufous-collared sparrow','Small Indian mongoose',
  'Rhea, gray','Long-tailed skua','Common brushtail possum','Jaeger, long-tailed','Hawk-headed parrot','Creeper, black-tailed tree','White-browed sparrow weaver',
  'Lion, south american sea','Gull, swallow-tail','Sparrow, rufous-collared','Lapwing, southern','Starling, superb','Western palm tanager (unidentified)',
  'Monitor, white-throated','Snake, eastern indigo','Eastern indigo snake','Egyptian goose','Tiger snake','Barbet, crested','Cobra (unidentified)',
  'Fox, bat-eared','Goldeneye, barrows','Long-necked turtle','Crown of thorns starfish','Timber wolf','Brown antechinus','Green-winged macaw',
  'Macaque, japanese','Ring-necked pheasant','Wallaby, euro','Asian lion','Polar bear','Snake, buttermilk','Common pheasant','Magpie, black-backed','Blacksmith plover',
  'Sandpiper, spotted wood','Wallaroo, common','Sable antelope','Racer snake','Paradoxure','Tailless tenrec','Black-backed magpie','Bee-eater, white-fronted','Moose',
  'Crane, sarus','Platypus','American beaver','Bee-eater, nubian','Tsessebe','Sloth, hoffmans','Mongoose, banded','Eastern diamondback rattlesnake','Chameleon (unidentified)',
  'Peacock, indian','Small-spotted genet','Dragon, asian water','Lizard, blue-tongued','Yellow-rumped siskin','Mallard','Woodchuck','Wolf, common','Lesser mouse lemur',
  'Deer, black-tailed','Cockatoo, sulfur-crested','Otter, african clawless','Admiral, indian red','Arctic ground squirrel','Snowy egret','Bustard, kori','Mongoose, yellow',
  'Hoffmans sloth','Heron, grey','Monitor lizard (unidentified)','Gull, herring','White-bellied sea eagle','Yellow baboon','Tsessebe','Rhesus macaque','Pied avocet','Wambenger, red-tailed','Yellow mongoose','Swan, trumpeter','Civet cat','Quoll, eastern','Sloth, hoffmans',
  'Common mynah','Spider, wolf','Bear, sloth','Lion, mountain','Lion, south american sea','Bear, sloth','Grison','Deer, roe','Turtle (unidentified)',
  'Mongoose, small indian','Bat, madagascar fruit','African jacana','Cat, native','Komodo dragon','Giant girdled lizard','Long-necked turtle','Black-crowned night heron',
  'Phalarope, grey','Pelican, australian','Gecko, ring-tailed','Sage grouse','Cat, european wild','Zorro, azaras','Colobus, magistrate black','Mouse, four-striped grass',
  'Guanaco','Capuchin, brown','Wolf, timber','African buffalo','Hyena, spotted','Francolin, coqui','Meerkat, red','Goanna lizard','Langur, gray','Dik, kirks dik','Lemur, lesser mouse',
  'Fox, grey','Stanley crane','Elephant, african','Sloth, two-toed tree','Wombat, common','Fox, asian red','Cockatoo, slender-billed','Savanna baboon','Beisa oryx','Dassie',
  'Nine-banded armadillo','Saddle-billed stork','Toddy cat','Penguin, fairy','Klipspringer','Snake, carpet','Black-throated cardinal','Hoary marmot','Tiger cat','Eurasian badger',
  'White-browed owl','Manatee','Squirrel, richardsons ground','Civet, common palm','Whale, baleen','Great cormorant','Boa, cooks tree','Coyote','White-bellied sea eagle',
  'Tailless tenrec','Eastern diamondback rattlesnake','Shark, blue','Eagle, crowned','Pigeon, feral rock','Stork, european','Vulture, white-rumped','Bat, little brown',
  'Eurasian hoopoe','Zebra, plains','Iguana, marine','Red meerkat','Duck, comb','Boa, cooks tree','Red-billed buffalo weaver','Meerkat','Cape clawless otter',
  'Lesser double-collared sunbird','Bateleur eagle','Cat, european wild','Eastern quoll','Western palm tanager (unidentified)','Seal, northern elephant',
  'European spoonbill','Quail, gambel''s','Giant girdled lizard','Galah','Snake-necked turtle','Grenadier, common','Hartebeest, cokes','Crested barbet',
  'Bleu, blue-breasted cordon','Brown brocket','Puma, south american','Prehensile-tailed porcupine','Mynah, common','Japanese macaque','Raccoon, common',
  'Eastern dwarf mongoose','Tailless tenrec','Long-tailed spotted cat','Paca','Indian leopard','Egyptian viper','Rhea, gray','Red-billed toucan','Brocket, red','Jungle cat',
  'Wombat, common','Stork, white','Gecko, bent-toed','Ground legaan','White-bellied sea eagle','Nine-banded armadillo','Collared lemming','Dassie','Heron, black-crowned night','Lesser double-collared sunbird','Great kiskadee','Nine-banded armadillo','Kaffir cat','Dolphin, bottle-nose','Gull, silver','White-throated monitor','Mourning collared dove','Silver-backed fox','Polar bear','Grouse, greater sage','Anteater, australian spiny','Grenadier, common','Bohor reedbuck','Fairy penguin','Woodrat (unidentified)','Brazilian tapir','Dog, african wild','Defassa waterbuck','Black-capped capuchin','Black spider monkey','Hedgehog, south african','Eurasian beaver','Deer, swamp','Ferret, black-footed','Sage hen','Meerkat, red','Barasingha deer','Potoroo','Hornbill, leadbeateris ground','White-eye, cape','Hoary marmot','White-winged black tern','Burchells gonolek','Bandicoot, short-nosed','Dragon, frilled','Dik, kirks dik','Bird, secretary','Sloth, pale-throated three-toed','Hoary marmot','Sloth, two-toed','Gull, southern black-backed','Weaver, lesser masked','Gull, lava','Purple grenadier','Flicker, campo','Brush-tailed rat kangaroo','Oriental white-backed vulture','Bleu, blue-breasted cordon','White-faced tree rat','Loris, slender','Snake, green vine','Bear, american black','African polecat','Ass, asiatic wild','Common dolphin','Cat, jungle','Cockatoo, sulfur-crested','Polecat, african','Rainbow lory','Lion, galapagos sea','Possum, common brushtail','Otter, african clawless','Jackal, indian','Topi','Four-spotted skimmer','Small-clawed otter','Goose, canada','Butterfly, tropical buckeye','Hyrax','Vulture, white-headed','Cereopsis goose','Common melba finch','Squirrel, eurasian red','Red-billed tropic bird','Moorhen, purple','Stork, white','Chilean flamingo','Bear, american black','Western palm tanager (unidentified)','Galapagos penguin','Great cormorant','Golden eagle','Butterfly (unidentified)','Two-banded monitor','Baboon, savanna','Gnu, brindled','Pronghorn','Moccasin, water','Marine iguana','Little brown bat','Openbill, asian','Teal, hottentot','Scaly-breasted lorikeet','Owl, burrowing','Rat, arboral spiny','Tawny frogmouth','Eland, common','Whale, southern right','Cape raven','Kafue flats lechwe','Reedbuck, bohor','Gull, lava','Silver gull','Common eland','Prehensile-tailed porcupine','Camel, dromedary','Fowl, helmeted guinea','Bat, little brown','White-bellied sea eagle','Sambar','Frilled lizard','Squirrel, indian giant','White-mantled colobus','American badger','Dog, black-tailed prairie','White-cheeked pintail','Purple moorhen','Superb starling','Gonolek, burchell''s','Eurasian hoopoe','Bird, black-throated butcher','Skua, great','Crowned hawk-eagle','Sunbird, lesser double-collared','Red-billed hornbill','Comb duck','Little brown bat','Paddy heron (unidentified)','Bustard, denham''s','Snake, racer','Onager','Bent-toed gecko','Skink, african','Flicker, field','Tailless tenrec','Grenadier, common','Lesser mouse lemur','Albatross, waved','Sloth, two-toed','African black crake','Stork, saddle-billed','Devil, tasmanian','Cat, cape wild','Moccasin, water','Agouti','Sloth, two-toed','Polecat, african','Racer snake','Southern black-backed gull','Knob-nosed goose','Boa, mexican','European wild cat','Crab-eating raccoon','Red lava crab','Greater blue-eared starling','Pine siskin','Slender-billed cockatoo','Campo flicker','Red-winged hawk (unidentified)','Little cormorant','Galapagos dove','Hornbill, southern ground','American Virginia opossum','Squirrel, malabar','Ibis, glossy','Vulture, egyptian','Steenbok','Squirrel, nelson ground','Fox, cape','Coqui partridge','Red hartebeest','Painted stork','Javanese cormorant','Common ringtail','Monkey, black spider','Admiral, indian red','Grebe, little','Leadbeateri''s ground hornbill','Coyote','Blue and yellow macaw','Snowy sheathbill','Flying fox (unidentified)','Kingfisher, malachite','Vulture, oriental white-backed','Cape fox','Buffalo, wild water','Wild boar','Magnificent frigate bird','Tortoise, radiated','Greater kudu','Lion, steller''s sea','Bulbul, black-fronted','Mexican wolf','Jackal, golden','Flightless cormorant','Tenrec, tailless','Southern tamandua','Fat-tailed dunnart','White-lipped peccary','Duiker, common','Roe deer','Arctic tern','Rat, white-faced tree','Black-tailed prairie dog','Pied avocet','Large-eared bushbaby','Heron, gray','Oryx, fringe-eared','European red squirrel','Rhea, gray','Jungle cat','Southern brown bandicoot','Flamingo, chilean','American black bear','Red-knobbed coot','Genet, common','African wild cat','Crane, stanley','Alligator, american','Duck, blue','Lemming, collared','Sparrow, rufous-collared','Duiker, common','Pintail, white-cheeked','Banded mongoose','Gull, southern black-backed','South African hedgehog','African pied wagtail','Nelson ground squirrel','American bison','Cobra, cape','Porcupine, crested','Little brown bat','Mexican boa','Duck, comb','Caracal','Rose-ringed parakeet','Eastern indigo snake','Bird, red-billed tropic','White-nosed coatimundi','Gull, southern black-backed','Salmon pink bird eater tarantula','South American meadowlark (unidentified)','Insect, stick','Lava gull','Canada goose','Asiatic wild ass','Silver gull','Koala','Grant''s gazelle','Savanna fox','Dusky rattlesnake','Racer, blue','Bonnet macaque','Prehensile-tailed porcupine','Siskin, yellow-rumped','Raccoon, crab-eating','Wolf, mexican','Raccoon dog','Camel, dromedary','Black-collared barbet','Malabar squirrel','Indian leopard','Oystercatcher, blackish','Vulture, oriental white-backed','Lion, southern sea','Brocket, brown','Gambels quail','Brolga crane','King cormorant','Bennetts wallaby','Mountain duck','Vulture, turkey','European stork','Oystercatcher, blackish','Grant''s gazelle','Arboral spiny rat','Kiskadee, great','Cardinal, red-capped','Grenadier, purple','Red-winged hawk (unidentified)','Desert tortoise','Owl, burrowing','Arboral spiny rat','Duck, comb','Fox, bat-eared','Stork, jabiru','Monitor, two-banded','Crane, brolga','Wolf, mexican','Crab (unidentified)','Indian leopard','Asiatic jackal','Dusky gull','Macaw, green-winged','Bulbul, black-fronted','Cape clawless otter','Gray heron','Urial','Land iguana','Red-necked phalarope','Cat, african wild','Goose, knob-nosed','Bee-eater, nubian','White-winged dove','Four-horned antelope','Carpet snake','Giant girdled lizard','Sloth, two-toed tree','White-headed vulture','Eagle, long-crested hawk','North American red fox','American badger','Weeper capuchin','Mexican boa','Ferret, black-footed','Spoonbill, european','Indian leopard','Beaver, eurasian','European red squirrel','Two-toed tree sloth','Tayra','Sacred ibis','Kudu, greater','Rhinoceros, white','Raccoon dog','Lava gull','Squirrel, richardson''s ground','Goose, egyptian','Cat, toddy','Giant armadillo','Eurasian badger','Scottish highland cow','Lizard, giant girdled','Catfish, blue','Black bear','Chilean flamingo','Large-eared bushbaby','Lechwe, kafue flats','Jackal, asiatic','Starling, red-shouldered glossy','Dromedary camel','Cottonmouth','Common pheasant','Rufous tree pie','White-fronted bee-eater','American racer','Bear, black','Gray rhea','Lizard, desert spiny','Kookaburra, laughing','Squirrel, thirteen-lined','Capuchin, brown','Ornate rock dragon','Snake, eastern indigo','Red-legged pademelon','Swan, trumpeter','Wallaby, red-necked','Asian elephant','Fringe-eared oryx','Mongoose, yellow','Francolin, coqui','Bleeding heart monkey','Kori bustard','Blue racer','Black-winged stilt','Alligator, american','Asian openbill','Radiated tortoise','Snake, buttermilk','Common zebra','Prairie falcon','Gull, silver','Lava gull','Stork, woolly-necked','Common langur','Goose, andean','Plover, three-banded','Flightless cormorant','Skunk, western spotted','Phalarope, red','Gerbil (unidentified)','Greater flamingo','Phalarope, red','Ostrich','Dragonfly, russian','Red sheep','Dove, galapagos','Albatross, galapagos','Waterbuck, common','Parrot, hawk-headed','Smith''s bush squirrel','Skunk, western spotted','Fairy penguin','Chimpanzee','Swan, trumpeter','Owl, snowy','Mynah, indian','Seal, southern elephant','Common rhea','Madagascar fruit bat','Cormorant, javanese','Fox, bat-eared','Red-cheeked cordon bleu','Colobus, magistrate black','Pale white-eye','Pronghorn','Black-throated butcher bird','Lava gull','Falcon, peregrine','Skimmer, four-spotted','Sociable weaver','Kafue flats lechwe','White-fronted bee-eater','Vulture, black','Black-throated butcher bird','Steller sea lion','Galapagos dove','Honey badger','Seal, southern elephant','Mongoose, banded','Tern, white-winged black','Bustard, stanley','Fox, pampa gray','White-rumped vulture','Sage grouse','Dolphin, common','Badger, european','Sable antelope','Lion, california sea','Antelope, four-horned','Rhinoceros, black','Corella, long-billed','Stork, black-necked','Starling, superb','Marten, american','Southern right whale','Red meerkat','Giraffe','Emu','Gazelle, thomson''s','Rufous-collared sparrow','Mockingbird, galapagos','Bunting, crested','Vulture, white-rumped','White-mantled colobus','Glider, squirrel','Eastern boa constrictor','Brown lemur','Scottish highland cow','Ibex','Gull, silver','Dark-winged trumpeter','Black-throated cardinal','Frilled dragon','Bear, grizzly','Racer, blue','Duck, mountain','Goose, cereopsis','Pie, indian tree','Lemming, arctic','Whale, killer','European wild cat','Lizard, collared','Crowned eagle','Alligator, american','Yak','Striped hyena','Kingfisher, white-throated','Owl, snowy','Nuthatch, red-breasted','African porcupine','Galapagos dove','King cormorant','Painted stork','Two-banded monitor','Parrot, hawk-headed','Common langur','Red howler monkey','Common langur','Coqui francolin','Cattle egret','Red-headed woodpecker','Fork-tailed drongo','Bear, grizzly','Crested barbet','Gecko (unidentified)','Eleven-banded armadillo (unidentified)','Pied cormorant','Meerkat','Toddy cat','Thirteen-lined squirrel','Woodrat (unidentified)','Vine snake (unidentified)','Secretary bird','Tiger snake','Booby, masked','Springhare','Common palm civet','Crimson-breasted shrike','Phalarope, grey','Crab-eating fox','White-necked stork','Tokay gecko','Turtle, long-necked','Snowy owl','Woolly-necked stork','Lion, australian sea','Agama lizard (unidentified)','Savannah deer (unidentified)','Galah','Pine squirrel','Southern ground hornbill','Wallaroo, common','Barbet, black-collared','Eastern quoll','Lapwing (unidentified)','Mongoose, javan gold-spotted','Boa, columbian rainbow','Coot, red-knobbed','Ibis, glossy','Baboon, savanna','Crab, sally lightfoot','Australian brush turkey','Southern white-crowned shrike','Chilean flamingo','Pelican, great white','Goldeneye, barrows','Indian mynah','Richardson''s ground squirrel','Alpaca','Black-cheeked waxbill','Godwit, hudsonian','Tasmanian devil','Lemur, brown','Tawny eagle','Porcupine, indian','Leadbeateris ground hornbill','Vulture, black','Kinkajou','Galapagos dove','Weeper capuchin','Llama','Fox, crab-eating','Hyena, spotted','Caribou','Rainbow lory','Legaan, Monitor (unidentified)','Yellow-headed caracara','Owl, great horned','Mallard','Tortoise, burmese brown mountain','Wolf, timber','Phascogale, brush-tailed','Eastern dwarf mongoose','Gorilla, western lowland','Ornate rock dragon','Feral rock pigeon','Turkey, australian brush','Peacock, indian','Burchells gonolek','Laughing kookaburra','Common ringtail','Fringe-eared oryx','Insect, stick','Wallaby, bennett''s','Ring dove','Antelope, roan','Leopard','Kingfisher, malachite','Fork-tailed drongo','Blesbok','Eurasian hoopoe','Western bearded dragon','Sea birds (unidentified)','Racer, american','Owl, australian masked','Otter, north american river','Dragon, western bearded','Black-fronted bulbul','Chickadee, black-capped','Argalis','Gray rhea','Rhea, greater','Agile wallaby','Ocelot','Indian tree pie','Bare-faced go away bird','Common wallaroo','Drongo, fork-tailed','Brown lemur','Flycatcher, tyrant','Cobra, egyptian','Tokay gecko','Hartebeest, cokes','Kite, black','Pronghorn','Gray langur','Gerbil (unidentified)','Tasmanian devil','American marten','Mouflon','Coyote','Boa, mexican','Common zebra','Boa, cooks tree','Armadillo, nine-banded','Antechinus, brown','White-necked stork','Slender loris','Frilled lizard','Peacock, indian','Drongo, fork-tailed','Hottentot teal','Springbuck','Frilled dragon','Lapwing, southern','Silver-backed jackal','Yellow-bellied marmot','Roan antelope','Pelican, australian','Jacana, african','Fowl, helmeted guinea','Turtle, eastern box','Jabiru stork','White-browed owl','Weaver, red-billed buffalo','Paradoxure','Greater flamingo','Bird, pied butcher','Lizard, desert spiny','Sheathbill, snowy','Red-billed tropic bird','Asian water dragon','Cockatoo, sulfur-crested','Capuchin, white-fronted','Owl, australian masked','Dog, black-tailed prairie','Genoveva','Chipmunk, least','Rhinoceros, white','American woodcock','Crowned eagle','Greater rhea','Warthog','Sandhill crane','Lesser masked weaver','Dusky gull','Oystercatcher, blackish','Eastern cottontail rabbit','Tawny eagle','Spotted wood sandpiper','Tawny frogmouth','Indian red admiral','Rhinoceros, black','Heron, black-crowned night','Common palm civet','Barbet, black-collared','Indian leopard','Crake, african black','Glossy starling (unidentified)','Blue-faced booby','Beisa oryx','American black bear','Argalis','Rattlesnake, horned','Python (unidentified)','Red-breasted nuthatch','Scarlet macaw','Black-eyed bulbul','Hudsonian godwit','Mexican beaded lizard','Wolf, mexican','Cormorant, little','Fringe-eared oryx','Red-billed buffalo weaver','Marten, american','Phalarope, northern','Glider, squirrel','Capuchin, black-capped');


v_subspecies_name SUBSPECIES.subspecies_name%type;
v_species_id SUBSPECIES.species_id%type ; --fk
v_subspecies_zone SUBSPECIES.zone_id%type;
v_line_count int;
v_curent_line int;

 BEGIN

DBMS_OUTPUT.PUT_LINE('Inserarea a 1500 subspeciilor...');
FOR v_i IN 1..1500 LOOP

   v_subspecies_name := lista_subspecies_name(TRUNC(DBMS_RANDOM.VALUE(0,lista_subspecies_name.count))+1);

    SELECT COUNT(*)INTO v_line_count FROM SPECIES;
    v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);
    SELECT species_id INTO v_species_id FROM
    (SELECT species_id, ROWNUM AS line_number FROM SPECIES)
    WHERE line_number=v_line_count ;

    SELECT COUNT(*)INTO v_line_count FROM ZOO_ZONES;
    v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);
    SELECT zone_id INTO v_subspecies_zone FROM
    (SELECT zone_id, ROWNUM AS line_number FROM ZOO_ZONES)
    WHERE line_number=v_line_count ;

    insert into SUBSPECIES(subspecies_name, species_id, zone_id )  values(v_subspecies_name, v_species_id, v_subspecies_zone);
END LOOP;
    DBMS_OUTPUT.PUT_LINE('Inserarea a 1500 subspecies... GATA !');

  END;
/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------INSERARE ANIMALS---------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--SET SERVEROUTPUT ON;

  DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_gender varr := varr('male','female');
  lista_admission_date varr := varr ('4/28/2018','5/22/2017','1/15/2018','11/19/2014','12/15/2016','4/8/2018','1/25/2016','6/27/2018','7/2/2016','1/17/2017','3/24/2016','5/10/2016','3/12/2014','9/17/2017','6/1/2015','9/16/2018','11/26/2014','7/24/2014','11/9/2015','1/6/2016','1/12/2016','1/29/2017','9/13/2017','10/23/2016','2/27/2019','10/9/2017','10/17/2018','8/19/2017','7/15/2017','7/31/2017','10/9/2015','11/13/2018','6/13/2018','9/30/2014','1/25/2016','3/18/2014','10/30/2016','7/31/2018','11/23/2015','10/26/2016','10/13/2015','5/20/2014','12/6/2018','6/21/2016','12/9/2015','2/4/2017','1/24/2016','5/18/2017','1/11/2014','12/18/2015','11/21/2015','2/19/2016','10/20/2014','12/21/2016','8/11/2015','3/14/2019','7/31/2014','7/29/2014','10/30/2016','8/7/2015','12/31/2018','5/11/2018','8/31/2017','1/12/2014','1/20/2018','4/8/2018','5/19/2018','2/15/2017','3/22/2017','1/10/2018','12/19/2016','8/12/2016','2/9/2018','3/18/2019','2/26/2019','12/10/2014','7/8/2015','7/19/2018','12/17/2018','2/28/2016','3/10/2015','11/24/2017','12/5/2014','12/18/2017','7/14/2014','6/15/2016','4/25/2017','1/4/2015','12/16/2015','12/28/2014','4/29/2016','9/26/2018','3/24/2018','4/30/2018','8/20/2014','4/21/2017','2/14/2014','4/1/2018','1/7/2015','12/1/2014','12/6/2016','3/11/2019','12/5/2015','7/30/2018','4/10/2016','7/6/2014','3/22/2019','3/30/2017','8/24/2018','10/21/2014','12/22/2016','7/19/2018','3/1/2014','7/31/2015','10/2/2014','12/13/2018','7/13/2018','5/28/2017','12/29/2016','10/30/2014','7/19/2014','2/24/2019','7/21/2018','8/29/2017','10/31/2015','3/26/2014','12/18/2018','10/18/2018','10/15/2018','8/4/2016','10/10/2015','10/15/2014','4/8/2018','9/30/2016','1/3/2019','12/22/2014','4/30/2015','3/3/2014','2/22/2016','6/4/2016','4/17/2016','8/27/2014','7/13/2017','4/16/2014','6/1/2015','7/9/2018','6/28/2017','12/24/2014','4/13/2016','10/9/2014','7/19/2017','3/20/2017','9/19/2017','7/27/2018','11/1/2014','3/16/2019','7/17/2018','11/19/2018','2/23/2019','3/27/2016','9/13/2017','3/9/2016','3/4/2016','4/8/2018','7/30/2017','2/14/2019','2/11/2019','6/15/2018','2/20/2015','2/16/2019','10/6/2015','7/19/2014','3/30/2016','10/11/2014','2/17/2019','4/25/2015','11/9/2018','6/10/2017','6/4/2015','4/15/2016','8/28/2017','4/22/2016','1/13/2018','11/16/2018','2/23/2017','4/11/2017','4/23/2016','3/30/2017','8/14/2018','9/8/2014','6/23/2017','1/28/2015','10/2/2016','10/17/2017','12/12/2018','5/6/2015','9/17/2017','3/7/2016','6/20/2015','6/30/2014','5/19/2017','4/25/2014','3/31/2016','11/22/2015','11/19/2018','2/21/2018','12/4/2018','2/10/2016','7/20/2014','3/13/2014','7/19/2014','10/31/2014','12/11/2017','11/20/2016','8/30/2014','1/29/2015','11/15/2014','3/23/2015','6/1/2015','12/23/2018','2/4/2018','1/11/2017','10/19/2016','10/10/2015','12/16/2015','2/3/2019','5/17/2015','3/10/2017','3/29/2016','2/3/2018','5/3/2017','1/9/2019','7/17/2018','8/18/2014','11/19/2018','6/17/2018','2/26/2014','3/8/2016','7/23/2016','5/17/2014','4/17/2018','1/5/2017','3/6/2019','11/8/2016','3/19/2018','6/7/2015','7/30/2018','5/16/2016','2/11/2014','7/19/2016','3/5/2014','4/19/2016','5/10/2018','9/23/2016','2/4/2019','8/21/2016','6/21/2014','10/30/2015','3/6/2019','3/20/2018','10/12/2018','12/5/2014','1/10/2018','1/6/2018','10/19/2014','7/2/2015','8/30/2017','1/13/2016','4/30/2015','8/4/2014','6/19/2018','9/30/2014','11/20/2015','7/2/2015','9/8/2018','4/28/2018','12/23/2016','9/2/2016','12/29/2015','8/7/2014','1/20/2015','6/19/2018','1/13/2014','6/7/2018','6/13/2016','1/3/2018','11/22/2014','3/3/2016','3/10/2017','3/15/2018','3/4/2015','12/11/2017','9/18/2017','11/4/2016','4/10/2017','4/7/2017','12/24/2015','1/24/2018','11/8/2014','11/30/2018','4/8/2017','3/4/2017','8/9/2015','4/22/2016','12/8/2016','9/7/2015','7/2/2014','5/28/2015','1/31/2016','10/23/2014','7/20/2014','2/22/2015','2/27/2014','9/1/2017','11/1/2015','12/24/2017','2/6/2017','1/11/2015','3/2/2019','9/3/2015','4/28/2018','8/22/2017','1/25/2017','2/7/2015','1/28/2019','7/22/2014','9/13/2018','6/3/2015','6/19/2015','11/19/2014','8/21/2018','9/30/2014','1/24/2017','6/28/2018','10/3/2018','5/27/2017','12/18/2014','4/29/2016','3/6/2017','3/23/2016','8/16/2016','4/19/2018','5/9/2015','8/12/2017','1/10/2015','9/6/2014','1/25/2018','6/11/2018','7/29/2015','2/2/2018','8/31/2014','3/1/2015','2/23/2014','2/24/2016','3/10/2015','8/18/2017','12/25/2015','12/17/2014','2/19/2015','11/27/2016','6/19/2017','4/16/2017','6/15/2016','9/3/2015','8/21/2014','5/17/2018','7/27/2017','9/7/2015','2/22/2017','3/20/2015','1/16/2017','6/13/2018','10/20/2016','2/12/2018','11/7/2017','6/24/2018','4/7/2018','5/30/2016','3/2/2016','7/7/2017','7/31/2018','11/6/2017','10/14/2018','9/7/2014','10/2/2018','6/27/2017','5/11/2015','5/12/2016','2/13/2018','2/3/2014','6/16/2015','8/21/2016','7/5/2018','11/3/2015','10/19/2015','11/17/2018','12/9/2017','12/24/2017','12/15/2014','11/24/2016','12/18/2014','6/19/2015','8/1/2017','3/28/2016','11/15/2018','2/24/2019','11/28/2017','2/4/2018','9/27/2017','1/4/2018','6/18/2015','5/19/2015','2/5/2017','7/29/2017','10/28/2017','5/15/2014','8/9/2018','6/30/2015','5/13/2018','10/9/2015','8/2/2016','1/22/2016','9/24/2014','10/28/2017','10/26/2018','9/10/2014','11/17/2016','5/2/2016','8/30/2015','3/20/2014','7/22/2014','11/11/2016','8/5/2018','4/24/2018','3/20/2016','7/13/2015','9/23/2015','2/9/2017','10/30/2016','7/4/2016','12/23/2018','1/12/2019','5/28/2014','3/2/2015','10/8/2015','8/17/2016','2/6/2018','11/1/2017','4/24/2016','10/26/2017','12/9/2017','3/14/2014','3/13/2016','11/2/2017','9/22/2015','12/15/2016','10/18/2016','9/17/2017','5/3/2014','1/23/2017','9/7/2016','4/12/2015','2/17/2017','11/6/2014','2/27/2015','5/8/2016','11/8/2018','2/19/2019','2/25/2014','5/19/2016','12/22/2015','3/25/2016','7/15/2014','5/15/2017','1/29/2015','11/8/2016','12/3/2014','3/7/2015','12/29/2018','7/3/2015','7/22/2017','9/17/2017','3/26/2014','5/26/2017','5/3/2017','7/19/2017','9/6/2017','10/3/2018','8/24/2014','2/3/2017','6/26/2018','7/17/2016','11/11/2015','2/6/2019','11/16/2016','8/11/2016','4/23/2014','10/7/2014','9/20/2015','7/21/2018');
  hire_dates  varr := varr ('4/28/2018','5/22/2017','1/15/2018','11/19/2014','12/15/2016','4/8/2018','1/25/2016','6/27/2018','7/2/2016','1/17/2017','3/24/2016','5/10/2016','3/12/2014','9/17/2017','6/1/2015','9/16/2018','11/26/2014','7/24/2014','11/9/2015','1/6/2016','1/12/2016','1/29/2017','9/13/2017','10/23/2016','2/27/2019','10/9/2017','10/17/2018','8/19/2017','7/15/2017','7/31/2017','10/9/2015','11/13/2018','6/13/2018','9/30/2014','1/25/2016','3/18/2014','10/30/2016','7/31/2018','11/23/2015','10/26/2016','10/13/2015','5/20/2014','12/6/2018','6/21/2016','12/9/2015','2/4/2017','1/24/2016','5/18/2017','1/11/2014','12/18/2015','11/21/2015','2/19/2016','10/20/2014','12/21/2016','8/11/2015','3/14/2019','7/31/2014','7/29/2014','10/30/2016','8/7/2015','12/31/2018','5/11/2018','8/31/2017','1/12/2014','1/20/2018','4/8/2018','5/19/2018','2/15/2017','3/22/2017','1/10/2018','12/19/2016','8/12/2016','2/9/2018','3/18/2019','2/26/2019','12/10/2014','7/8/2015','7/19/2018','12/17/2018','2/28/2016','3/10/2015','11/24/2017','12/5/2014','12/18/2017','7/14/2014','6/15/2016','4/25/2017','1/4/2015','12/16/2015','12/28/2014','4/29/2016','9/26/2018','3/24/2018','4/30/2018','8/20/2014','4/21/2017','2/14/2014','4/1/2018','1/7/2015','12/1/2014','12/6/2016','3/11/2019','12/5/2015','7/30/2018','4/10/2016','7/6/2014','3/22/2019','3/30/2017','8/24/2018','10/21/2014','12/22/2016','7/19/2018','3/1/2014','7/31/2015','10/2/2014','12/13/2018','7/13/2018','5/28/2017','12/29/2016','10/30/2014','7/19/2014','2/24/2019','7/21/2018','8/29/2017','10/31/2015','3/26/2014','12/18/2018','10/18/2018','10/15/2018','8/4/2016','10/10/2015','10/15/2014','4/8/2018','9/30/2016','1/3/2019','12/22/2014','4/30/2015','3/3/2014','2/22/2016','6/4/2016','4/17/2016','8/27/2014','7/13/2017','4/16/2014','6/1/2015','7/9/2018','6/28/2017','12/24/2014','4/13/2016','10/9/2014','7/19/2017','3/20/2017','9/19/2017','7/27/2018','11/1/2014','3/16/2019','7/17/2018','11/19/2018','2/23/2019','3/27/2016','9/13/2017','3/9/2016','3/4/2016','4/8/2018','7/30/2017','2/14/2019','2/11/2019','6/15/2018','2/20/2015','2/16/2019','10/6/2015','7/19/2014','3/30/2016','10/11/2014','2/17/2019','4/25/2015','11/9/2018','6/10/2017','6/4/2015','4/15/2016','8/28/2017','4/22/2016','1/13/2018','11/16/2018','2/23/2017','4/11/2017','4/23/2016','3/30/2017','8/14/2018','9/8/2014','6/23/2017','1/28/2015','10/2/2016','10/17/2017','12/12/2018','5/6/2015','9/17/2017','3/7/2016','6/20/2015','6/30/2014','5/19/2017','4/25/2014','3/31/2016','11/22/2015','11/19/2018','2/21/2018','12/4/2018','2/10/2016','7/20/2014','3/13/2014','7/19/2014','10/31/2014','12/11/2017','11/20/2016','8/30/2014','1/29/2015','11/15/2014','3/23/2015','6/1/2015','12/23/2018','2/4/2018','1/11/2017','10/19/2016','10/10/2015','12/16/2015','2/3/2019','5/17/2015','3/10/2017','3/29/2016','2/3/2018','5/3/2017','1/9/2019','7/17/2018','8/18/2014','11/19/2018','6/17/2018','2/26/2014','3/8/2016','7/23/2016','5/17/2014','4/17/2018','1/5/2017','3/6/2019','11/8/2016','3/19/2018','6/7/2015','7/30/2018','5/16/2016','2/11/2014','7/19/2016','3/5/2014','4/19/2016','5/10/2018','9/23/2016','2/4/2019','8/21/2016','6/21/2014','10/30/2015','3/6/2019','3/20/2018','10/12/2018','12/5/2014','1/10/2018','1/6/2018','10/19/2014','7/2/2015','8/30/2017','1/13/2016','4/30/2015','8/4/2014','6/19/2018','9/30/2014','11/20/2015','7/2/2015','9/8/2018','4/28/2018','12/23/2016','9/2/2016','12/29/2015','8/7/2014','1/20/2015','6/19/2018','1/13/2014','6/7/2018','6/13/2016','1/3/2018','11/22/2014','3/3/2016','3/10/2017','3/15/2018','3/4/2015','12/11/2017','9/18/2017','11/4/2016','4/10/2017','4/7/2017','12/24/2015','1/24/2018','11/8/2014','11/30/2018','4/8/2017','3/4/2017','8/9/2015','4/22/2016','12/8/2016','9/7/2015','7/2/2014','5/28/2015','1/31/2016','10/23/2014','7/20/2014','2/22/2015','2/27/2014','9/1/2017','11/1/2015','12/24/2017','2/6/2017','1/11/2015','3/2/2019','9/3/2015','4/28/2018','8/22/2017','1/25/2017','2/7/2015','1/28/2019','7/22/2014','9/13/2018','6/3/2015','6/19/2015','11/19/2014','8/21/2018','9/30/2014','1/24/2017','6/28/2018','10/3/2018','5/27/2017','12/18/2014','4/29/2016','3/6/2017','3/23/2016','8/16/2016','4/19/2018','5/9/2015','8/12/2017','1/10/2015','9/6/2014','1/25/2018','6/11/2018','7/29/2015','2/2/2018','8/31/2014','3/1/2015','2/23/2014','2/24/2016','3/10/2015','8/18/2017','12/25/2015','12/17/2014','2/19/2015','11/27/2016','6/19/2017','4/16/2017','6/15/2016','9/3/2015','8/21/2014','5/17/2018','7/27/2017','9/7/2015','2/22/2017','3/20/2015','1/16/2017','6/13/2018','10/20/2016','2/12/2018','11/7/2017','6/24/2018','4/7/2018','5/30/2016','3/2/2016','7/7/2017','7/31/2018','11/6/2017','10/14/2018','9/7/2014','10/2/2018','6/27/2017','5/11/2015','5/12/2016','2/13/2018','2/3/2014','6/16/2015','8/21/2016','7/5/2018','11/3/2015','10/19/2015','11/17/2018','12/9/2017','12/24/2017','12/15/2014','11/24/2016','12/18/2014','6/19/2015','8/1/2017','3/28/2016','11/15/2018','2/24/2019','11/28/2017','2/4/2018','9/27/2017','1/4/2018','6/18/2015','5/19/2015','2/5/2017','7/29/2017','10/28/2017','5/15/2014','8/9/2018','6/30/2015','5/13/2018','10/9/2015','8/2/2016','1/22/2016','9/24/2014','10/28/2017','10/26/2018','9/10/2014','11/17/2016','5/2/2016','8/30/2015','3/20/2014','7/22/2014','11/11/2016','8/5/2018','4/24/2018','3/20/2016','7/13/2015','9/23/2015','2/9/2017','10/30/2016','7/4/2016','12/23/2018','1/12/2019','5/28/2014','3/2/2015','10/8/2015','8/17/2016','2/6/2018','11/1/2017','4/24/2016','10/26/2017','12/9/2017','3/14/2014','3/13/2016','11/2/2017','9/22/2015','12/15/2016','10/18/2016','9/17/2017','5/3/2014','1/23/2017','9/7/2016','4/12/2015','2/17/2017','11/6/2014','2/27/2015','5/8/2016','11/8/2018','2/19/2019','2/25/2014','5/19/2016','12/22/2015','3/25/2016','7/15/2014','5/15/2017','1/29/2015','11/8/2016','12/3/2014','3/7/2015','12/29/2018','7/3/2015','7/22/2017','9/17/2017','3/26/2014','5/26/2017','5/3/2017','7/19/2017','9/6/2017','10/3/2018','8/24/2014','2/3/2017','6/26/2018','7/17/2016','11/11/2015','2/6/2019','11/16/2016','8/11/2016','4/23/2014','10/7/2014','9/20/2015','7/21/2018');

  v_gender ANIMALS.gender%type;
  v_subspecies_id SUBSPECIES.species_id%type ; --fk
  v_admission_date ANIMALS.admission_date%type;
  v_age ANIMALS.age%type;
  v_line_count int;
  v_curent_line int;

 BEGIN

  DBMS_OUTPUT.PUT_LINE('Inserarea  a 50000 animale...');
    FOR v_i IN 1..50000 LOOP

      v_admission_date := to_date(lista_admission_date(TRUNC(DBMS_RANDOM.VALUE(0,hire_dates.count))+1),'mm/dd/yyyy');
      v_gender := lista_gender(TRUNC(DBMS_RANDOM.VALUE(0,lista_gender.count))+1);
      v_age := TRUNC(DBMS_RANDOM.VALUE(2,10));

      SELECT COUNT(*)INTO v_line_count FROM SUBSPECIES;
      v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);

      SELECT subspecies_id INTO v_subspecies_id FROM
      (SELECT subspecies_id, ROWNUM AS line_number FROM SUBSPECIES)
      WHERE line_number=v_line_count ;

      insert into ANIMALS(age,gender, subspecies_id, admission_date)  values (v_age, v_gender, v_subspecies_id,v_admission_date);
    END LOOP;
      DBMS_OUTPUT.PUT_LINE('Inserarea a 50000 animale... GATA !');

  END;
/
-------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------INSERARE MEALS_PROGRAM-----------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------

--SET SERVEROUTPUT ON;

 DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_food_type varr := varr('Adonis','Alberta Spruce, Dwarf','Almond, Flowering','Aloe Vera','Alyssum, Sweet','Alyssum, Yellow','Ambassador Allium','Angelina Stonecrop','Apple Trees ','Arctic Beauty Kiwi','Arborvitae, Emerald Green','Arborvitae, North Pole','Arrowwood Viburnum','Ash Trees','Aspen Trees, Quaking','Autumn Blaze Maple','Autumn Clematis, Sweet','Autumn Joy Sedum','Avens','Azaleas ','Azalea, Gibraltar','Azalea, Golden Oriole','Azalea, Stewartstonian','Bachelor Buttons, Perennial','Bamboo Plants ','Baneberry','Barberry, Japanese','Barrenwort','Bayberry','Beautyberry','Bee Balm','Beech Trees','Bellflower, Dalmatian','Birch Trees','Bird of Paradise','Bitterroot','Bittersweet','Black-Eyed Susan','Black Knight Delphinium','Black Mondo Grass','Black Shamrocks','Bleeding Heart','Bloodgood Japanese Maple','Bloodroot','Bluebeard Shrubs','Bluebells, Spanish','Blue Chiffon Rose of Sharon','Blue Fescue Grass','Blue Hill Salvia','Blue Princess Holly','Blue Rug Juniper','Blue Spruce, Colorado','Blue Star Juniper','Boston Ivy','Bottlebrush Plant','Bougainvillea','Boxwood','Bugleweed','Bugloss, Italian','Bunchberry','Burning Bush','Butterbur','Butterfly Bush ','Butterfly Bush, Miss Ruby','Butterfly Bush, Blue Chip','Butterfly Weed','Candytuft','Candy Oh! Rose','Canna ','Caradonna Salvia','Castor Bean','Catmint ','Catmint, 6 Hills Giant','Catmint, Little Titch','Catnip Plants','Cherry Trees ','Cherry, Kwanzan','Chinese Lanterns','Chinese Wisteria','Chocolate Drop Sedum','Chrysanthemums','Clematis, Doctor Ruppel','Clematis, Sweet Autumn','Clematis, The President','Climbing Hydrangea','Clover','Columbine','Coneflower, Firebird','Coneflower, Secret Lust','Coral Bells, Blondie','Coreopsis, Moonbeam','Coreopsis, Ruby Frost','Corkscrew Rush','Cotoneaster','Crape Myrtle','Creeping Jenny','Creeping Phlox ','Creeping Phlox','Creeping Thyme','Crimson Queen Japanese Maple','Crocus','Crown Imperial','Cypress, Hinoki','Cypress, Leyland','Cypress, False','Daffodils','Dahlias, Akita','Daisy, Gerbera','Daisy, Montauk','Daisy, Shasta','Dalmatian Bellflowers','Daphne','Dappled Willow','David Phlox','Daylily, Stella de Oro','Dead Nettle, Spotted','Delphinium','Deutzia, Dwarf','Diablo Ninebark','Dogwood ','Dogwood, Creeping','Dogwood, Pink Flowering','Dogwood, Pagoda ','Dogwood, Red Twig','Dogwood Trees With Nice Fall Foliage','Dogwood Trees, Wolf Eyes','Dogwood, Yellow Twig','Doublefile Viburnum','Easter Lily','Elephant Ears','Elm Trees','English Boxwood','English Ivy','English Lavender Plants','Emerald Green Arborvitae','Euonymus, Emerald and Gold','Euonymus, Emerald Gaiety','Euonymus, Moonshadow','European Beech','False Cypress','Fescue, Blue','Filbert, Corkscrew','Fire Island Hosta','Flag, Northern Blue','Flamingo Willow','Flossflower','Flowering Almond','Flowering Dogwood Trees','Flowering Maple','Flowering Onion, Ambassador','Flowering Quince Shrubs','Foamy Bells, Solar Power','Forsythia','Fountain Grass, Purple','Foxglove','Francee Hosta','Frances Williams Hosta','Fringe Flower, Chinese','Garden Phlox, David','Garden Phlox, Nora Leigh','Garden Phlox, Volcano Ruby','Gerbera Daisy','Germander','Gibraltar Azaleas','Ginkgo Biloba','Glory-of-the-Snow','Gold Mops','Goldflame Spirea','Gold Mound Spirea','Golden Hakone Grass','Golden Oriole Azalea','Golden Chain Tree','Goldenrod','Gourds, Hardshell','Hardy Hibiscus','Hardy Hibiscus, Summerific Perfect Storm','Hawthorn Trees','Hazel, Witch','Hellebore Plants','Hemlock Trees','Hen and Chicks','Hepatica','Hickory Trees','Hinoki Cypress','Holly ','Holly, Blue Prince and Blue Princess','Holly, Hetz Japanese','Holly, Inkberry ','Holly, Nellie Stevens','Holly, Sky Pencil','Holly, Winterberry','Hollyhock Plants','Honesty','Hops, Summer Shandy','Horsetail','Hosta Fire Island','Hosta Francee','Hosta Frances Williams','Hosta Halcyon','Hosta Patriot','Hyacinths','Hydrangeas ','Hydrangea, Bobo','Hydrangea, Climbing','Hydrangea, Incrediball','Hydrangea, Invincibelle Spirit','Hydrangea, Nikko Blue','Hydrangea, Oakleaf','Hydrangea, PeeGee','Hydrangea, Rhapsody Blue ','Ice Plant','Impatiens','Incrediball Hydrangeas','Inkberry Holly ','Interrupted Fern','Invincibelle Spirit Hydrangeas','Iris Plants, Netted','Italian Bugloss','Ivy, Boston','Ivy, English','Jackman Clematis','Jane Magnolia','Japanese Barberry','Japanese Dogwood','Japanese Holly, Hetz','Japanese Honeysuckle','Japanese Maple','Japanese maple, Bloodgood','Japanese Maple, Crimson Queen','Japanese Rose','Japanese Umbrella Pine','Japanese White Pine, Dwarf','Japanese Willow','Jasmine, Winter','Joe-Pye Weed','Juniper, Blue Pfitzer','Juniper, Blue Rug','Juniper, Blue Star ','Kerria, Japanese','Kiwi Vine','Korean Spice Viburnum','Kwanzan Cherry Tree','Lantana','Laurel, Mountain','Lavender Plants','Lenten Rose Plants','Leopard Plant','Leyland Cypress','Lilacs, Common','Lilacs, Miss Kim','Lily-of-the-Valley','Lilyturf','Little Titch Catmint','Liverleaf','Lombardy Poplar Trees','Loosestrife, Yellow','Loropetalum, Chinese','Lupine, Blue ','Magnolia Tree, Jane','Magnolia Tree, Saucer','Magnolia Tree, Star','Maiden Grass','Maltese Cross','Maple Trees ','Maple, Autumn Blaze','Maple, Japanese','Mayapple ','May Night Salvia','Milkweed, Common','Milkweed, Butterfly Weed','Mimosa Tree','Miss Kim Lilac','Miss Ruby Butterfly Bush','Mistletoe','Mock Orange','Mondo Grass or "Monkey" Grass','Money Plant','Moneywort','Montauk Daisy','Moonbeam Coreopsis','Moonshadow Euonymus','Morning Glory','Moss Plants','Mount Airy Fothergilla','Mountain Laurel','Mugo (or "Mugho") Pine','Mums, Hardy','Myrtle, Crape','Myrtle, Creeping','Narcissus','Nellie Stevens Holly','Neon Flash Spirea','Nikko Blue Hydrangea','Ninebark, Diablo','North Pole Arborvitae','Oak Trees','Oakleaf Hydrangea','Oswego Tea','Pachysandra','Palm Trees','Papyrus Plants','Pasqueflower','Pearlbush','PeeGee Hydrangea','Peonies ','Peonies ','Peony, Red Charm','Periwinkle Plants','Phlox, Creeping','Phlox, David','Phlox, Garden','Phlox, Volcano Ruby','Pine Tree, Mugo','Pine, White Japanese Dwarf','Pipevine','Pitcher Plant, Purple','Plantain Lily','Poinsettias','Poplar Trees, Lombardy','Poplar Trees, Quaking Aspen','Poplar Trees  Tulip','Poppies ','Poppy, Oriental','Purslane','Purple Beautyberry','Purple Fountain Grass','Purple Shamrocks','Pussy Willow ','Quaking Aspen Trees','Quince Shrubs, Flowering','Red Charm Peony','Red Hot Poker Plant','Red Maple Tree','Red Oak Trees','Red Salvia','Red Twig Dogwood','Reticulated Iris','Rhododendrons','River Birch Trees','Rock Cotoneaster','Rodgers Flower','Rose, Japanese','Rose, Lenten','Rose Mallow, Summerific Perfect Storm','Rose of Sharon ','Rose of Sharon, Blue Chiffon','Rose of Sharon, Sugar Tip','Roses ','Roses ','Roses, Candy Oh!','Royal Candles Speedwell','Ruby Frost Coreopsis','Ruby Garden Phlox, Volcano','Rush, Corkscrew','Russian Sage ','Sage, Tricolor','Saint Johnswort','Salvia Plants ','Salvia, Blue Hill','Salvia, Caradonna','Salvia, May Night','Salvia, Mealy-Cup','Salvia, Red','Secret Lust Coneflower','Shagbark Hickories','Shamrocks','Silk Tree','Silver Dollar Plant','Silver Mound Artemisia','Six Hills Giant Catmint','Sky Pencil Holly','Snowdrops','Snow-in-Summer','Spanish Bluebells','Speedwell, Royal Candles','Spirea, Goldflame','Spirea, Gold Mound','Spirea, Neon Flash','Spotted Deadnettle Plants','Spotted Joe-Pye Weed','Spruce, Alberta','Spruce, Colorado Blue','Spurge, Japanese','Spurge, Wood','Squill, Siberian','Stargazer Lily','Stella de Oro Lily','Stewartstonian Azalea','Stonecrop, Angelina','Stonecrop, Autumn Joy','Stonecrop, Chocolate Drop','Sugar Maple Trees','Sugar Tip Rose of Sharon','Sumac Shrubs','Sweet Alyssum','Sweet Autumn Clematis','Sweet Vernal','Sweet Woodruff','Sweetgum Trees','Sweetspire, Virginia','Tansy','Thyme, Creeping','Tickseed','Tiger Lily','Torch Lily','Tree Hydrangea','Tree Peony','Tropicanna Canna','Trout Lily','Trumpet Vine','Tulip Trees','Tulips ','Umbrella Pine, Japanese','Vernal, Sweet','Viburnum, Arrowwood','Viburnum, Doublefile','Viburnum, Koreanspice','Viburnum, Snowball','Victoria Blue Salvia','Vinca Vine','Violets, Wild ','Virginia Bluebells','Virginia Creeper','Virginia Sweetspire','Volcano Ruby Garden Phlox','Washington Hawthorn Trees','Weigela','White Ash Trees','White Birch Trees','White Oak Trees','White Pine, Japanese Dwarf','Willow, Pussy','Winter Jasmine','Winterberry','Wisteria','Witch Hazel Plants','Wolf Eyes Dogwood Trees','Woodruff, Sweet','Wood Spurge','Woodland Phlox','Yarrow','Yellow Alyssum','Yellow Archangel','Yellow Birch Trees','Yellow Loosestrife ','Yellow Poplar Trees ','Yellow Twig Dogwood Trees','Yew','Zebra Grass ','Fringed Bleeding Hearts ');
  lista_feed_hour varr := varr( '08:00','10:00','12:00','14:00','15:00','18:00','20:00');

  v_food_type MEALS_PROGRAM.food_type%type;
  v_feed_hour MEALS_PROGRAM.feed_hour%type;

 BEGIN

DBMS_OUTPUT.PUT_LINE('Inserarea meselor si continuturilor (10000)...');
  FOR v_i IN 1..1000 LOOP

    v_feed_hour := lista_feed_hour(TRUNC(DBMS_RANDOM.VALUE(0,lista_feed_hour.count))+1);
    v_food_type := lista_food_type(TRUNC(DBMS_RANDOM.VALUE(0,lista_food_type.count))+1);

    insert into MEALS_PROGRAM(feed_hour, food_type)  values (v_feed_hour, v_food_type);
  END LOOP;
DBMS_OUTPUT.PUT_LINE('Inserarea meselor si continuturilor(10000).. GATA !');

  END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------INSERT SUBSPECIES_MEALS---------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
 --SET SERVEROUTPUT ON;

 DECLARE
  v_subspecies_id SUBSPECIES_MEALS.subspecies_id%type; --fk
  v_meal_id SUBSPECIES_MEALS.meal_id%type ; --fk
  v_line_count int;
  v_curent_line int;

 BEGIN

    DBMS_OUTPUT.PUT_LINE('Inserarea programarilor de mese pt subspecii...');
      FOR v_i IN 1..5000 LOOP

          SELECT COUNT(*)INTO v_line_count FROM MEALS_PROGRAM;
          v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);

          SELECT meal_id INTO v_meal_id FROM
          (SELECT meal_id, ROWNUM AS line_number FROM MEALS_PROGRAM)
          WHERE line_number=v_line_count ;

          SELECT COUNT(*)INTO v_line_count FROM SUBSPECIES;
          v_curent_line:=DBMS_RANDOM.VALUE(1,v_line_count);
          SELECT subspecies_id INTO v_subspecies_id FROM
          (SELECT subspecies_id, ROWNUM AS line_number FROM SUBSPECIES)
          WHERE line_number=v_line_count ;

          insert into SUBSPECIES_MEALS(subspecies_id, meal_id)  values (v_subspecies_id, v_meal_id);

      END LOOP;
    DBMS_OUTPUT.PUT_LINE('Inserarea programarilor de mese pt subspecii... GATA !');

  END;
/
