branch_name Create database College;
 
 use College;
 
 CREATE TABLE branches(
branch_id INT PRIMARY KEY, 
branch_name VARCHAR(50) NOT NULL, 
branch_addr VARCHAR(100) NOT NULL,
contact_number VARCHAR(15) NOT NULL
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    department_id INT,
    position VARCHAR(30) NOT NULL,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(25) NOT NULL,
    department_id INT,
    admission_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

show Tables;

ALTER TABLE branches
ADD created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE departments
ADD created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE employees
ADD created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE students
ADD created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

use college;