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
    GroupName VARCHAR(30) NOT NULL UNIQUE KEY,
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
                       ('Bán Hàng');
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
					 ('dtt2@gmail.com',  'ductt2',   'Trần Đức 2',      1,             3,      '2020-01-15'),
                     ('dtt3@gmail.com',  'ductt3',   'Trần Đức 3',      2,             1,      '2019-12-10'),
                     ('dtt4@gmail.com',  'ductt4',   'Trần Đức 4',      5,             4,      '2019-09-23'),
                     ('dtt5@gmail.com',  'ductt5',   'Trần Đức 5',      4,             2,      '2020-04-01');
SELECT * FROM `account`;
-- Thêm dữ liệu cho bảng Group
INSERT INTO `Group`(GroupName,       CreatorID,  CreateDate)
VALUES			   ('Nhóm Kỹ Thuật',      1,    '2020-03-25'),
				   ('Nhóm Marketing',     2,    '2020-12-06'),
                   ('Nhóm Sale',          3,    '2019-08-25'),
                   ('Nhóm Bán Hàng',      4,    '2020-09-12'),
                   ('Nhóm Tài Chính',     5,    '2019-12-12');
SELECT * FROM `Group`;
-- Thêm dữ liệu cho bảng GroupAccount
INSERT INTO GroupAccount (GroupID,  AccountID, JoinDate)
VALUES					 (   1,          1,    '2020-04-10'),
						 (   3,          2,    '2020-05-20'),
                         (   2,          3,    '2020-02-25'),
                         (   5,          4,    '2019-08-10'),
                         (   4,          5,    '2020-05-26');
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
                         ('C++');
SELECT * FROM CategoryQuestion;
-- Thêm dữ liệu cho bảng Question
INSERT INTO Question (Content,     CategoryID, TypeID, CreatorID, CreateDate)
VALUES 				 ('Nhóm Java',       1,       2,        1,    '2020-04-10'),
					 ('Nhóm C++',        5,       1,        2,    '2020-12-06'),
					 ('Nhóm ASP.NET',    2,       1,        3,    '2020-07-10'),
					 ('Nhóm Ruby',       4,       2,        4,    '2019-05-19'),
					 ('Nhóm SQL',        3,       1,        5,    '2020-08-12');
SELECT * FROM Question;
-- Thêm dữ liệu cho bảng Answer
INSERT INTO Answer   (Content,      QuestionID,  IsCorrect)
VALUES 				 ('Trả lời 1',       5,          1    ),
					 ('Trả lời 2',       2,          0    ),
					 ('Trả lời 3',       1,          0    ),
					 ('Trả lời 4',       3,          1    ),
					 ('Trả lời 5',       4,          1    );
SELECT * FROM Question;
-- Thêm dữ liệu cho bảng Exam
INSERT INTO Exam   (`Code`,   Title,        CategoryID,   Duration,   CreatorID, CreateDate)
VALUES 			   ('AB001',  'Kì thi Java',      1,         60,          3,     '2019-07-03'),
				   ('AB002',  'Kì thi C++',       5,         45,          1,     '2020-06-12'),
				   ('AB003',  'Kì thi ASP.NET',   2,         90,          5,     '2020-09-18'),
				   ('AB004',  'Kì thi Ruby',      4,         120,         4,     '2020-11-17'),
				   ('AB005',  'Kì thi SQL',       3,         30,          2,     '2019-04-20');
SELECT * FROM Exam;
-- Thêm dữ liệu cho bảng ExamQuestion
INSERT INTO   ExamQuestion (ExamID, QuestionID)
VALUES 			           (   1,       3),
				           (   2,       5),
				           (   3,       2),
				           (   4,       1),
				           (   5,       4);
SELECT * FROM ExamQuestion;
SELECT * FROM `account`;
SELECT AccountID, Email, FullName FROM `account`;
SELECT AccountID FROM `account`;
-- Lọc trùng dữ liệu
SELECT DISTINCT FullName FROM `account`;
-- từ khóa where
SELECT * FROM `account` WHERE DepartmentID=2;
SELECT * FROM `account` WHERE PositionID=4;
SELECT * FROM `account` WHERE CreateDate = '2019-12-10 00:00:00';
SELECT * FROM `account` WHERE CreateDate < '2020-12-10 00:00:00';
-- and or
SELECT * FROM `account` WHERE DepartmentID=2 AND PositionID=1;
SELECT * FROM `account` WHERE DepartmentID=2 or PositionID=3;
SELECT * FROM `account` WHERE DepartmentID IN (5,1,2);
SELECT * FROM `account` WHERE DepartmentID NOT IN (5,1,2);
-- order by ASC (ascending). DESC (descending)
SELECT FullName FROM `account` ORDER BY FullName;
SELECT FullName FROM `account` ORDER BY FullName DESC;
SELECT * FROM `account` ORDER BY DepartmentID;
-- LIMIT
SELECT * FROM `account` LIMIT 3 ;
-- Lấy 3 phần tử cuối
SELECT * FROM `account` ORDER BY AccountID DESC LIMIT 3;
-- COUNT() NOW()
SELECT COUNT(*) FROM `account`;
SELECT COUNT(AccountID) FROM `account`;
SELECT COUNT(1) FROM `account`;
-- SUM() MAX() MIN AVG
SELECT SUM(AccountID) FROM `account`;
-- Lấy ra danh sách học viên môn MySQL
SELECT * FROM Student WHERE SujectName = 'MySQL';
-- Lấy ra điểm số lớn nhất môn MySQL, Alias
SELECT SubjectName AS MonHoc, Max(StudentPoint) AS MaxPoint FROM Student WHERE SujectName = 'MySQL';
-- Tổng hợp lại kết quả
-- GRoup by
SELECT MAX(StudentPoint) FROM Student GROUP BY SubjectName;
-- Đếm số học viên trong mỗi môn học
SELECT SubjectName as MonHoc, Count(1) AS SL from Student Group by SubjectName;
-- Đếm số học viên trong mỗi môn học va chỉ in ra những môn học có ít nhất 4 học viên
SELECT SubjectName as MonHoc, Count(1) AS SL 
FROM Student 
Group by SubjectName
HAVING COUNT(1) >=4;