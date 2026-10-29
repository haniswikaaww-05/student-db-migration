
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch VARCHAR(50) NOT NULL
);

INSERT INTO students (student_id, name, branch)
VALUES
    (101, 'Hema', 'CSE'),
    (102, 'Ravi', 'CSE');

