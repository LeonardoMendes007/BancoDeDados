CREATE DATABASE isnt_ensino
GO
use isnt_ensino

CREATE TABLE aluno (

ra INT NOT NULL,
nome VARCHAR(60) NOT NULL,
sobrenome VARCHAR(100) NOT NULL,
end_logadouro VARCHAR(80) NOT NULL,
end_num INT NOT NULL,
end_bairro VARCHAR(50) NOT NULL,
end_cep CHAR(8) NOT NULL,
telefone CHAR(8),
PRIMARY KEY (ra)
)

DROP TABLE aluno

CREATE TABLE curso(

codigo INT IDENTITY(1,1), 
nome VARCHAR(30) NOT NULL,
carga_horaria INT NOT NULL,
turno CHAR(5) NOT NULL,
PRIMARY KEY (codigo)

)

CREATE TABLE disciplina(

codigo INT IDENTITY(1,1),
nome VARCHAR(30) NOT NULL,
carga_horaria INT NOT NULL,
turno CHAR(5) NOT NULL,
semestre INT NOT NULL,
PRIMARY KEY (codigo)

)


INSERT INTO aluno (ra, nome, sobrenome,end_logadouro, end_num, end_bairro, end_cep, telefone) VALUES
('12345',	'José',	'Silva',	'Almirante Noronha',	'236',	'Jardim São Paulo',	'1589000',	'69875287'),
('12346',	'Ana',	'Maria Bastos',	'Anhaia',	'1568',	'Barra Funda',	'3569000',	'25698526'),
('12347',	'Mario',	'Santos',	'XV de Novembro',	'1841',	'Centro',	'1020030',	NULL),
('12348',	'Marcia',	'Neves',	'Voluntários da Patria',	'225',	'Santana',	'2785090',	'78964152')


INSERT INTO curso (codigo,nome,carga_horaria,turno) VALUES
('Informática',	'2800',	'Tarde'),
('Informática',	'2800'	,'Noite'),
('Logística',	'2650',	'Tarde'),
('Logística',	'2650',	'Noite'),
('Plásticos',	'2500',	'Tarde'),
('Plásticos',	'2500',	'Noite')

INSERT INTO disciplina (codigo,nome,carga_horaria,turno,semestre) VALUES
(	'Informática',	'4',	'Tarde',	'1'),
(	'Informática',	'4',	'Noite',	'1'),
(	'Quimica',	'4',	'Tarde',	'1'),
(	'Quimica',	'4',	'Noite',	'1'),
(	'Banco de Dados I',	'2',	'Tarde',	'3'),
(	'Banco de Dados I',	'2',	'Noite',	'3'),
(	'Estrutura de Dados', '4',	'Tarde',	'4'),
(	'Estrutura de Dados',	'4',	'Noite',	'4')

SELECT nome + ' ' + sobrenome as nome_completo FROM aluno

SELECT end_logadouro, end_num, end_bairro, end_cep FROM aluno
WHERE telefone IS NULL

SELECT SUBSTRING(telefone,1,4) + '-' + SUBSTRING(telefone,5,8) FROM aluno WHERE ra = '12348'

SELECT nome, turno FROM curso WHERE carga_horaria = '2800'

SELECT semestre FROM disciplina WHERE nome = 'Banco de Dados I' AND turno = 'noite'
 
