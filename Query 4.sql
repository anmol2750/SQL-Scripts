SELECT b.branch_id , b.branch_name , COUNT(e.employee_id) AS Total_no_of_employees FROM branches as b 
INNER JOIN departments as d ON b.branch_id = d.branch_id
INNER JOIN employees AS e ON d.department_id = e.department_id
Group By b.branch_id, b.branch_name;

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS Total_no_of_employees FROM departments as d
LEFT JOIN employees as e ON d.department_id = e.department_id
GROUP By d.department_id, d.department_name;

SELECT * from branches 
ORDER BY branch_name;

SELECT * from branches 
ORDER BY branch_name DESC;

CREATE INDEX idx_branch_ref_id ON departments(branch_id);

CREATE INDEX idx_department_ref_id ON employees(department_id);

