Create table Department(
	DepartmentID int PRIMARY KEY,
	DepartmentName varchar(255) NOT NULL
);

Create table Location(
	LocationID int PRIMARY KEY,
	LocationName varchar(255) NOT NULL
);

Create table Employee(
	EmployeeID int PRIMARY KEY NOT NULL,
	Name varchar(255) NOT NULL,
	DOB Date NOT NULL,
	City varchar(255) NOT NULL,
	MobileNo decimal(10) NOT NULL,
	DepartmentID int FOREIGN KEY REFERENCES Department(DepartmentID),
	LocationID int FOREIGN KEY REFERENCES Location(LocationID)
);

Create table EmployeeDetails(
	EmployeeID int PRIMARY KEY NOT NULL,
	Designation varchar(255) NOT NULL,
	DateOfJoin Date NOT NULL,
	DateOfResignation Date,
	FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
);

INSERT INTO Department Values(1, 'Technology');
INSERT INTO Department Values(2, 'Human Resource');
INSERT INTO Department Values(3, 'Finance');
INSERT INTO Department Values(4, 'Technology Support');
INSERT INTO Department Values(5, 'Business Development');
INSERT INTO Department Values(6, 'Administration');

select * from department;

INSERT INTO Location values(1, 'Mangalore');
INSERT INTO Location values(2, 'Bangalore');
INSERT INTO Location values(3, 'Hyderabad');

select * from Location;

INSERT INTO Employee values(1, 'Alice', '1995-05-08', 'Mangalore', 9988776655, 1, 1);
INSERT INTO Employee values(2, 'Bob', '1990-01-03', 'Mysore', 2233445566, 1, 1);
INSERT INTO Employee values(3, 'Charlie', '1985-08-10', 'Chennai', 2211334455, 1, 2);
INSERT INTO Employee values(4, 'Daniel', '1987-07-01', 'Hyderabad', 9876543210, 2, 3);
INSERT INTO Employee values(5, 'Eve', '1996-09-02', 'Bangalore', 1234567890, 3, 3);

select * from Employee;

INSERT INTO EmployeeDetails(EmployeeID, Designation, DateOfJoin) values(1, 'Software Engineer', '2017-01-01');
INSERT INTO EmployeeDetails(EmployeeID, Designation, DateOfJoin) values(2, 'Senior Software Engineer', '2016-05-01');
INSERT INTO EmployeeDetails(EmployeeID, Designation, DateOfJoin) values(3, 'Tech Lead', '2015-06-06');
INSERT INTO EmployeeDetails(EmployeeID, Designation, DateOfJoin) values(4, 'Senior HR', '2018-01-01');
INSERT INTO EmployeeDetails(EmployeeID, Designation, DateOfJoin, DateOfResignation) values(5, 'Accountant', '2017-01-01', '2019-01-01');

select * from EmployeeDetails;

/*
* Procedure to display all the Employees with details:
*/

Create Procedure displayEmployeeDetails
AS
select e.EmployeeID, e.Name, e.dob, e.City, e.MobileNo, e.DepartmentID, e.LocationID,
ed.Designation, ed.DateOfJoin, ed.DateOfResignation 
from Employee as e 
inner  join EmployeeDetails as ed 
on e.EmployeeID = ed.EmployeeID;


exec displayEmployeeDetails;

/*
* Procedure to display Employee based on Location:
*/

Create Procedure displayEmployeeLocation @LocationName varchar(255)
AS
Select * from Employee as e, Location as l
Where l.LocationName = @LocationName
and e.LocationID = l.LocationID;

EXEC displayEmployeeLocation @LocationName = 'Hyderabad';

/*
* Procedure to display Employee based on Department:
*/

Create Procedure displayEmployeeDepartment @DepartmentName varchar(255)
AS
Select * from Employee as e, Department as d
Where d.DepartmentName = @DepartmentName
and e.DepartmentID = d.DepartmentID;

EXEC displayEmployeeDepartment @DepartmentName = 'Technology';

select * from Department;

/*
* Procedure to display Employee based on Department and Location: 
*/

Create Procedure displayEmployeeDepLoc @DepartmentName varchar(255), @LocationName varchar(255)
AS
Select * from Employee as e, Department as d, Location as l
Where d.DepartmentName = @DepartmentName
and l.LocationName = @LocationName
and l.LocationID = e.LocationID
and d.DepartmentID = e.DepartmentID;

exec displayEmployeeDepLoc @DepartmentName = 'Technology', @LocationName = 'Mangalore';

Create Procedure upcomingBirthday
AS

DECLARE @Days INT;
SET @Days = 5;

Select * from Employee
Where DATEADD(year, DATEPART(Year, GETDATE()) - DATEPART(year, DOB), DOB)
BETWEEN CONVERT(DATE, GETDATE())
AND CONVERT(DATE, GETDATE() + @Days);

exec upcomingBirthday;

-- Procedure to display Employee details in a given range of Employee ID:

Create Procedure displayEmployeeRange @from int, @to int
AS
select e.EmployeeID, e.Name, e.dob, e.City, e.MobileNo, e.DepartmentID, e.LocationID,
ed.Designation, ed.DateOfJoin, ed.DateOfResignation 
from Employee as e 
inner  join EmployeeDetails as ed 
on e.EmployeeID = ed.EmployeeID
WHERE e.EmployeeId between @from and @to;

exec displayEmployeeRange @from = 2, @to = 4;  -- Range of employee id