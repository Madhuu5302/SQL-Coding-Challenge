CREATE DATABASE SCHOOL;
USE SCHOOL;
-- CourseMaster table
CREATE TABLE CourseMaster (
    CID INT PRIMARY KEY,
    CourseName VARCHAR(40) NOT NULL,
    Category CHAR(1) NULL CHECK (Category IN ('B', 'M', 'A')),
    Fee SMALLMONEY NOT NULL CHECK (Fee >= 0)
);

-- StudentMaster table
CREATE TABLE StudentMaster (
    SID TINYINT PRIMARY KEY,
    StudentName VARCHAR(40) NOT NULL,
    Origin CHAR(1) NOT NULL CHECK (Origin IN ('L', 'F')),
    Type CHAR(1) NOT NULL CHECK (Type IN ('U', 'G'))
);

-- EnrollmentMaster table
CREATE TABLE EnrollmentMaster (
    CID INT NOT NULL,
    SID TINYINT NOT NULL,
    DOE DATETIME NOT NULL,
    FWF BIT NOT NULL,
    Grade CHAR(1) CHECK (Grade IN ('O', 'A', 'B', 'C')),
    PRIMARY KEY (CID, SID),
    FOREIGN KEY (CID) REFERENCES CourseMaster(CID),
    FOREIGN KEY (SID) REFERENCES StudentMaster(SID)
);
--Inserting data into Coursemaster table
INSERT INTO CourseMaster VALUES (1, 'Java', 'A', 100.00);
INSERT INTO CourseMaster VALUES (2, 'SQL', 'B', 80.00);
INSERT INTO CourseMaster VALUES (3, 'Python', 'A', 120.00);
INSERT INTO CourseMaster VALUES (4, 'Web Development', 'M', 90.00);
INSERT INTO CourseMaster VALUES (5, 'Data Science', 'A', 150.00);
INSERT INTO CourseMaster VALUES (6, 'Networking', 'B', 85.00);
INSERT INTO CourseMaster VALUES (7, 'Machine Learning', 'A', 130.00);
SELECT * FROM CourseMaster;

--Inserting data into StudentMaster Table
INSERT INTO StudentMaster VALUES (1, 'John Doe', 'L', 'U');
INSERT INTO StudentMaster VALUES (2, 'Jane Smith', 'F', 'G');
INSERT INTO StudentMaster VALUES (3, 'Michael Johnson', 'L', 'U');
INSERT INTO StudentMaster VALUES (4, 'Emily White', 'F', 'G');
INSERT INTO StudentMaster VALUES (5, 'Robert Brown', 'L', 'U');
INSERT INTO StudentMaster VALUES (6, 'Sophia Miller', 'F', 'G');
INSERT INTO StudentMaster VALUES (7, 'William Davis', 'L', 'U');
INSERT INTO StudentMaster VALUES (8, 'Olivia Jones', 'F', 'G');
INSERT INTO StudentMaster VALUES (9, 'Daniel Wilson', 'L', 'U');
INSERT INTO StudentMaster VALUES (10, 'Ava Taylor', 'F', 'G');
SELECT * FROM StudentMaster;

--Inserting data into EnrollmentMaster table
INSERT INTO EnrollmentMaster VALUES (1, 1, '2020-01-15', 0, 'A');
INSERT INTO EnrollmentMaster VALUES (1, 2, '2020-01-20', 1, 'O');
INSERT INTO EnrollmentMaster VALUES (2, 3, '2020-02-10', 0, 'A');
INSERT INTO EnrollmentMaster VALUES (7, 4, '2020-03-05', 1, 'C');
INSERT INTO EnrollmentMaster VALUES (4, 5, '2020-04-02', 0, 'B');
INSERT INTO EnrollmentMaster VALUES (5, 6, '2020-05-15', 1, 'O');
INSERT INTO EnrollmentMaster VALUES (6, 7, '2020-06-08', 0, 'C');
INSERT INTO EnrollmentMaster VALUES (3, 8, '2020-07-12', 1, 'O');
INSERT INTO EnrollmentMaster VALUES (4, 9, '2020-08-18', 0, 'A');
INSERT INTO EnrollmentMaster VALUES (2, 10, '2020-09-25', 1,'O');
SELECT * FROM EnrollmentMaster;
--Q1
SELECT C.CourseName, COUNT(E.SID) AS TotalForeignStudents
FROM CourseMaster C
JOIN EnrollmentMaster E ON C.CID = E.CID
JOIN StudentMaster S ON E.SID = S.SID
WHERE S.Origin = 'F'
GROUP BY C.CourseName
HAVING COUNT(E.SID) > 0;


--Q2
SELECT S.StudentName FROM StudentMaster S
WHERE S.SID NOT IN (SELECT E.SID FROM EnrollmentMaster E JOIN CourseMaster C ON E.CID = C.CID WHERE C.CourseName = 'Java');

--Q3
SELECT C.CourseName FROM CourseMaster C
JOIN EnrollmentMaster E ON C.CID = E.CID
JOIN StudentMaster S ON E.SID = S.SID
WHERE C.Category = 'A' AND S.Origin = 'F'
GROUP BY C.CourseName
ORDER BY COUNT(E.SID) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

--Q4
SELECT DISTINCT S.StudentName
FROM StudentMaster S
JOIN EnrollmentMaster E ON S.SID = E.SID
JOIN CourseMaster C ON E.CID = C.CID
WHERE C.Category = 'B' AND MONTH(E.DOE) = MONTH(GETDATE());

--Q5
SELECT DISTINCT S.StudentName
FROM StudentMaster S
JOIN EnrollmentMaster E ON S.SID = E.SID
JOIN CourseMaster C ON E.CID = C.CID
WHERE S.Type = 'U' AND S.Origin = 'L' AND C.Category = 'B' AND E.Grade = 'C';

--Q6
SELECT C.CourseName
FROM CourseMaster C
LEFT JOIN EnrollmentMaster E ON C.CID = E.CID AND MONTH(E.DOE) = 5 AND YEAR(E.DOE) = 2020
WHERE E.CID IS NULL;

--Q7
SELECT
	C.CourseName,
	COUNT(E.SID) AS NumberOfEnrollments,
	CASE
    	WHEN COUNT(E.SID) > 50 THEN 'High'
    	WHEN COUNT(E.SID) >= 20 AND COUNT(E.SID) <= 50 THEN 'Medium'
    	ELSE 'Low'
	END AS Popularity
FROM CourseMaster C
LEFT JOIN EnrollmentMaster E ON C.CID = E.CID
GROUP BY C.CourseName;

--Q9
SELECT S.StudentName
FROM StudentMaster S
JOIN EnrollmentMaster E ON S.SID = E.SID
JOIN CourseMaster C ON E.CID = C.CID
WHERE S.Origin = 'L' AND C.Category = 'B'
GROUP BY S.StudentName
HAVING COUNT(DISTINCT C.CID) = 1;

--Q10
SELECT C.CourseName
FROM CourseMaster C
JOIN EnrollmentMaster E ON C.CID = E.CID
GROUP BY C.CourseName
HAVING COUNT(DISTINCT E.SID) = (SELECT COUNT(*) FROM StudentMaster);

--Q11
SELECT S.StudentName
FROM StudentMaster S
JOIN EnrollmentMaster E ON S.SID = E.SID
WHERE E.FWF = 1 AND E.Grade = 'O';

--Q12
SELECT DISTINCT S.StudentName
FROM StudentMaster S
JOIN EnrollmentMaster E ON S.SID = E.SID
JOIN CourseMaster C ON E.CID = C.CID
WHERE S.Origin = 'F' AND S.Type = 'G' AND C.Category = 'B' AND E.Grade = 'C';

--Q13
SELECT C.CourseName, COUNT(E.SID) AS TotalEnrollments
FROM CourseMaster C
JOIN EnrollmentMaster E ON C.CID = E.CID
WHERE MONTH(E.DOE) = MONTH(GETDATE()) AND YEAR(E.DOE) = YEAR(GETDATE())
GROUP BY C.CourseName;





