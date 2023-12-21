CREATE DATABASE SISDB;
USE SISDB;

-- STUDENTS TABLE
CREATE TABLE Students(
student_ID INT PRIMARY KEY,
first_Name VARCHAR(25),
last_Name VARCHAR(25),
date_of_Birth DATE,
email VARCHAR(35),
phone_Number CHAR(10)
);
-- TEACHER TABLE
CREATE TABLE Teacher(
teacher_ID INT PRIMARY KEY,
first_Name VARCHAR(25),
last_Name VARCHAR(10),
email VARCHAR(35));
-- COURSES TABLE
CREATE TABLE Courses(
course_ID INT PRIMARY KEY,
course_Name VARCHAR(20),
credits INT,
teacher_ID INT,
FOREIGN KEY(teacher_ID) References teacher(teacher_ID)
);
-- ENROLLMENTS TABLE
CREATE TABLE Enrollments(
enrollment_ID INT PRIMARY KEY,
student_ID INT,
course_ID INT NOT NULL,
enrollment_Date DATE,
CONSTRAINT student_id FOREIGN KEY(student_ID) References students(student_ID),
CONSTRAINT course_id FOREIGN KEY(Course_ID) References courses(course_ID)
);
ALTER TABLE Enrollments
DROP CONSTRAINT IF EXISTS student_id;
ALTER TABLE Enrollments ADD CONSTRAINT student_id FOREIGN KEY(Student_ID) References Students(Student_ID) ON DELETE CASCADE;
ALTER TABLE Enrollments
DROP CONSTRAINT IF EXISTS course_id;
ALTER TABLE Enrollments ADD CONSTRAINT course_id FOREIGN KEY(Course_ID) References Courses(Course_ID) ON DELETE CASCADE;

-- PAYMENTS TABLE
CREATE TABLE Payments(
payments_ID INT PRIMARY KEY,
student_ID INT,
amount FLOAT,
payment_date DATE,
CONSTRAINT student_id_payments FOREIGN KEY(student_ID) References Students(student_ID) ON DELETE CASCADE
);

-- INSERT RECORDS INTO STUDENTS
INSERT INTO Students
VALUES(100,'ADHI','S','2002-03-06','adhis@gmail.com',9360297317),
(101,'PRIYA','M','2002-03-05','priya200236@gmail.com',9567567123),
(102,'SARANYA','S','2000-06-15','saranya@gmail.com',9898987676),
(103,'SWATHI','S','1998-07-16','swathi@gmail.com',9564321231),
(104,'ASHWIN','V','2003-01-08','ashwin56@@gmail.com',9087654321),
(105,'AKASH','V','2004-06-18','akash77@gmail.com',7890654321),
(106,'MONICA','V','2003-07-19','monicav@gmail.com',6789051423),
(107,'KARTHICK','V','2002-12-30','anjana456@gmail.com',9878906781),
(108,'MANISH','R','2005-12-08','manishsri32@gmail.com',9898987654),
(109,'RISHI','S','2004-09-06','rishiuy67@gmail.com',9876534201);
SELECT * FROM Students;
-- INSERT RECORDS INTO TEACHER
INSERT INTO Teacher
VALUES(1000,'Ranjini','A','ranjani76yu@gmail.com'),
(1001,'Bala','C','bala67@gmail.com'),
(1002,'Anjali','S','anjalihy23@gmail.com'),
(1003,'Ragini','I','ragee@gmail.com'),
(1004,'Dravid','T','dravid989@gmail.com'),
(1005,'Nathan','M','Nathanrgt@gmail.com'),
(1006,'Parvesh','I','parveshty56@gmail.com'),
(1007,'Praveen','G','praveen98@gmail.com'),
(1008,'Uma','P','uma67@gmail.com'),
(1009,'Tanav','O','tanav98@gmail.com');
SELECT * FROM Teacher;
-- INSERT RECORDS INTO COURSES
INSERT INTO Courses
VALUES(01,'Java',3,1000),
(02,'C',2,1001),
(03,'Python',4,1002),
(04,'Java',3,1000),
(05,'SQL',2,1003),
(06,'Python',4,1002),
(07,'Java',4,1004),
(08,'C#',2,1005),
(09,'C',2,1001),
(10,'Machine learning',3,1004);
SELECT * FROM Courses;
-- INSERT RECORDS INTO ENROLLMENTS
INSERT INTO Enrollments
VALUES(1000,100,01,'2023-06-28'),
(1001,101,02,'2023-06-19'),
(1002,102,03,'2023-07-13'),
(1003,103,08,'2023-06-16'),
(1004,104,05,'2023-07-03'),
(1005,103,06,'2023-06-29'),
(1006,106,05,'2023-05-09'),
(1007,107,08,'2023-05-25'),
(1008,105,05,'2023-07-01'),
(1009,109,10,'2023-06-10');
SELECT * FROM Enrollments;

-- INSERT RECORDS INTO PAYMENTS
INSERT INTO Payments
VALUES(1000,100,20000.00,'2023-12-09'),
(1001,101,15009.00,'2023-12-19'),
(1002,102,18000.00,'2023-11-30'),
(1003,103,19800.00,'2023-12-10'),
(1004,104,17600.00,'2023-11-29'),
(1005,105,13500.00,'2023-12-05'),
(1006,106,14000.00,'2023-11-30'),
(1007,107,17800.00,'2023-12-01'),
(1008,108,19000.00,'2023-12-02'),
(1009,109,17500.00,'2023-11-29');
SELECT * FROM Payments;

--q1
INSERT INTO Students
VALUES(111,'John','Doe','1995-08-15','john.doe@example.com',1234567890);
SELECT * FROM Students;

--q2
INSERT INTO Enrollments
VALUES(1010,(SELECT Student_ID FROM Students S WHERE S.First_Name ='ADHI' AND S.Last_Name='S'),
(SELECT Course_ID FROM Courses C WHERE C.Course_Name ='C#'),
'2023-06-30');
SELECT * FROM Enrollments;

--Q3
UPDATE Teacher
SET email = 'bala98@gmail.com'
WHERE teacher_ID = 1001;
SELECT * FROM Teacher;

--Q4
DELETE FROM Enrollments
WHERE student_ID = 103 AND course_ID = 08;
SELECT * FROM Enrollments;

--Q5
UPDATE Courses
SET teacher_ID = (SELECT teacher_ID FROM Teacher WHERE first_Name = 'Anjali' AND last_Name='S') 
WHERE course_ID = 07;
SELECT * FROM Courses;

--Q6
DELETE FROM Students
WHERE student_ID = 100;
SELECT * FROM Students;
SELECT * FROM Enrollments;

--Q7
UPDATE Payments
SET amount = 18900
WHERE student_ID = 104;
SELECT * FROM PAYMENTS;

--JOINS
--Q1
SELECT S.first_Name, S.last_Name, S.student_ID AS Stud_Name, SUM(P.AMOUNT) AS Total_amt
FROM Students AS S
INNER JOIN Payments AS P
ON S.student_ID = P.student_ID
WHERE S.student_ID = 105
GROUP BY S.first_Name, S.last_Name,S.student_ID;

--Q2
SELECT C.Course_Name AS List_of_Courses,Count(E.Student_ID) AS No_of_Students
FROM Courses C LEFT JOIN Enrollments E ON C.Course_ID=E.Course_ID
GROUP BY C.course_Name;

--Q3
SELECT S.First_Name, S.last_name, E.ENROLLMENT_ID
FROM Students S LEFT JOIN Enrollments E 
ON S.student_ID = E.student_ID
WHERE E.student_ID = null;

--Q4
SELECT S.First_name, S.Last_name, C.Course_name
FROM Students S
JOIN Enrollments E ON S.student_ID = E.student_ID
JOIN Courses C ON E.course_ID = C.course_ID;
SELECT * FROM Students;

--Q5
SELECT T.FIRST_NAME, T.LAST_NAME, C.COURSE_NAME
FROM TEACHER T
JOIN Courses C ON T.teacher_ID = C.teacher_ID;

--Q6
SELECT S.first_Name, S.last_Name, E.enrollment_Date
FROM Students S
LEFT JOIN Enrollments E ON S.student_ID = E.student_ID
JOIN Courses C ON E.course_ID = C.course_ID
WHERE C.course_Name = 'SQL';

--Q7
SELECT S.first_Name, S.last_Name, P.amount
FROM Students S
LEFT JOIN Payments P ON S.student_ID = P.student_ID
WHERE P.student_ID IS NULL;

--Q8
SELECT C.course_Name
FROM Courses C
LEFT JOIN Enrollments E
ON C.course_ID = E.course_ID
WHERE E.course_ID IS NULL;

--Q9
SELECT e1.student_id, s.first_name, s.last_name
FROM Enrollments e1
JOIN Students s ON e1.student_id = s.student_id
WHERE e1.student_id IN (
    SELECT student_id
    FROM Enrollments
    GROUP BY student_id
    HAVING COUNT(DISTINCT course_id) > 1
);

--Q10
SELECT T.first_Name, T.last_Name
FROM Teacher T
LEFT JOIN Courses C
ON T.teacher_ID = C.teacher_ID
WHERE C.teacher_ID IS NULL;

--SUBQUERIES
--Q1
SELECT
    course_id,
    course_name,
    AVG(enrollment_count) AS average_students_enrolled
FROM (
    SELECT
        c.course_id,
        c.course_name,
        COUNT(DISTINCT e.student_id) AS enrollment_count
    FROM Courses c
    LEFT JOIN Enrollments e ON c.course_id = e.course_id
    GROUP BY c.course_id, c.course_name
) AS CourseEnrollments
GROUP BY course_id, course_name;
--Q2
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    p.amount AS highest_payment_amount
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE p.amount = (SELECT MAX(amount) FROM Payments);
--Q3
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS enrollment_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(e.student_id) = (
    SELECT MAX(enrollment_count)
    FROM (
        SELECT course_id, COUNT(student_id) AS enrollment_count
        FROM Enrollments
        GROUP BY course_id
    ) subquery
);

--Q4
SELECT
    t.teacher_id,
    t.first_name,
    t.last_name,
    SUM(p.amount) AS total_payments
FROM Teacher t
JOIN Courses c ON t.teacher_id = c.teacher_id
LEFT JOIN Enrollments e ON c.course_id = e.course_id
LEFT JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.teacher_id, t.first_name, t.last_name;

--Q5
SELECT
    student_id,
    first_name,
    last_name
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Enrollments
    GROUP BY student_id
    HAVING COUNT(DISTINCT course_id) = (
        SELECT COUNT(DISTINCT course_id) FROM Courses
    )
);

--Q6
SELECT
    teacher_id,
    first_name,
    last_name
FROM Teacher
WHERE teacher_id NOT IN (
    SELECT DISTINCT teacher_id
    FROM Courses
    WHERE teacher_id IS NOT NULL
);

--Q7
SELECT
    AVG(age) AS average_age
FROM (
    SELECT
        student_id,
        first_name,
        last_name,
        DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age
    FROM Students
) AS StudentAge;

--Q8
SELECT
    course_id,
    course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM Enrollments
);

--Q9
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    e.course_id,
    c.course_name,
    SUM(p.amount) AS total_payments
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
LEFT JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name, e.course_id, c.course_name;

--Q10
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(p.payments_ID) > 1;

--Q11
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_payments
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

--Q12
SELECT
    c.course_name,
    COUNT(e.student_id) AS enrolled_students_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

--Q13
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(p.amount) AS average_payment_amount
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name;



