DROP TABLE IF EXISTS WORK_PRICINGOPTION;
DROP TABLE IF EXISTS WORK_PRICINGFARE;
DROP TABLE IF EXISTS WORK_ITINERAIRE_LEG;
DROP TABLE IF EXISTS WORK_SEGMENT_LEG;
DROP TABLE IF EXISTS WORK_LEG;
DROP TABLE IF EXISTS WORK_ITINERAIRE;
DROP TABLE IF EXISTS WORK_SEGMENT;
DROP TABLE IF EXISTS WORK_AGENT;
DROP TABLE IF EXISTS WORK_ARRIVER;
DROP TABLE IF EXISTS WORK_DEPART;
DROP TABLE IF EXISTS WORK_AIRPORT;
DROP TABLE IF EXISTS WORK_CITY;
DROP TABLE IF EXISTS WORK_COUNTRY;
DROP TABLE IF EXISTS WORK_CARRIERE;
DROP TABLE IF EXISTS WORK_ALLIANCE;

DROP TABLE IF EXISTS WORK_CARRIERE2;
DROP TABLE IF EXISTS WORK_CITY2;
DROP TABLE IF EXISTS WORK_AIRPORT2;
DROP TABLE IF EXISTS WORK_SEGMENT2;


CREATE TABLE WORK_COUNTRY (
    id_country INT PRIMARY KEY,
    code_country INT,
    name VARCHAR,
    coordinate VARCHAR
);

CREATE TABLE WORK_CITY (
    id_city INT PRIMARY KEY,
    code_city INT,
    name VARCHAR,
    coordinate VARCHAR,
    iata VARCHAR(10),
    code_country INT
);

CREATE TABLE WORK_CITY2 (
    id_city INT PRIMARY KEY,
    code_city INT,
    name VARCHAR,
    coordinate VARCHAR,
    iata VARCHAR(10),
    id_country INT
);

CREATE TABLE WORK_AIRPORT (
    id_airport INT PRIMARY KEY,
    code_airport INT,
    name VARCHAR,
    coordinate VARCHAR,
    iata VARCHAR(10),
    code_city INT
);

CREATE TABLE WORK_AIRPORT2 (
    id_airport INT PRIMARY KEY,
    code_airport INT,
    name VARCHAR,
    coordinate VARCHAR,
    iata VARCHAR(10),
    id_city INT
);

CREATE TABLE WORK_ALLIANCE (
    id_alliance INT PRIMARY KEY,
    code_alliance INT,
    name VARCHAR(255) 
);

CREATE TABLE WORK_CARRIERE (
    id_carriere INT PRIMARY KEY,
    code_carriere INT,
    code_alliance INT,
    img_url VARCHAR,
    iata VARCHAR(10),
    icao VARCHAR(10),
    displaycode VARCHAR,
    name VARCHAR
);

CREATE TABLE WORK_CARRIERE2 (
    id_carriere INT PRIMARY KEY,
    code_carriere INT,
    id_alliance INT,
    img_url VARCHAR,
    iata VARCHAR(10),
    icao VARCHAR(10),
    displaycode VARCHAR,
    name VARCHAR
);

CREATE TABLE WORK_ARRIVER (
    id_arriver INT PRIMARY KEY,
    date TIMESTAMP
);

CREATE TABLE WORK_DEPART (
    id_depart INT PRIMARY KEY,
    date TIMESTAMP
);

CREATE TABLE WORK_SEGMENT (
    id_segment INT PRIMARY KEY,
    code_segment VARCHAR,
    code_airport_depart INT,
    code_airport_arrive INT,
    depart TIMESTAMP,
    arrive TIMESTAMP,
    marketing_carriere_id INT,
    operational_carriere_id INT,
    marketing_flight_number VARCHAR,
    duration_minute INT
);


CREATE TABLE WORK_SEGMENT2 (
    id_segment INT PRIMARY KEY,
    code_segment VARCHAR,
    id_airport_depart INT,
    id_airport_arrive INT,
    id_depart INT,
    id_arrive INT,
    marketing_carriere_id INT,
    operational_carriere_id INT,
    marketing_flight_number VARCHAR,
    duration_minute INT,
    FOREIGN KEY (id_airport_depart) REFERENCES AIRPORT(id_airport),
    FOREIGN KEY (id_airport_arrive) REFERENCES AIRPORT(id_airport),
    FOREIGN KEY (id_depart) REFERENCES DEPART(id_depart),
    FOREIGN KEY (id_arrive) REFERENCES ARRIVER(id_arriver),
    FOREIGN KEY (marketing_carriere_id) REFERENCES CARRIERE(id_carriere),
    FOREIGN KEY (operational_carriere_id) REFERENCES CARRIERE(id_carriere)
);

CREATE TABLE WORK_AGENT (
    id_agent INT PRIMARY KEY,
    code_agent VARCHAR,
    name VARCHAR,
    type VARCHAR,
    img_url VARCHAR,
    feedback_count INT,
    rating FLOAT,
    is_optimise_formability BOOLEAN,
    custom_service FLOAT,
    reliable_price FLOAT,
    clear_extract_fees FLOAT,
    easy_of_booking FLOAT,
    other FLOAT
);

CREATE TABLE WORK_PRICINGFARE (
    code_segment varchar,
    code_agent varchar,
    amount FLOAT,
    unit VARCHAR,
    update_status VARCHAR,
    deeplink VARCHAR,
    booking_code VARCHAR,
    fare_basis_code VARCHAR
);

CREATE TABLE WORK_LEG (
    code_leg VARCHAR,
    airport_depart INT,
    airport_arrive INT,
    depart TIMESTAMP,
    arrive TIMESTAMP,
    stop_count SMALLINT,
    duration_minute INT
);

CREATE TABLE WORK_SEGMENT_LEG (
    code_segment varchar,
    code_leg varchar
);

CREATE TABLE WORK_ITINERAIRE (
    code_itineraire VARCHAR,
    sustainable_data VARCHAR
);

CREATE TABLE WORK_ITINERAIRE_LEG (
    code_itineraire varchar,
    code_leg varchar
);

CREATE TABLE WORK_PRICINGOPTION (
    code_itineraire varchar,
    amount FLOAT,
    unit VARCHAR,
    status VARCHAR,
    tranfert_type VARCHAR,
    id VARCHAR,
    pricing_option_fare VARCHAR
);

