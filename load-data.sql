USE volcano_eruptions;

DROP TABLE IF EXISTS sub_data;

CREATE TABLE sub_data (
  volcano_number int,
  volcano_name varchar(100),
  primary_volcano_type varchar(255),
  last_eruption_year int,
  country varchar(100),
  region varchar(100),
  subregion varchar(128), 
  latitude float, 
  longitude float,
  elevation int, 
  row_num int
);


LOAD DATA INFILE '/home/coder/project/midterm/volcano-eruptions/data/sub-volcano-eruptions.csv'
INTO TABLE sub_data
FIELDS TERMINATED BY ','
ENCLOSED BY '' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
