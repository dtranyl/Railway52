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
-- Q1 Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT a.Email, a.Username, a.FullName, d.DepartmentName 
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID;
-- Q2 Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account`
WHERE CreateDate > '2010-12-20 00:00:00';
-- Q3 Viết lệnh để lấy ra tất cả các developer
SELECT a.Email, a.Username, a.FullName,  p.PositionName 
FROM `account` a
INNER JOIN position p ON a.PositionID = p.PositionID
WHERE p.PositionName = 'Dev';
-- Q4 Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT a.Email, a.Username, a.FullName, d.DepartmentName,COUNT(1) AS SL
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING COUNT(1) >3;
-- Q5 Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
WITH CTE_MaxQuestionID AS (
SELECT COUNT(1) as temp
FROM examquestion e
GROUP BY e.QuestionID
)
SELECT e.QuestionID, q.Content,COUNT(1) AS SL
FROM examquestion  e
INNER JOIN question q ON e.QuestionID = q.QuestionID
GROUP BY e.QuestionID
HAVING COUNT(1) = (SELECT MAX(temp) FROM CTE_MaxQuestionID)  ;
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT a.Email, a.Username, a.FullName, d.DepartmentName,COUNT(1) AS SL
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID;
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.QuestionID, q.Content, count(1) AS SL
FROM examquestion eq
RIGHT JOIN question q ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
WITH CTE_MaxAnswerID AS (
SELECT COUNT(1) as temp
FROM answer a1
GROUP BY a1.QuestionID
)
SELECT q.QuestionID, q.Content,COUNT(1) AS SL
FROM answer a
INNER JOIN question q ON q.QuestionID = a.QuestionID
GROUP BY a.QuestionID
HAVING COUNT(1) = (SELECT MAX(temp) FROM CTE_MaxAnswerID)  ;
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT g.GroupID, count(1) AS SL
FROM groupaccount ga
INNER JOIN `group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
ORDER BY g.GroupID ASC;
-- Question 10: Tìm chức vụ có ít người nhất

SELECT a.PositionID,p.positionName, COUNT(a.PositionID) FROM `account` a
INNER JOIN position p on p.positionID = a.positionID
GROUP BY a.PositionID
HAVING COUNT(a.PositionID) = (SELECT min(SL) FROM (SELECT COUNT(a1.PositionID) AS SL FROM `account` a1 GROUP BY a1.PositionID) AS tmp_1);question
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT d.DepartmentID, d.DepartmentName, p.PositionName, count(p.PositionName) AS SL
FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT q.QuestionID, q.Content, a.FullName, tq.TypeName AS TG, ans.Content
FROM question q
INNER JOIN categoryquestion cq ON q.CategoryID = cq.CategoryID
INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
INNER JOIN `account` a  ON a.AccountID = q.CreatorID
INNER JOIN answer ans ON q.QuestionID = ans.QuestionID
ORDER BY Q.QuestionID ASC;
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT tq.TypeID, tq.TypeName, count(1) AS SL
FROM question Q
INNER JOIN typequestion tq ON q.TypeID =tq.TypeID
GROUP BY q.TypeID;
-- Question 14:Lấy ra group không có account nào
SELECT * FROM groupaccount ga
RIGHT JOIN `group` g ON ga.GroupID = g.GroupID 
WHERE ga.GroupID IS NULL;

-- Question 15: Lấy ra group không có account nào
SELECT * FROM groupaccount ga
RIGHT JOIN `group` g ON ga.GroupID = g.GroupID
WHERE ga.AccountID is NULL;
-- Question 16: Lấy ra question không có answer nào
SELECT * FROM question q
LEFT JOIN answer a ON q.QuestionID = a.QuestionID
WHERE a.QuestionID IS NULL;
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT a.Email, a.Username, a.FullName FROM `account` a
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT a.Email, a.Username, a.FullName FROM `account` a
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.Email, a.Username, a.FullName FROM `account` a
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 1
UNION
SELECT a.Email, a.Username, a.FullName FROM `account` a
INNER JOIN groupaccount ga ON a.AccountID = ga.AccountID
WHERE ga.GroupID = 2;

-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT g.GroupName, COUNT(1) AS SL
FROM groupaccount ga
INNER JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) >= 5;
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT g.GroupName, COUNT(1) AS SL
FROM groupaccount ga
INNER JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) <= 7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.GroupName, COUNT(1) AS SL
FROM groupaccount ga
INNER JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) >= 5
UNION
SELECT g.GroupName, COUNT(1) AS SL
FROM groupaccount ga
INNER JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(1) <= 7;
