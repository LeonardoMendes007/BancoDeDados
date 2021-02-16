CREATE DATABASE dbPalestra
GO
USE dbPalestra


CREATE TABLE curso(
codigo_curso INT NOT NULL,
nome VARCHAR(70) NOT NULL,
sigla VARCHAR(10) NOT NULL
PRIMARY KEY(codigo_curso))

CREATE TABLE palestrante(
codigo_palestrante INT IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
empresa VARCHAR(100) NOT NULL
PRIMARY KEY(codigo_palestrante))

CREATE TABLE aluno(
ra CHAR(7) NOT NULL,
nome VARCHAR(250) NOT NULL,
codigo_curso INT NOT NULL,
PRIMARY KEY(ra),
FOREIGN KEY(codigo_curso) REFERENCES curso(codigo_curso)
)

CREATE TABLE palestra(
codigo_palestra INT IDENTITY(1,1),
titulo VARCHAR(MAX) NOT NULL,
carga_horaria INT NULL,
data DATETIME NOT NULL,
codigo_palestrante INT NOT NULL,
FOREIGN KEY (codigo_palestrante) REFERENCES palestrante(codigo_palestrante),
PRIMARY KEY(codigo_palestra)
)

CREATE TABLE alunos_inscritos(
ra CHAR(7) NOT NULL,
codigo_palestra INT NOT NULL,
FOREIGN KEY (ra) REFERENCES aluno (ra),
FOREIGN KEY (codigo_palestra) REFERENCES palestra(codigo_palestra),
PRIMARY KEY (ra,codigo_palestra)
)

CREATE TABLE nao_alunos(
rg VARCHAR(9) NOT NULL,
orgao_exp CHAR(5) NOT NULL,
nome VARCHAR(250) NOT NULL,
PRIMARY KEY (rg,orgao_exp)
)

CREATE TABLE nao_alunos_inscritos(
codigo_palestra INT NOT NULL,
rg VARCHAR(9) NOT NULL,
orgao_exp CHAR(5) NOT NULL,
FOREIGN KEY (codigo_palestra) REFERENCES palestra(codigo_palestra),
FOREIGN KEY (rg,orgao_exp) REFERENCES nao_alunos(rg,orgao_exp),
PRIMARY KEY (codigo_palestra, rg, orgao_exp)
)


INSERT INTO curso VALUES 
(1,'banco de dados','bd'),
(2,'teste de software','tds'),
(3,'programação','pg'),
(4,'engenharia de software','eds'),
(5,'rede de computadores','rdc');

INSERT INTO aluno VALUES
(1115657,'Gustavo',1),
(1115665,'Karine',2),
(1113245,'Adriano',3),
(1113453,'Alicia',4),
(1113457,'Roberto',5);

INSERT INTO palestrante VALUES
('Colevati','IBM'),
('Satoshi','Itaú');

INSERT INTO palestra VALUES
('Sql Server',40,'2021-05-23 14:40:00',1),
('COBOL',55,'2021-03-23 15:50:00',2);

INSERT INTO alunos_inscritos VALUES
(1115657,1),
(1115665,1),
(1113245,1),
(1113453,2),
(1113457,2);

INSERT INTO nao_alunos VALUES
('38554508','43','leonardo'),
('38254628','34','Ivana');

INSERT INTO nao_alunos_inscritos VALUES
(1,'38554508','43'),
(2,'38254628','34');

drop view v_lista

CREATE VIEW v_lista
AS
select a.ra as documento, a.nome, palestra.titulo, palestrante.nome as 'nome_palestrante', palestra.carga_horaria, palestra.data, palestra.codigo_palestra
from aluno a, palestra, palestrante, alunos_inscritos ai
WHERE a.ra = ai.ra
and ai.codigo_palestra = palestra.codigo_palestra
and palestra.codigo_palestrante = palestrante.codigo_palestrante
UNION
select (an.rg + '-' + an.orgao_exp) as documento, an.nome, palestra.titulo, palestrante.nome  as 'nome_palestrante' , palestra.carga_horaria, palestra.data, palestra.codigo_palestra
from nao_alunos an, palestra, palestrante, nao_alunos_inscritos nai
WHERE an.rg = nai.rg
and an.orgao_exp = nai.orgao_exp
and nai.codigo_palestra = palestra.codigo_palestra
and palestra.codigo_palestrante = palestrante.codigo_palestrante


select v.documento, v.nome, v.titulo, v.nome_palestrante, v.carga_horaria, v.data from v_lista v
where v.codigo_palestra = 1
ORDER BY v.nome