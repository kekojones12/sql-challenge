CREATE TABLE departments (
    dept_no VARCHAR(50) NOT NULL,
    dept_name VARCHAR(50),
    PRIMARY KEY (dept_no)
);

CREATE TABLE dep_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(50) NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(50),
    emp_no INTEGER NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES dep_emp(emp_no)
);

CREATE TABLE employees (
    emp_no INTEGER,
    title_id VARCHAR(50),
    birth_date DATE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    sex VARCHAR(2),
    hire_date DATE,
    PRIMARY KEY (emp_no, title_id)
    FOREIGN KEY (emp_no) REFERENCES dep_emp(emp_no)
);

CREATE TABLE salaries (
    emp_no INTEGER,
    salary INTEGER,
    FOREIGN KEY (emp_no) REFERENCES dep_emp(emp_no)
);

CREATE TABLE titles (
    title_id VARCHAR(50),
    title VARCHAR(50)
);

-- Data Cleaning


--DATA ANALYSIS
--list the employee number, last name, first name, sex and salary of each employee
    

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;

--list the first name, last name and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_name, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON employees.emp_no = dept_manager.emp_no
INNER JOIN titles ON titles.title_id = employees.title_id;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dep_emp.emp_no, dep_emp.dept_no, employees.last_name, employees.first_name, departments.dept_name
FROM dep_emp
INNER JOIN departments ON dep_emp.dept_no = departments.dept_no
INNER JOIN employees ON employees.emp_no = dep_emp.emp_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex 
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dep_emp ON dep_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dep_emp.dept_no
WHERE departments.dept_name = 'Sales'
--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dep_emp ON dep_emp.emp_no = employees.emp_no
INNER JOIN departments ON departments.dept_no = dep_emp.dept_no
WHERE departments.dept_name IN ('Sales', 'Development');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS name_count
FROM employees
GROUP BY last_name
ORDER BY name_count DESC;
