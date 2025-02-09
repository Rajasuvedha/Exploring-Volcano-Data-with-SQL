DROP DATABASE IF EXISTS volcano_eruptions;
CREATE DATABASE volcano_eruptions;

USE volcano_eruptions;

DROP USER IF EXISTS 'user'@'%';
CREATE USER 'user'@'%' IDENTIFIED WITH mysql_native_password BY 'singapore'; 
GRANT ALL ON volcano_eruptions.* TO 'user'@'%';
