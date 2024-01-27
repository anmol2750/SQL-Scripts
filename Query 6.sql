use College;

DROP index idxbranchname ON branches;

CREATE INDEX idx_branch_name ON branches (branch_name);

CREATE INDEX idx_department_name ON departments (department_name);

CREATE INDEX idx_employee_name ON employees (employee_name);

CREATE INDEX idx_student_name ON students (student_name);
