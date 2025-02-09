USE volcano_eruptions;

DROP TABLE IF EXISTS subregion;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS eruption;
DROP TABLE IF EXISTS volcano;
DROP TABLE IF EXISTS erupted;

CREATE TABLE subregion ( 
  subregion_id int PRIMARY KEY AUTO_INCREMENT,
  subregion_name varchar(100) NOT NULL
);

CREATE TABLE region (
  region_id int PRIMARY KEY AUTO_INCREMENT,
  region_name varchar(100) NOT NULL,
  subregion_id int NOT NULL,
  FOREIGN KEY (subregion_id) REFERENCES subregion (subregion_id)
);

CREATE TABLE country (
  country_id int PRIMARY KEY AUTO_INCREMENT,
  country_name varchar(100) NOT NULL,
  region_id int NOT NULL,
  FOREIGN KEY (region_id) REFERENCES region (region_id)
);

CREATE TABLE locations (
  location_id int PRIMARY KEY AUTO_INCREMENT,
  latitude float,
  longitude float,
  volcano_number int NOT NULL,
  country_id int NOT NULL,
  FOREIGN KEY (country_id) REFERENCES country (country_id)
);

CREATE TABLE eruption (
  eruption_id int PRIMARY KEY AUTO_INCREMENT,
  last_eruption_year int,
  elevation int
);

CREATE TABLE volcano (
  volcano_id int PRIMARY KEY AUTO_INCREMENT,
  volcano_name varchar(100) NOT NULL,
  volcano_number int NOT NULL,
  primary_volcano_type varchar(100),
  eruption_id int NOT NULL,
  FOREIGN KEY (eruption_id) REFERENCES eruption (eruption_id)
);

CREATE TABLE erupted (
  location_id int,
  volcano_id int,
  PRIMARY KEY (location_id, volcano_id),
  FOREIGN KEY (location_id) REFERENCES locations (location_id),
  FOREIGN KEY (volcano_id) REFERENCES volcano (volcano_id)
);
