CREATE DATABASE projeto
go
USE projeto

EXEC sp_configure 'default language', 27;
GO
RECONFIGURE ;
GO

CREATE TABLE projects(
id INT NOT NULL IDENTITY(10001,1),
name VARCHAR(45) NOT NULL,
description VARCHAR(45),
date DATE NOT NULL,
PRIMARY KEY(id),
CONSTRAINT chk_dt CHECK(date > '01/09/2014')
)

CREATE TABLE users(

id INT NOT NULL IDENTITY(1,1),
name VARCHAR(45) NOT NULL,
username VARCHAR(45) NOT NULL UNIQUE,
password VARCHAR(45) DEFAULT('123mudar'),
email VARCHAR(45) NOT NULL,
PRIMARY KEY(id)

)

CREATE TABLE users_has_projects(

users_id INT NOT NULL,
projects_id INT NOT NULL,
PRIMARY KEY(users_id,projects_id),
FOREIGN KEY (users_id) REFERENCES users (id),
FOREIGN KEY (projects_id) REFERENCES projects (id)
)

exec sp_help users

ALTER TABLE users DROP CONSTRAINT UQ__users__F3DBC572F27D078E
ALTER TABLE users ALTER COLUMN username VARCHAR(10)
ALTER TABLE users ADD UNIQUE (username); 

ALTER TABLE users ALTER COLUMN password VARCHAR(8)

--Transact-SQL

INSERT INTO users (name,username,password,email) VALUES
('Maria',  'Rh_maria',  '123mudar',  'maria@empresa.com'), 
('Paulo',  'Ti_paulo',  '123@456',  'paulo@empresa.com'), 
('Ana',  'Rh_ana',  '123mudar', 'ana@empresa.com'),
('Clara',  'Ti_clara',  '123mudar',  'clara@empresa.com'),
('Aparecido', 'Rh_apareci',  '55@!cido',  'aparecido@empresa.com')

Select * from users

INSERT INTO projects (name,description,date) VALUES
('Re‐folha',  'Refatoração das Folhas', '05/09/2014'), 
('Manutenção PC´s',  'Manutenção PC´s', '06/09/2014'),
('Auditoria', NULL,  '07/09/2014') 

Select * from projects

INSERT INTO users_has_projects (users_id, projects_id) VALUES
('1','10001'),
('5','10001'),
('3','10003'),
('4','10002'),
('2','10002')

select * from users_has_projects

UPDATE projects SET date = '2014-09-12' WHERE name LIKE 'Manutenção%'

UPDATE users SET username = 'Rh_cido' WHERE name = 'Aparecido'

UPDATE users SET password = '888@*' WHERE username = 'Rh_maria' AND password = '123mudar'

DELETE users_has_projects WHERE	users_id = '2'

ALTER TABLE projects ADD budget DECIMAL(7,2) NULL

UPDATE projects SET budget = '5750.00' WHERE id = '10001'
UPDATE projects SET budget = '7850.00' WHERE id = '10002'
UPDATE projects SET budget = '9530.00' WHERE id = '10003'

SELECT username, password from users WHERE name = 'Ana';

SELECT name, budget, CAST( budget * 1.25 AS DECIMAL(7,2)) AS budget_25 FROM projects

SELECT id, name, email FROM users WHERE password = '123mudar'

SELECT id, name FROM projects WHERE budget BETWEEN 2000.00 AND 8000.00