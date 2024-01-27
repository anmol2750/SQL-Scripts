Create database fruitshop;

use fruitshop;

CREATE TABLE units (
unit_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
unit_name VARCHAR(10) NOT NULL,
date_entered DATETIME NOT NULL,
date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (unit_id)
);

CREATE TABLE fruit (
fruit_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
fruit_name VARCHAR(25) NOT NULL, 
inventory SMALLINT UNSIGNED NOT NULL,
unit_id TINYINT UNSIGNED NOT NULL,
date_entered DATETIME NOT NULL,
date_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (fruit_id),
CONSTRAINT fkFruitUnits FOREIGN KEY (unit_id) REFERENCES units (unit_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

DESCRIBE fruit;

INSERT INTO units(unit_id, unit_name, date_entered, date_updated) 
VALUES (1,'Piece','2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (2,'Kilogram','2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (3,'Gram','2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (4,'Pound','2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (5,'Ounce','2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (6,'Bunch','2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (7,'Container','2015-02-15 10:30:00','2015-02-15 10:30:00');
       
INSERT INTO fruit 
VALUES (1,'Apple',10,1,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (2,'Orange',5,2,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (3,'Banana',20,6,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (4,'Watermelon',10,1,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (5,'Grapes',15,6,'2015-02-15 10:30:00','2015-02-15 10:30:00'),
       (6,'Strawberry',12,7,'2015-02-15 10:30:00','2015-02-15 10:30:00');
       
select * from units;

select * from fruit;

UPDATE fruit
SET unit_id = 2
WHERE fruit_id = 1;

UPDATE fruit
SET unit_id = 2
WHERE fruit_name = 'Apple' AND unit_id = 1;

DELIMITER //

CREATE PROCEDURE check_fruit_stock(p_fruit SMALLINT)
BEGIN
	SELECT 
		fruit.fruit_name, 
		fruit.inventory, 
		units.unit_name
	FROM 
		fruit INNER JOIN units ON
		fruit.unit_id = units.unit_id
	WHERE 
		fruit.fruit_id = p_fruit;
END //

DELIMITER ;

CALL check_fruit_stock(1);

DELIMITER //

CREATE PROCEDURE check_fruit_stock_level(
	IN p_fruit_id SMALLINT(5),
    OUT p_stock_level VARCHAR(6))
BEGIN
	DECLARE stock_number SMALLINT;
    
	SELECT 
		fruit.inventory into stock_number
	FROM 
		fruit INNER JOIN units ON
		fruit.unit_id = units.unit_id
	WHERE 
		fruit.fruit_id = p_fruit_id;
        
	IF stock_number > 10 THEN
		SET p_stock_level = 'High';
    ELSEIF (stock_number <= 10 AND stock_number >= 5) THEN
		SET p_stock_level = 'Medium';
    ELSEIF (stock_number < 5) THEN
		SET p_stock_level = 'Low - Please Replace Now!';
	END IF;
    
END //

DELIMITER ;

CALL check_fruit_stock_level(1, @stock_level);
select @stock_level;
