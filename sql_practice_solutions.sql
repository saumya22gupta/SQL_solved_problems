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

