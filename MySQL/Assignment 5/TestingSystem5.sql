-- Lệnh xóa DB
DROP DATABASE IF EXISTS TestingSystem;
-- Lệnh dùng để tạo ra DB
CREATE DATABASE TestingSystem;
-- Chọn DB để sử dụng
USE TestingSystem;
-- Tạo bảng Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department ( 
	DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(30) NOT NULL
);

-- Tạo bảng Position
DROP TABLE IF EXISTS Position;
CREATE TABLE Position ( 
	PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName ENUM('Dev','Test','Scrum Master','PM') NOT NULL
);
-- Tạo bảng Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` ( 
	AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(30) NOT NULL UNIQUE KEY,
    Username VARCHAR(30) NOT NULL UNIQUE KEY,
    FullName VARCHAR(30) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
	FOREIGN KEY(PositionID) REFERENCES `Position` (PositionID)
);
-- Tạo bảng Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` ( 
	GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
-- Tạo bảng GroupAccount
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount ( 
	GroupID TINYINT UNSIGNED NOT NULL,
    AccountID TINYINT UNSIGNED NOT NULL,
    JoinDate DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
	FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);
-- Tạo bảng TypeQuestion
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion ( 
	TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);
-- Tạo bảng CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion ( 
	CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE KEY
);

-- Tạo bảng Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question ( 
	QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content VARCHAR(100) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    TypeID TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
-- Tạo bảng Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer ( 
	AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content VARCHAR(100) NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    isCorrect BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question (QuestionID)
);
-- Tạo bảng Exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam ( 
	ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code` VARCHAR(30) NOT NULL,
    Title VARCHAR(30) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    Duration TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
	FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
);
-- Tạo bảng ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion ( 
	ExamID TINYINT UNSIGNED NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (ExamID,QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam (ExamID),
    FOREIGN KEY(QuestionID) REFERENCES Question (QuestionID)
);
-- Thêm dữ liệu
-- Thêm dữ liệu cho bảng Department
INSERT INTO department(DepartmentName)
VALUES 				   ('Marketing'),
					   ('Sale'),
					   ('Kỹ Thuật'),
					   ('Tài Chính'),
                       ('Bán Hàng'),
                       ('Bảo Vệ'),
                       ('Tư Vấn'),
                       ('Nhân Sự'),
                       ('Khách Hàng'),
                       ('Hàng Hóa');
-- Thêm dữ liệu cho bảng Positon
INSERT INTO `Position` (PositionName)
VALUES 				    ('Dev'),
						('Test'),
                        ('Scrum Master'),
                        ('PM');
SELECT * FROM department;
SELECT * FROM position;
-- Thêm dữ liệu cho bảng Account
INSERT INTO `account`(Email,              Username,  FullName,     DepartmentID,   PositionID, CreateDate)
VALUES				 ('dtt1@gmail.com',  'ductt1',   'Trần Đức 1',      3,             4,      '2019-03-05'),
					 ('dtt2@gmail.com',  'ductt2',   'Trần Đức 2',      10,            3,      '2020-01-15'),
                     ('dtt3@gmail.com',  'ductt3',   'Trần Đức 3',      2,             1,      '2019-12-10'),
                     ('dtt4@gmail.com',  'ductt4',   'Trần Đức 4',      9,             4,      '2019-09-23'),
                     ('dtt5@gmail.com',  'ductt5',   'Trần Đức 5',      4,             2,      '2020-04-01'),
                     ('dtt6@gmail.com',  'ductt6',   'Trần Đức 6',      7,             3,      '2020-06-10'),
                     ('dtt7@gmail.com',  'ductt7',   'Trần Đức 7',      5,             1,      '2019-04-07'),
                     ('dtt8@gmail.com',  'ductt8',   'Trần Đức 8',      1,             4,      '2020-08-16'),
                     ('dtt9@gmail.com',  'ductt9',   'Trần Đức 9',      8,             1,      '2020-11-03'),
                     ('dtt10@gmail.com', 'ductt10',  'Trần Đức 10',     6,             2,      '2020-5-20');
SELECT * FROM `account`;
-- Thêm dữ liệu cho bảng Group
INSERT INTO `Group`(GroupName,       CreatorID,  CreateDate)
VALUES			   ('Nhóm Kỹ Thuật',      1,    '2020-03-25'),
				   ('Nhóm Marketing',     2,    '2020-12-06'),
                   ('Nhóm Sale',          3,    '2019-08-25'),
                   ('Nhóm Bán Hàng',      4,    '2020-09-12'),
                   ('Nhóm Tài Chính',     5,    '2019-12-12'),
                   ('Nhóm Bảo Vệ',        6,    '2020-07-05'),
                   ('Nhóm Tư Vấn',        7,    '2019-04-20'),
                   ('Nhóm Nhân Sự',       8,    '2019-07-18'),
                   ('Nhóm Khách Hàng',    9,    '2019-02-22'),
                   ('Nhóm Hàng Hóa',     10,    '2019-10-10');
SELECT * FROM `Group`;
-- Thêm dữ liệu cho bảng GroupAccount
INSERT INTO GroupAccount (GroupID,  AccountID, JoinDate)
VALUES					 (   1,          1,    '2020-04-10'),
						 (   6,          2,    '2020-05-20'),
                         (   8,          3,    '2020-02-25'),
                         (   5,          4,    '2019-08-10'),
                         (   4,          5,    '2020-05-26'),
						 (   10,         6,    '2019-12-25'),
                         (   9,          7,    '2020-11-20'),
                         (   2,          8,    '2020-03-16'),
                         (   3,          9,    '2020-08-27'),
                         (   7,          10,   '2019-05-25');
SELECT * FROM GroupAccount;
-- Thêm dữ liệu cho bảng TypeQuestion
INSERT INTO TypeQuestion (TypeName)
VALUES 					 ('Essay'),
						 ('Multiple-Choice');
SELECT * FROM TypeQuestion;
-- Thêm dữ liệu cho bảng CategoryQuestion
INSERT INTO CategoryQuestion (CategoryName)
VALUES 					 ('Java'),
						 ('ASP.NET'),
                         ('SQL'),
                         ('Ruby'),
                         ('C++'),
                         ('PHP'),
                         ('Reactj'),
                         ('Pascal'),
                         ('Python'),
                         ('Plaxis');
SELECT * FROM CategoryQuestion;
-- Thêm dữ liệu cho bảng Question
INSERT INTO Question (Content,     CategoryID, TypeID, CreatorID, CreateDate)
VALUES 				 ('Nhóm Java',       1,       2,        1,    '2020-04-10'),
					 ('Nhóm C++',        5,       1,        2,    '2020-12-06'),
					 ('Nhóm ASP.NET',    2,       1,        3,    '2020-07-10'),
					 ('Nhóm Ruby',       4,       2,        4,    '2019-05-19'),
					 ('Nhóm SQL',        3,       1,        5,    '2020-08-12'),
                     ('Nhóm Plaxis',     10,      1,        6,    '2020-11-17'),
                     ('Nhóm Reactj',     7,       1,        7,    '2020-04-17'),
                     ('Nhóm Python',     9,       2,        8,    '2020-03-19'),
                     ('Nhóm Pascal',     8,       1,        9,    '2020-06-08'),
                     ('Nhóm PHP',        6,       2,       10,    '2019-08-20');
SELECT * FROM Question;
-- Thêm dữ liệu cho bảng Answer
INSERT INTO Answer   (Content,      QuestionID,  IsCorrect)
VALUES 				 ('Trả lời 1',       5,          1    ),
					 ('Trả lời 2',       10,         0    ),
					 ('Trả lời 3',       1,          0    ),
					 ('Trả lời 4',       3,          1    ),
					 ('Trả lời 5',       8,          0    ),
                     ('Trả lời 6',       6,          1    ),
                     ('Trả lời 7',       7,          0    ),
                     ('Trả lời 8',       4,          0    ),
                     ('Trả lời 9',       2,          1    ),
                     ('Trả lời 10',      1,          1    );
SELECT * FROM Question;
-- Thêm dữ liệu cho bảng Exam
INSERT INTO Exam   (`Code`,   Title,        CategoryID,   Duration,   CreatorID, CreateDate)
VALUES 			   ('AB001',  'Kì thi Java',      1,         60,          1,     '2019-07-03'),
				   ('AB002',  'Kì thi C++',       5,         45,          2,     '2020-06-12'),
				   ('AB003',  'Kì thi ASP.NET',   2,         90,          3,     '2020-09-18'),
				   ('AB004',  'Kì thi Ruby',      4,         120,         4,     '2020-11-17'),
				   ('AB005',  'Kì thi SQL',       3,         30,          5,     '2019-04-20'),
                   ('AB006',  'Kì thi Plaxis',   10,         30,          6,     '2019-04-20'),
                   ('AB007',  'Kì thi Reaactj',   7,         50,          7,     '2019-04-20'),
                   ('AB008',  'Kì thi Python',    9,         40,          8,     '2019-04-20'),
                   ('AB009',  'Kì thi Pascal',    8,         60,          9,     '2019-04-20'),
                   ('AB0010',  'Kì thi PHP',      6,         60,          10,     '2019-04-20');
SELECT * FROM Exam;
-- Thêm dữ liệu cho bảng ExamQuestion
INSERT INTO   ExamQuestion (ExamID, QuestionID)
VALUES 			           (   1,       3),
				           (   2,       6),
				           (   3,       2),
				           (   4,      10),
				           (   5,       9),
                           (   6,       4),
                           (   7,       1),
                           (   8,       7),
                           (   9,       4),
                           (  10,       5);
SELECT * FROM ExamQuestion;
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS vw_ListSale;
CREATE OR REPLACE VIEW vw_ListSale AS
SELECT a.Email, a.FullName, d.DepartmentName FROM `account` a
INNER JOIN department d on a.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sale';

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS vw_q2;
CREATE OR REPLACE VIEW vw_q2 AS
WITH CTE_ListMaxAccount AS(
SELECT count(1) AS temp FROM groupaccount ga1
GROUP BY ga1.AccountID
)
SELECT a.AccountID, a.Username, count(1) AS SL FROM groupaccount ga
INNER JOIN `account` a ON ga.AccountID = a.AccountID
GROUP BY ga.AccountID
HAVING count(1) = (
SELECT MAX(temp) AS maxCount FROM CTE_ListMaxAccount
);
SELECT * FROM vw_q2;
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS vw_Listq3;
CREATE OR REPLACE VIEW vw_Listq3 AS
SELECT * FROM question
WHERE length(Content)>15;

SELECT * FROM vw_listq3;
DELETE FROM vw_listq3;


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS vw_MaxNV;
CREATE OR REPLACE VIEW vw_MaxNV AS
WITH CTE_CountMAXNV AS(
SELECT count(1) AS temp FROM account a1
GROUP BY a1.DepartmentID)

SELECT a.Email, a.FullName, d.DepartmentName, count(1) AS SL
FROM `account` a
INNER JOIN department d ON d.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING count(1) = (SELECT max(temp) FROM CTE_CountMAXNV);
SELECT * FROM vw_MaxNV;
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS vw_q5;
CREATE OR REPLACE VIEW vw_q5 AS
SELECT q.QuestionID, q.Content, a.FullName FROM question q
INNER JOIN `account` a ON q.CreatorID= a. AccountID
WHERE substring_index(a.FullName,' ',1) = 'Nguyễn';

SELECT * FROM vw_q5;