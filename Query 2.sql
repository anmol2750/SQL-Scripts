DELIMITER //
CREATE PROCEDURE insertbranch(
IN p_branch_id INT, 
IN p_branch_name VARCHAR(50), 
IN p_branch_addr VARCHAR(100), 
IN p_contact_number VARCHAR(20)
)
BEGIN
INSERT INTO branches(branch_id, branch_name, branch_addr, contact_number)
VALUES(p_branch_id, p_branch_name, p_branch_addr, p_contact_number);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insertdepartment(
IN p_department_id INT, 
IN p_department_name VARCHAR(50), 
IN p_branch_id INT
)
BEGIN
INSERT INTO departments(department_id, department_name, branch_id)
VALUES(p_department_id, p_department_name, p_branch_id);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insertemployees(
IN p_employee_id INT, 
IN p_employee_name VARCHAR(50),
IN p_department_id INT,
IN p_position VARCHAR(50), 
IN p_salary DECIMAL(10,2), 
IN p_hire_date DATE
)
BEGIN
INSERT INTO employees(employee_id, employee_name, department_id, position, salary, hire_date)
VALUES(p_employee_id, p_employee_name, p_department_id, p_position, p_salary, p_hire_date);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insertstudents(
IN p_student_id INT, 
IN p_student_name VARCHAR(50), 
IN p_department_id INT, 
IN p_admission_date DATE
)
BEGIN
INSERT INTO students(student_id, student_name, department_id, admission_date)
VALUES(p_student_id, p_student_name, p_department_id, p_admission_date);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Getbranches()
BEGIN
    SELECT *
	FROM branches;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Getdepartments()
BEGIN
    SELECT *
	FROM departments;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Getemployees()
BEGIN
    SELECT *
	FROM employees;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Getstudents()
BEGIN
    SELECT *
	FROM students;
END //
DELIMITER ;

Drop Procedure if exists Getdepartmentsbybranch;

DELIMITER //
CREATE PROCEDURE Getdepartmentsbybranch(IN p_branch_id INT)
BEGIN
    SELECT *
	FROM departments WHERE p_branch_id = branch_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Getemployeesbydepartment(IN p_department_id INT)
BEGIN
    SELECT *
	FROM employees WHERE p_department_id = department_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Getstudentsbydepartment(IN p_department_id INT)
BEGIN
    SELECT *
	FROM students WHERE p_department_id = department_id;
END //
DELIMITER ;

Drop Procedure if exists  Getstudentsbydepartment;
