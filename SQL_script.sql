--SQL HOMEWORK 
—Data Engineering
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Dept_emp;
DROP TABLE IF EXISTS Dept_manager;
DROP TABLE IF EXISTS "Employees";
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Titles;

CREATE TABLE "Departments" (
    "dept_no" VARCHAR   PRIMARY KEY,
    "dept_name" VARCHAR   NOT NULL
);

SELECT * FROM "Departments"

CREATE TABLE "Dept_emp" (
    "emp_no" INT   NOT NULL,
	FOREIGN KEY("emp_no")REFERENCES "Employees" ("emp_no"),
    "dept_no" VARCHAR   NOT NULL,
	FOREIGN KEY("dept_no")REFERENCES "Departments" ("dept_no"),
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

SELECT * FROM "Dept_emp"

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
	FOREIGN KEY("dept_no")REFERENCES "Departments" ("dept_no"),
    "emp_no" INT   NOT NULL,
	FOREIGN KEY("emp_no")REFERENCES "Employees" ("emp_no"),
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

SELECT * FROM "Dept_manager"

CREATE TABLE "Employees" (
    "emp_no" INT PRIMARY KEY,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL
);

SELECT * FROM "Employees"

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
	FOREIGN KEY("emp_no")REFERENCES "Employees" ("emp_no"),
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

SELECT * FROM "Salaries" 

CREATE TABLE "Titles" (
    "emp_no" INT   NOT NULL,
	FOREIGN KEY("emp_no")REFERENCES "Employees" ("emp_no"),
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

SELECT * FROM "Titles"



-- Data Analysis
--1)List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT "Employees".emp_no,"Employees".last_name,"Employees".first_name,"Employees".gender,"Salaries".salary
FROM "Salaries"
INNER JOIN "Employees" ON
"Employees".emp_no="Salaries".emp_no;

--2)List employees who were hired in 1986.
SELECT hire_date,first_name,last_name
FROM "Employees"
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';


--3)List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT "Dept_manager".dept_no,"Departments".dept_name,"Dept_manager".emp_no,"Employees".last_name,"Employees".first_name,"Dept_manager".from_date,"Dept_manager".to_date
FROM "Departments" 
INNER JOIN "Dept_manager" ON
"Dept_manager".dept_no="Departments".dept_no
INNER JOIN "Employees" ON
"Employees".emp_no="Dept_manager".emp_no;


--4)List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT "Employees".emp_no,"Employees".last_name,"Employees".first_name,"Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_emp"  ON
"Dept_emp".emp_no="Employees".emp_no
INNER JOIN "Departments" ON
"Departments".dept_no="Dept_emp".dept_no;

--5)List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name,last_name
FROM "Employees"
WHERE first_name='Hercules' AND last_name LIKE 'B%';

--6)List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT "Employees".emp_no,"Employees".last_name,"Employees".first_name,"Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_emp"  ON
"Dept_emp".emp_no="Employees".emp_no
INNER JOIN "Departments" ON
"Departments".dept_no="Dept_emp".dept_no
WHERE dept_name='Sales';

--7)List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT "Employees".emp_no,"Employees".last_name,"Employees".first_name,"Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_emp"  ON
"Dept_emp".emp_no="Employees".emp_no
INNER JOIN "Departments" ON
"Departments".dept_no="Dept_emp".dept_no
WHERE dept_name='Sales' OR dept_name='Development';

--8)In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM "Employees"
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;