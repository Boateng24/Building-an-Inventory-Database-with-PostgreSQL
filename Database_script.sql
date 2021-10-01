ALTER TABLE parts
ALTER COLUMN code SET NOT NULL;

ALTER TABLE parts
ADD UNIQUE (code);

--creating description table which is a column in parts table
CREATE TABLE part_descriptions (
    id int PRIMARY KEY, 
    description TEXT);
INSERT INTO part_descriptions VALUES (1, '5V resistor');
INSERT INTO part_descriptions VALUES (2, '3V resistor');

-- Updating description columns in part table
UPDATE parts
SET description = part_descriptions.description
from part_descriptions
where part_descriptions.id = parts.id
and parts.description IS NULL

ALTER TABLE parts
ALTER COLUMN description SET NOT NULL;

INSERT INTO parts (id, code, manufacturer_id)
VALUES (54, 'V1-009', 9);


-- Implementing a check that ensures price_usd and quantity are NOT NULL
ALTER TABLE reorder_options
ALTER COLUMN price_usd SET NOT NULL;

ALTER TABLE reorder_options
ALTER COLUMN quantity SET NOT NULL;

-- implementing a check to ensure both price_usd and quantity are positive
ALTER TABLE reorder_options
ADD CHECK (price_usd > 0 AND quantity > 0);

-- Adding a check constraints that limits price per unit within the range of USD0.02 and USD25.00
ALTER TABLE reorder_options
ADD CHECK (price_usd/quantity > 0.02 AND price_usd/quantity < 25.00);

-- making id as our primary key
ALTER TABLE parts
ADD PRIMARY KEY (id);

--making part_id a foreign key in render_options table
ALTER TABLE reorder_options
ADD FOREIGN KEY (part_id) 
REFERENCES parts(id);


-- adding a constraints on locations table that checks quantity is always greater than 0.
ALTER TABLE locations
ADD CHECK (qty > 0);

-- making part_id and location columns unique in the locations table
ALTER TABLE locations
ADD UNIQUE(part_id, location);

--making parts_id a foreign key in locations
ALTER TABLE locations
ADD FOREIGN KEY (part_id)
REFERENCES parts(id);

-- making manufacutrer_id a foreign key in parts table
ALTER TABLE parts
ADD FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(id);

-- inserting values in manufactures table
INSERT INTO manufacturers (id, name)
VALUES (11, 'Pip-NNC Industrial');

-- updating parts table
UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id IN (parts.manufacturer_id, 11);

  

SELECT * FROM locations limit 10