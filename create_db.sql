-- DROP TABLE IF EXISTS PRICINGOPTION;
-- DROP TABLE IF EXISTS PRICINGFARE;
-- DROP TABLE IF EXISTS ITINERAIRE_LEG;
-- DROP TABLE IF EXISTS SEGMENT_LEG;
-- DROP TABLE IF EXISTS LEG;
-- DROP TABLE IF EXISTS ITINERAIRE;
-- DROP TABLE IF EXISTS SEGMENT;
-- DROP TABLE IF EXISTS AGENT;
-- DROP TABLE IF EXISTS ARRIVER;
-- DROP TABLE IF EXISTS DEPART;
-- DROP TABLE IF EXISTS AIRPORT;
-- DROP TABLE IF EXISTS CITY;
-- DROP TABLE IF EXISTS COUNTRY;
-- DROP TABLE IF EXISTS CARRIERE;
-- DROP TABLE IF EXISTS ALLIANCE;

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE ALLIANCE (
    id_alliance SERIAL PRIMARY KEY,
    code_alliance INT,
    name VARCHAR(255) 
);


CREATE TABLE COUNTRY (
    id_country SERIAL PRIMARY KEY,
    code_country INT,
    name VARCHAR,
    coordinate VARCHAR
);

CREATE TABLE CITY (
    id_city SERIAL PRIMARY KEY,
    code_city INT,
    name VARCHAR,
    coordinate VARCHAR,
    iata VARCHAR(10),
    id_country INT,
    FOREIGN KEY (id_country) REFERENCES COUNTRY(id_country)
);

CREATE TABLE AIRPORT (
    id_airport SERIAL PRIMARY KEY,
    code_airport INT,
    name VARCHAR,
    coordinate VARCHAR,
    iata VARCHAR(10),
    id_city INT,
    FOREIGN KEY (id_city) REFERENCES CITY(id_city)
);


CREATE TABLE CARRIERE (
    id_carriere SERIAL PRIMARY KEY,
    code_carriere INT,
    id_alliance INT,
    img_url VARCHAR,
    iata VARCHAR(10),
    icao VARCHAR(10),
    displaycode VARCHAR,
    name VARCHAR,
    FOREIGN KEY (id_alliance) REFERENCES ALLIANCE(id_alliance)
);

CREATE TABLE ARRIVER (
    id_arriver SERIAL PRIMARY KEY,
    date TIMESTAMP
);

CREATE TABLE DEPART (
    id_depart SERIAL PRIMARY KEY,
    date TIMESTAMP
);

CREATE TABLE SEGMENT (
    id_segment SERIAL PRIMARY KEY,
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

CREATE TABLE AGENT (
    id_agent SERIAL PRIMARY KEY,
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
    other FLOAT,
    start_at DATE,
    end_at DATE
);

CREATE TABLE PRICINGFARE (
    id_pricing_fare SERIAL PRIMARY KEY,
    id_segment INT,
    id_agent INT,
    amount FLOAT,
    unit VARCHAR,
    update_status VARCHAR,
    deeplink VARCHAR,
    booking_code VARCHAR,
    fare_basis_code VARCHAR,
    FOREIGN KEY (id_segment) REFERENCES SEGMENT(id_segment),
    FOREIGN KEY (id_agent) REFERENCES AGENT(id_agent)
);

CREATE TABLE LEG (
    id_leg SERIAL PRIMARY KEY,
    code_leg VARCHAR,
    airport_depart INT,
    airport_arrive INT,
    depart TIMESTAMP,
    arrive TIMESTAMP,
    stop_count SMALLINT,
    duration_minute INT
);

CREATE TABLE SEGMENT_LEG (
    id_segment INT,
    id_leg INT,
    PRIMARY KEY (id_segment, id_leg),
    FOREIGN KEY (id_segment) REFERENCES SEGMENT(id_segment),
    FOREIGN KEY (id_leg) REFERENCES LEG(id_leg)
);

CREATE TABLE ITINERAIRE (
    id_itineraire SERIAL PRIMARY KEY,
    code_itineraire VARCHAR,
    sustainable_data VARCHAR
);

CREATE TABLE ITINERAIRE_LEG (
    id_leg INT,
    id_itineraire INT,
    PRIMARY KEY (id_leg, id_itineraire),
    FOREIGN KEY (id_leg) REFERENCES LEG(id_leg),
    FOREIGN KEY (id_itineraire) REFERENCES ITINERAIRE(id_itineraire)
);

CREATE TABLE PRICINGOPTION (
    id_pricing_option SERIAL PRIMARY KEY,
    id_itineraire INT,
    amount FLOAT,
    unit VARCHAR,
    status VARCHAR,
    tranfert_type VARCHAR,
    id VARCHAR,
    pricing_option_fare VARCHAR,
    FOREIGN KEY (id_itineraire) REFERENCES ITINERAIRE(id_itineraire)
);

