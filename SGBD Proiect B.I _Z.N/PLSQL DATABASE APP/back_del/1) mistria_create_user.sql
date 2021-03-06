CREATE USER mistria IDENTIFIED BY mistria DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;

ALTER USER mistria QUOTA 5G ON USERS;

GRANT CONNECT TO mistria;

GRANT CREATE TABLE TO mistria;

GRANT CREATE VIEW TO mistria;

GRANT CREATE SEQUENCE TO mistria;

GRANT CREATE TRIGGER TO mistria;

GRANT CREATE SYNONYM TO mistria;

GRANT CREATE PROCEDURE TO mistria;

GRANT CREATE TYPE TO mistria;
------
CREATE OR REPLACE DIRECTORY PRDIR as '/data/plsql_proiect/';

GRANT EXECUTE ON UTL_FILE TO mistria;

GRANT CREATE ANY DIRECTORY TO mistria;

GRANT READ,WRITE ON DIRECTORY PRDIR TO mistria;

