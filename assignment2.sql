---------------------------create tables --------------------
CREATE TABLE Students(
	student_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100)
);


CREATE TABLE Courses(
	course_id SERIAL PRIMARY KEY,
	title VARCHAR(100),
	description TEXT
);

CREATE TABLE Enrollment(
	enrollment_id SERIAL PRIMARY KEY,
	student_id INT REFERENCES Students(student_id),
	course_id INT REFERENCES Courses(course_id),
	enrollment_date DATE
);

CREATE TABLE Departments(
	department_id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	description TEXT
);

CREATE TABLE Professors(
	professor_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(100),
	department_id INT REFERENCES Departments(department_id)
);



CREATE TABLE Teaching(
	teaching_id SERIAL PRIMARY KEY,
	professor_id INT REFERENCES Professors(professor_id),
	course_id INT REFERENCES Courses(course_id)
);

----------------insert values -----------------
INSERT INTO Students(first_name, last_name, email)
VALUES 
('Mozhdeh', 'Marvi', 'mozhdehmarvi@gmail.com'),
('Hoda', 'Madadi', 'hodamadadi@gmail.com'),
('Sahar', 'Delavari', 'sahardelavari@gmail.com'),
('Nazanin', 'Jami', 'nazijami@gmail.com'),
('Mursal', 'Yazdani', 'morsalyazdani@gmail.com'),
('Mursal', 'Marvi', 'mozhdehmarvi@gmail.com'),
('Madina', 'Moradi', 'hodamadadi@gmail.com'),
('Sahra', 'Ahmadi', 'sahraahmadi@gmail.com'),
('Farzana', 'Mojib', 'farzanamojib@gmail.com'),
('Asma', 'Yousufzai', 'asmayousuf@gmail.com');


INSERT INTO Courses(title, description)
VALUES 
('Node.JS', 'Introduction to Node.JS'),
('Python', 'Introduction to Python'),
('Bootstrap', 'Introduction to Bootstrap'),
('Pandas', 'Joining data with Pandas'),
('Illustrator', 'Illustrator Intermediate Course');

INSERT INTO Enrollment(student_id, course_id, enrollment_date)
VALUES 
(1, 1, '2024-08-01'),
(2, 2, '2024-07-02'),
(3, 3, '2024-05-03'),
(4, 4, '2024-07-04'),
(5, 5, '2024-06-05'),
(6, 3, '2024-08-01'),
(7, 1, '2024-07-12'),
(8, 1, '2024-05-13'),
(9, 1, '2024-07-14'),
(10, 2, '2024-06-15');

INSERT INTO Departments(name, description)
VALUES 
('Full-stack development', 'Full-stack development department'),
('Data Analyst', 'Data Science department'),
('Graphic & Designing', 'Graphic department');

INSERT INTO Professors(first_name, last_name, email, department_id)
VALUES 
('Ehsan', 'Ehrari', 'ehsanehrari@gmail.com',1),
('Rafi', 'Samim', 'rafisamim@gmail.com',2),
('Farahnaz', 'Osmani', 'farahosmani@gmail.com',3);



INSERT INTO Teaching(professor_id, course_id)
VALUES 
(1, 1),
(2, 2),
(1, 3),
(2, 4),
(3, 5);

SELECT S.first_name, S.last_name, S.email
FROM Students AS S
JOIN Enrollment AS E ON S.student_id = E.student_id
WHERE E.course_id = 3;

SELECT C.title, C.description 
FROM Courses AS C
JOIN Teaching AS T ON C.course_id = T.course_id
WHERE T.professor_id = 5;
    

SELECT AVG(student_count) AS average_students
FROM (
SELECT COUNT(E.student_id) AS student_count
FROM Enrollment E
GROUP BY E.course_id
) subquery;

   SELECT D.name, COUNT(E.student_id) AS student_count
    FROM Departments D
    JOIN Professors P ON D.department_id = P.department_id
    JOIN Teaching T ON P.professor_id = T.professor_id
    JOIN Enrollment E ON T.course_id = E.course_id
    GROUP BY D.name
    ORDER BY student_count DESC
    LIMIT 1; -- For highest

    SELECT D.name, COUNT(E.student_id) AS student_count
    FROM Departments D
    JOIN Professors P ON D.department_id = P.department_id
    JOIN Teaching T ON P.professor_id = T.professor_id
    JOIN Enrollment E ON T.course_id = E.course_id
    GROUP BY D.name
    ORDER BY student_count ASC
    LIMIT 1; -- For lowest