CREATE SCHEMA relational;

CREATE TABLE relational.vehicle_status (
    id INT PRIMARY KAY,
    name VARCHAR(50)
);

CREATE SEQUENCE relational.id_vehicle;

CREATE TABLE relational.vehicles(
    id int DEFAULT NEXTVAL("relational.id_vehicle":: REGCLASS) PRIMARY KEY,
    acquisition_date date,
    year int,
    make varchar(100),
    model VARCHAR(100),
    plate varchar(50),
    id_statud int REFERENCE relational.vehicle_status(id),
    daily_rental_price numeric(12,4)
);

CREATE TABLE relational.client_status(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE SEQUENCE relational.id_client;

-- Create a new relational table with 3 columns

CREATE TABLE relational.clients 
(
  ID int DEFAULT NEXTVAL("relational.id_client"::REGCLASS) PRIMARY KEY,
  NAME VARCHAR(200),
  birth_date DATE,
  cpf varchar(11) unique not null,
  cnh_expiration_date DATE,
  telephone varchare(20),
  registration_date date,
  id_status int REFERENCE relational.client_status(id)
);

CREATE SEQUENCE relational.id_subsidiary;
CREATE TABLE relational.subsidiaries(
    id INT DEFAULT NEXTVAL('relational.id_subsidiary'::REGCLASS) PRIMARY KEY,
    name VARCHAR(200),
    address VARCHAR(500)
);

CREATE SEQUENCE relational.id_dispatcher;
CREATE TABLE relational.dispatchers(
    id int DEFAULT NEXTVAL('relational.dispatcher'::REGCLASS) PRIMARY KEY,
    name VARCHAR(200),
    id_status INT REFERENCE relational.dispatcher_status(id),
    id_subsidiary int REFERENCE relational.subsidiaries (id)
);

CREATE SEQUENCE relational.id_rent;
create table relational.rents(
    id int DEFAULT NEXTVAL('relational.id_rent' :: REGCLASS) PRIMARY KEY,
    id_vehicle int REFERENCE relational.vehicle(id),
    id_client int REFERENCE relational.clients(id),
    id_dispatcher int REFERENCE relational.dispatichers(id),
    rent_date DATE,
    return_date date,
    total_price numeric(12,4)
);
