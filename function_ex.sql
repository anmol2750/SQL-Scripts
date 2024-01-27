Create database function_example;

use function_example;

Create Table customer(cust_id INT PRIMARY KEY, customer_name VARCHAR(30), customer_occupation VARCHAR(30), age INT);

Insert Into customer(cust_id, customer_name, customer_occupation, age)
Values(101, 'Peter', 'Engineer', 32), 
      (102, 'Joseph', 'Developer', 30), 
      (103, 'John', 'Leader', 28), 
      (104, 'Stephen', 'Scientist', 45),
      (105,  'Suzi', 'Carpenter', 26),
      (106, 'Bob', 'Actor', 25);
      
Select * from customer;

DELIMITER $$  
CREATE FUNCTION customer_occupation(age int)   
RETURNS VARCHAR(20)  
DETERMINISTIC  
BEGIN  
    DECLARE customeroccupation VARCHAR(20);  
    IF age > 35 THEN  
        SET customeroccupation = 'Scientist';  
    ELSEIF (age <= 35 AND   
            age >= 30) THEN  
        SET customeroccupation = 'Engineer';  
    ELSEIF age < 30 THEN  
        SET customeroccupation = 'Actor';  
    END IF;  
    RETURN (customeroccupation);  
END$$  
DELIMITER ;

SHOW FUNCTION STATUS WHERE db = 'function_example';

SELECT customer_name, age, customer_occupation(age)  
FROM customer ORDER BY age;

DELIMITER $$  
CREATE PROCEDURE get_customer_detail()  
BEGIN  
    SELECT customer_name, age, customer_occupation(age) FROM customer ORDER BY age;  
END$$  
DELIMITER ;

CALL get_customer_detail();      
