DELIMITER //
CREATE PROCEDURE GetUserInfo(
IN p_username VARCHAR(50),
IN p_email VARCHAR(50)
)
BEGIN
SELECT *
FROM  user
WHERE username = p_username
AND email = p_email;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE SaveUserInfo(
IN p_username VARCHAR(50),
IN p_email VARCHAR(50),
IN p_firstname VARCHAR(50),
IN p_lastname VARCHAR(50),
IN p_password VARCHAR(50)
)
BEGIN 
INSERT INTO user (username, email, firstname, lastname, password)
VALUES (p_username, p_email, p_firstname, p_lastname, p_password);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetEmail(
IN p_email VARCHAR(50)
)
BEGIN
SELECT email
FROM user
WHERE email = p_email;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetPassword(
IN p_password VARCHAR(50)
)
BEGIN
SELECT password
FROM user
WHERE password = p_password;
END //
DELIMITER ;  

DELIMITER //
CREATE PROCEDURE GetUser(
IN p_email VARCHAR(50),
IN p_password VARCHAR(50)
)
BEGIN
SELECT *
FROM  user
WHERE email = p_email
AND password = p_password;
END //
DELIMITER ;
