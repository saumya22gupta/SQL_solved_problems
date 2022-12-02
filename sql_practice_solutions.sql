SET FOREIGN_KEY_CHECKS=0;
# Exporting metadata from `COMPANY`
DROP DATABASE IF EXISTS `COMPANY`;
CREATE DATABASE `COMPANY`;
USE `COMPANY`;
# TABLE: `COMPANY`.`department`
CREATE TABLE `department` (
  `dname` varchar(15) NOT NULL,
  `dnumber` int(11) NOT NULL,
  `mgr_ssn` char(9) NOT NULL,
  `mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`dnumber`),
  UNIQUE KEY `dname` (`dname`),
  KEY `mgr_ssn` (`mgr_ssn`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`mgr_ssn`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# TABLE: `COMPANY`.`dependent`
CREATE TABLE `dependent` (
  `essn` char(9) NOT NULL,
  `dependent_name` varchar(15) NOT NULL,
  `sex` char(1) DEFAULT NULL,
  `bdate` date DEFAULT NULL,
  `relationship` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`essn`,`dependent_name`),
  CONSTRAINT `dependent_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# TABLE: `COMPANY`.`dept_locations`
CREATE TABLE `dept_locations` (
  `dnumber` int(11) NOT NULL,
  `dlocation` varchar(15) NOT NULL,
  PRIMARY KEY (`dnumber`,`dlocation`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`dnumber`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# TABLE: `COMPANY`.`employee`
CREATE TABLE `employee` (
  `Fname` varchar(15) NOT NULL,
  `Minit` char(1) DEFAULT NULL,
  `Lname` varchar(15) NOT NULL,
  `SSN` char(9) NOT NULL,
  `bdate` date DEFAULT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `Super_ssn` char(9) DEFAULT NULL,
  `Dno` int(11) NOT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# TABLE: `COMPANY`.`project`
CREATE TABLE `project` (
  `pname` varchar(15) NOT NULL,
  `pnumber` int(11) NOT NULL,
  `plocation` varchar(15) DEFAULT NULL,
  `dnum` int(11) NOT NULL,
  PRIMARY KEY (`pnumber`),
  UNIQUE KEY `pname` (`pname`),
  KEY `dnum` (`dnum`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`dnum`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# TABLE: `COMPANY`.`works_on`
CREATE TABLE `works_on` (
  `essn` char(9) NOT NULL,
  `pno` int(11) NOT NULL,
  `hours` decimal(3,1) NOT NULL,
  PRIMARY KEY (`essn`,`pno`),
  KEY `pno` (`pno`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`SSN`),
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`pno`) REFERENCES `project` (`pnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#...done.
USE `COMPANY`;
# Exporting data from `COMPANY`
# Data for table `COMPANY`.`department`:
INSERT INTO `COMPANY`.`department` VALUES ('Headquarters', 1, '888665555', '1981-06-19');
INSERT INTO `COMPANY`.`department` VALUES ('Administration', 4, '987654321', '1995-01-10');
INSERT INTO `COMPANY`.`department` VALUES ('Research', 5, '333445555', '1988-05-22');
# Data for table `COMPANY`.`dependent`:
INSERT INTO `COMPANY`.`dependent` VALUES ('123456789', 'Alice', 'F', '1988-12-30', 'Daughter');
INSERT INTO `COMPANY`.`dependent` VALUES ('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');
INSERT INTO `COMPANY`.`dependent` VALUES ('123456789', 'Michael', 'M', '1988-01-04', 'Son');
INSERT INTO `COMPANY`.`dependent` VALUES ('333445555', ' \"Theodore\"', 'M', '1983-10-25', 'Son');
INSERT INTO `COMPANY`.`dependent` VALUES ('333445555', 'Alice', 'F', '1986-04-05', 'Daughter');
INSERT INTO `COMPANY`.`dependent` VALUES ('333445555', 'Joy', 'F', '1958-03-05', 'Spouse');
INSERT INTO `COMPANY`.`dependent` VALUES ('987654321', 'Abner', 'M', '1942-02-28', 'Spouse');
# Data for table `COMPANY`.`dept_locations`:
INSERT INTO `COMPANY`.`dept_locations` VALUES (1, 'Houston');
INSERT INTO `COMPANY`.`dept_locations` VALUES (4, 'Stafford');
INSERT INTO `COMPANY`.`dept_locations` VALUES (5, ' \"Bellaire\"');
INSERT INTO `COMPANY`.`dept_locations` VALUES (5, ' \"Houston\"');
INSERT INTO `COMPANY`.`dept_locations` VALUES (5, ' \"Sugarland\"');
# Data for table `COMPANY`.`employee`:
INSERT INTO `COMPANY`.`employee` VALUES ('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000.00, '333445555', 5);
INSERT INTO `COMPANY`.`employee` VALUES ('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000.00, '888665555', 5);
INSERT INTO `COMPANY`.`employee` VALUES ('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000.00, '333445555', 5);
INSERT INTO `COMPANY`.`employee` VALUES ('Richard', 'K', 'Marini', '653298653', '1962-12-30', '98 Oak Forest, Katy, TX', 'M', 37000.00, '888665555', 4);
INSERT INTO `COMPANY`.`employee` VALUES ('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humboldt, TX', 'M', 38000.00, '333445555', 5);
INSERT INTO `COMPANY`.`employee` VALUES ('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000.00, '', 1);
INSERT INTO `COMPANY`.`employee` VALUES ('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000.00, '888665555', 4);
INSERT INTO `COMPANY`.`employee` VALUES ('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000.00, '987654321', 4);
INSERT INTO `COMPANY`.`employee` VALUES ('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000.00, '987654321', 4);
# Data for table `COMPANY`.`project`:
INSERT INTO `COMPANY`.`project` VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO `COMPANY`.`project` VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO `COMPANY`.`project` VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO `COMPANY`.`project` VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO `COMPANY`.`project` VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO `COMPANY`.`project` VALUES ('NewBenefits', 30, 'Stafford', 4);
# Data for table `COMPANY`.`works_on`:
INSERT INTO `COMPANY`.`works_on` VALUES ('123456789', 1, 32.5);
INSERT INTO `COMPANY`.`works_on` VALUES ('123456789', 2, 7.5);
INSERT INTO `COMPANY`.`works_on` VALUES ('333445555', 2, 10.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('333445555', 3, 10.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('333445555', 10, 10.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('333445555', 20, 10.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('453453453', 1, 20.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('453453453', 2, 20.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('666884444', 3, 40.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('888665555', 20, 0.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('987654321', 20, 15.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('987654321', 30, 20.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('987987987', 10, 35.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('987987987', 30, 5.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('999887777', 10, 10.0);
INSERT INTO `COMPANY`.`works_on` VALUES ('999887777', 30, 30.0);
#...done.
SET FOREIGN_KEY_CHECKS=1;


#1.	Provide the complete info on all employees.
select *
from employee;

#2. What is the count of all employees?
select count(*) as employee_count
from employee;

#3. What is the count of all departments?
select count(*) as department_count
from department;

#4. Names of employees that work for Department 
select Fname,  Lname
from employee
where Dno=4;

#5. Name of projects in Sugarland
select pname
from project
where plocation='Sugarland';

#6. Employees name and hours information
select Fname, Lname, sum(hours) as Total_Hours
from works_on, employee
where essn=ssn
group by Fname, Lname;

#7. Employees name that don't work on Project ProductX
select Fname, Lname 
from employee,project
where NOT pname='ProductX' and dnum=dno
group by Fname, Lname;

#8. Who worked the most hours to least hours?
select Fname, Lname, SUM(hours) as Hours_Worked
from employee, works_on
where essn=ssn
group by Fname, Lname
order by Hours_Worked DESC;

#9. Who worked the most hours in Research dept?
select Fname, Lname, SUM(hours) as Hours_Worked,dname
from employee, department,works_on
where dnumber=dno and essn=ssn and dname='Research'
group by Fname, Lname
order by Hours_Worked;

#10. Names of dependents for person who worked most hours in Research dept
select Fname, Lname, dependent_name, SUM(hours) as Hours_Worked,dname
from employee, department,works_on, dependent
where dnumber=dno and works_on.essn=ssn and dependent.essn=ssn and dname='Research'
group by Fname, Lname, dependent_name
order by Hours_Worked;

#11. Provide the name of projects in either Department number 4 or 5
select pname, dnum
from project 
where dnum IN (4,5);

#12. Provide the names of employees with either a son or wife dependent
select Fname, Lname, dependent_name, relationship
from employee, dependent
where essn=ssn and (relationship ='son' or (dependent.sex='F' and relationship='spouse'));

#13. Provide the names of employees with salary between $5k and $30k
select Fname, Lname, Salary
from employee
where salary between 5000 and 30000;

#14. Provide the names of employees that worked between 30 and 40 hours
select Fname, Lname, SUM(hours) as Hours_Worked
from employee, works_on
where essn=ssn
group by Fname, Lname
having Hours_Worked between 30 and 40;

#15. Provide the department name and project name for projects in Houston, Sugarland, or Stafford
select d.dname, p.pname
from department d inner join project p
on d.dnumber=p.dnum
where p.plocation IN ('Houston','Sugarland','Stafford');

#16. Provide employees with A in First Name
select Fname, Lname
from employee
where Fname LIKE '%A%';

#17. Provide employees with Last Name that does not begin with W
select Fname, Lname
from employee
where NOT Lname  LIKE 'W%';

#18. Provide employees with ‘a’ as the second letter
select Fname, Lname
from employee 
where Fname LIKE '_a%';

#19. What is the average hours worked by employees in the Research department?
select d.dname,AVG(w.hours)
from works_on w inner join project p
on w.pno=p.pnumber inner join department d
on p.dnum=d.dnumber
where d.dname='Research'
group by d.dname;

#20. What is the total salary for employees that worked on either Product Z or X?
select p.pname, sum(salary)
from employee e inner join project p
on e.dno=p.dnum
where p.pname IN ('ProductX','ProductZ')
group by p.pname;

#21. Name of employees who first name start with A and order last name alphabetically
select Fname, Lname
from employee
where Fname LIKE 'A%'
order by Lname;

#22. Name of employees in Department number 5 and salary ordered largest to smallest
select Fname, Lname
from employee
where dno=5
order by salary desc;

#23. Sort employee birthdates from oldest to newest and then sort first names in alphabetical order
select Fname, Lname, bdate
from employee
order by bdate desc,Fname;

#24. Sort employee salaries by largest to smallest and employee last names alphabetically
select Fname, Lname, salary
from employee
order by salary desc, Lname;

#25. How many male and female employees are there?
select sex, count(sex) as Total_Count
from employee
group by sex;

#26. How many male and female dependents are there?
select sex, count(sex) as Total_Count
from dependent
group by sex;

#27. How many projects are there for each location?
select plocation, count(*) as Total_Project
from project
group by plocation;

#28. Identify the number of projects in each location and order by most to least projects
select plocation, count(*) as Total_Project
from project
group by plocation
order by Total_Project DESC;

#29. Identify the number of male and female employees and order from most to least
select sex, count(sex) as Total_Count
from employee
group by sex
order by Total_Count DESC;

#30. How many male and female spouses are there?
select sex, count(*) as Total_Count
from dependent
where relationship='Spouse'
group by sex;

#31. What departments pay over $50,000 to employees?
select dname, sum(salary) as Total_Salary
from employee,department
where dno=dnumber
group by dname
having Total_Salary>50000;

#32. Provide the employee SSN and number of dependents for employees with more than 1 dependent
select essn, count(*) as Number
from dependent
group by essn
having Number>1;

#33. Provide the project locations with more than 1 project
select plocation, count(pname) as Number
from project
group by plocation
having Number>1;

#34. Get the name, birthdate, sex, and salary for each employee.
select Fname, Lname, bdate,sex,salary
from employee;

#34.a.	Modify query to get only employees born after 1960
select Fname, Lname, bdate,sex,salary
from employee
where year(bdate)>1960;

#34.b. Modify query to group by sex for those born after 1960 (remove name and salary)
select sex, count(bdate)
from employee
where year(bdate)>1960
group by sex;

#34.c. Modify query to get the average salary for men and women employees born after 1960
select sex, avg(salary)
from employee
where year(bdate)>1960
group by sex;

#34.d. Modify query to get the average salary for men and women employees born after 1960 and with an average over $15,000 salary 
select sex, avg(salary) as Average_Salary
from employee
where year(bdate)>1960
group by sex
having Average_Salary>15000
order by Average_Salary;

