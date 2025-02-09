
USE volcano_eruptions;

-- 300 entries
DELETE FROM subregion;

INSERT INTO subregion (subregion_name) 
  SELECT subregion
  FROM sub_data;

-- 300 entries
DELETE FROM region;

INSERT INTO region (region_name, subregion_id)
  SELECT sd.region, s.subregion_id
  FROM ( SELECT DISTINCT region, subregion
         FROM sub_data
  ) sd
  INNER JOIN subregion s
  ON sd.subregion = s.subregion_name;

-- 410 entries
DELETE FROM country;

INSERT INTO country (country_name, region_id)
  SELECT sd.country, rs.region_id
  FROM ( SELECT DISTINCT country, region, subregion
          FROM sub_data
  ) sd
  INNER JOIN ( SELECT DISTINCT r.region_id, r.region_name, s.subregion_name
                FROM region r
                INNER JOIN subregion s 
                ON r.subregion_id = s.subregion_id
  ) rs 
  ON sd.region = rs.region_name
  AND sd.subregion = rs.subregion_name;

-- 2200+ entries
DELETE FROM locations;
  
INSERT INTO locations (latitude, longitude, volcano_number, country_id)
  SELECT sd.latitude, sd.longitude, sd.volcano_number, crs.country_id
  FROM ( SELECT DISTINCT latitude, longitude, volcano_number, country, region, subregion
          FROM sub_data
  ) sd
  INNER JOIN ( SELECT DISTINCT c.country_id, c.country_name, r.region_name, s.subregion_name
              FROM country c
              INNER JOIN region r
              ON c.region_id = r.region_id
              INNER JOIN subregion s
              ON r.subregion_id = s.subregion_id
  ) crs
  ON sd.country = crs.country_name
  AND sd.region = crs.region_name
  AND sd.subregion = crs.subregion_name;

-- 300 entries
DELETE FROM eruption;

INSERT INTO eruption (last_eruption_year, elevation)
SELECT last_eruption_year, elevation
FROM sub_data;

-- 300 entries
DELETE FROM volcano;

INSERT INTO volcano (volcano_name, volcano_number, primary_volcano_type, eruption_id)
  SELECT sd.volcano_name, sd.volcano_number, sd.primary_volcano_type, e.eruption_id
  FROM ( SELECT DISTINCT volcano_name, volcano_number, primary_volcano_type,
                          last_eruption_year, elevation
          FROM sub_data
  ) sd
  INNER JOIN eruption e
  ON sd.last_eruption_year = e.last_eruption_year
  AND sd.elevation = e.elevation;

-- 2200+ entries
DELETE FROM erupted;

INSERT INTO erupted (location_id, volcano_id)
  SELECT l.location_id, v.volcano_id
  FROM locations l
  INNER JOIN volcano v 
  ON l.volcano_number = v.volcano_number;