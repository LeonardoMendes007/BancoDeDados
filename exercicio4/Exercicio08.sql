CREATE DATABASE supermercado
GO
USE supermercado

CREATE TABLE cliente(

codigo INT IDENTITY(1,1),
nome VARCHAR(60) NOT NULL,
logradouro_end VARCHAR(80) NOT NULL,
num_end INT NOT NULL,
telefone CHAR(8) NOT NULL,
telefone_comercial CHAR(8),
PRIMARY KEY (codigo)

)


CREATE TABLE mercadoria(

codigo INT IDENTITY(1001,1),
nome VARCHAR(40) NOT NULL,
corredor INT NOT NULL,
tipo INT NOT NULL,
valor DECIMAL(7,2) NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (corredor) REFERENCES corredor (codigo),
FOREIGN KEY (tipo) REFERENCES tipo_de_mercadoria (codigo)
)

CREATE TABLE corredor(

codigo INT IDENTITY(101,1),
tipo INT,
nome VARCHAR(40),
PRIMARY KEY (codigo),
FOREIGN KEY (tipo) REFERENCES tipo_de_mercadoria (codigo)

)

CREATE TABLE tipo_de_mercadoria(

codigo INT IDENTITY(10001,1),
nome VARCHAR(40) NOT NULL,
PRIMARY KEY (codigo)

)

CREATE TABLE compra (

nota_fiscal INT NOT NULL,
codigo_cliente INT NOT NULL,
valor DECIMAL(7,2) NOT NULL,
PRIMARY KEY (nota_fiscal),
FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo)

)

INSERT INTO cliente VALUES 
('Luis Paulo',	'R. Xv de Novembro', '100',	'45657878', null),
('Maria Fernanda',	'R. Anhaia', '1098',	'27289098'	,'40040090'),
('Ana Claudia',	'Av. Voluntários da Pátria', '876',	'21346548', null),	
('Marcos Henrique',	'R. Pantojo', '76',	'51425890',	'30394540'),
('Emerson Souza',	'R. Pedro Álvares Cabral', '97',	'44236545',	'39389900'),
('Ricardo Santos',	'Trav. Hum', '10',	'98789878', null)	


SELECT * FROM cliente

INSERT INTO tipo_de_mercadoria VALUES
('Pães'),
('Frios'),
('Bolacha'),
('Clorados'),
('Frutas'),
('Esponjas'),
('Massas'),
('Molhos')

SELECT * FROM tipo_de_mercadoria

INSERT INTO compra VALUES
('1234',	'2',	'200'),
('2345'	,'4',	'156'),
('3456'	,'6',	'354'),
('4567'	,'3',	'19')

SELECT * FROM compra

INSERT INTO corredor VALUES
(	'10001',	'Padaria'),
(	'10002',	'Calçados'),
(	'10003',	'Biscoitos'),
(	'10004',	'Limpeza'),
(	NULL,	NULL),
(	NULL,	NULL),
(	'10007',	'Congelados')

SELECT * FROM corredor



INSERT INTO mercadoria VALUES
(	'Pão de Forma',	'101',	'10001',	3.5),
(	'Presunto',	'101',	'10002',	2.0),
(	'Cream Cracker',	'103',	'10003',	4.5),
(	'Água Sanitária',	'104',	'10004',	6.5),
(	'Maçã',	'105',	'10005',	0.9),
(	'Palha de Aço',	'106',	'10006',	1.3),
(	'Lasanha',	'107',	'10007',	9.7)

SELECT * FROM mercadoria

SELECT ISNULL(valor,'0') AS valor
FROM compra WHERE codigo_cliente IN (
     SELECT codigo FROM cliente WHERE nome = 'Luis Fernando'
)

SELECT ISNULL(valor,'0') AS valor
FROM compra WHERE codigo_cliente IN (
     SELECT codigo FROM cliente WHERE nome = 'Marcos Henrique'
)

SELECT cliente.logradouro_end + ', ' + CAST(cliente.num_end AS VARCHAR(50)) AS endereco_completo, cliente.telefone 
FROM cliente, compra
WHERE compra.codigo_cliente = cliente.codigo
AND compra.nota_fiscal = '4567'

SELECT valor FROM mercadoria WHERE tipo IN (
     SELECT codigo FROM tipo_de_mercadoria WHERE nome = 'Pães'
)

SELECT nome FROM corredor WHERE codigo IN (
     SELECT corredor FROM mercadoria WHERE nome = '%Lasanha%'
)

SELECT nome FROM corredor WHERE tipo IN (
     SELECT codigo FROM tipo_de_mercadoria WHERE nome = 'Clorados'
)