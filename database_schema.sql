-- Create the online_exam database
CREATE DATABASE IF NOT EXISTS online_exam;
USE online_exam;

-- Create admins table
CREATE TABLE IF NOT EXISTS admins (
    adminId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create students table
CREATE TABLE IF NOT EXISTS students (
    studentId INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create exams table
CREATE TABLE IF NOT EXISTS exams (
    examId INT AUTO_INCREMENT PRIMARY KEY,
    examName VARCHAR(100) NOT NULL,
    description TEXT,
    duration INT NOT NULL,
    totalQuestions INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create questions table
CREATE TABLE IF NOT EXISTS questions (
    questionId INT AUTO_INCREMENT PRIMARY KEY,
    examId INT NOT NULL,
    questionText TEXT NOT NULL,
    optionA VARCHAR(255) NOT NULL,
    optionB VARCHAR(255) NOT NULL,
    optionC VARCHAR(255) NOT NULL,
    optionD VARCHAR(255) NOT NULL,
    correctAnswer VARCHAR(1) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (examId) REFERENCES exams(examId) ON DELETE CASCADE
);

-- Create results table
CREATE TABLE IF NOT EXISTS results (
    resultId INT AUTO_INCREMENT PRIMARY KEY,
    studentId INT NOT NULL,
    examId INT NOT NULL,
    score INT NOT NULL,
    totalQuestions INT NOT NULL,
    resultDate DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (studentId) REFERENCES students(studentId) ON DELETE CASCADE,
    FOREIGN KEY (examId) REFERENCES exams(examId) ON DELETE CASCADE
);

-- Create violations table
CREATE TABLE IF NOT EXISTS violations (
    violationId INT AUTO_INCREMENT PRIMARY KEY,
    studentId INT NOT NULL,
    examId INT NOT NULL,
    violationType VARCHAR(100) NOT NULL,
    description TEXT,
    violationDate DATETIME NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (studentId) REFERENCES students(studentId) ON DELETE CASCADE,
    FOREIGN KEY (examId) REFERENCES exams(examId) ON DELETE CASCADE
);

-- Insert sample admin
INSERT INTO admins (name, email, password) VALUES 
('Admin', 'admin@example.com', 'admin123');

-- Insert sample students
INSERT INTO students (name, email, password) VALUES 
('John Doe', 'john@example.com', 'password123'),
('Jane Smith', 'jane@example.com', 'password123');

-- Insert sample exam
INSERT INTO exams (examName, description, duration, totalQuestions) VALUES 
('Java Fundamentals', 'Basic Java programming concepts', 60, 10);

-- Insert sample questions
INSERT INTO questions (examId, questionText, optionA, optionB, optionC, optionD, correctAnswer) VALUES 
(1, 'What is Java?', 'A programming language', 'A coffee', 'An island', 'A car', 'A'),
(1, 'What does JVM stand for?', 'Java Virtual Machine', 'Java Visual Method', 'Java Variable Module', 'Java Version Manager', 'A'),
(1, 'Which keyword is used to create a class?', 'class', 'Class', 'CLASS', 'classdef', 'A'),
(1, 'What is the default value of an int variable?', '0', 'null', 'undefined', '1', 'A'),
(1, 'Which package is imported by default in Java?', 'java.lang', 'java.util', 'java.io', 'java.net', 'A'),
(1, 'What is the correct syntax to declare a method?', 'public void methodName() {}', 'void public methodName() {}', 'methodName public void() {}', 'public methodName void() {}', 'A'),
(1, 'Which of these is not a primitive data type?', 'String', 'int', 'double', 'boolean', 'A'),
(1, 'What is the size of an int in Java?', '4 bytes', '2 bytes', '8 bytes', '1 byte', 'A'),
(1, 'Which keyword is used for inheritance?', 'extends', 'inherits', 'extends from', 'inherit', 'A'),
(1, 'What is the correct way to create an object?', 'ClassName obj = new ClassName();', 'new ClassName obj;', 'ClassName obj new;', 'obj = new ClassName;', 'A');
