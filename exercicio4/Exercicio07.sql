CREATE DATABASE loja_eletronica
GO
USE loja_eletronica

CREATE TABLE cliente(

rg CHAR(9) NOT NULL,
cpf CHAR(11) NOT NULL,
nome VARCHAR(60) NOT NULL,
logradouro_end VARCHAR(90) NOT NULL,
num_end INT NOT NULL,
PRIMARY KEY (rg)

)

CREATE TABLE pedido(

nota_fiscal INT IDENTITY(1001,1),
valor DECIMAL(6,2) NOT NULL,
dt DATE NOT NULL,
rg_cliente CHAR(9) NOT NULL,
PRIMARY KEY (nota_fiscal),
FOREIGN KEY (rg_cliente) REFERENCES cliente (rg)

)

CREATE TABLE mercadoria(

codigo INT IDENTITY(10,1),
descricao VARCHAR(40) NOT NULL,
preco DECIMAL(6,2) NOT NULL,
quantidade INT NOT NULL,
cod_fornecedor INT NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor (codigo)

)

CREATE TABLE fornecedor(

codigo INT IDENTITY(1,1),
nome VARCHAR(30) NOT NULL,
logradouro_end VARCHAR(60) NOT NULL,
telefone VARCHAR(11),
cgc VARCHAR(15),
cidade VARCHAR(40),
transporte VARCHAR(10),
pais VARCHAR(30),
moeda VARCHAR(10)
PRIMARY KEY (codigo)

)

INSERT INTO cliente VALUES 
('29531844',	'34519878040',	'Luiz André',	'R. Astorga', '500'),
('13514996x',	'84984285630',	'Maria Luiza',	'R. Piauí', '174'),
('121985541',	'23354997310',	'Ana Barbara',	'Av. Jaceguai', '1141'),
('23987746x',	'43587669920',	'Marcos Alberto',	'R. Quinze', '22')

INSERT INTO pedido VALUES 
(	'754',	CONVERT(DATE,'01/04/2018',103),	'121985541'),
(	'350',	CONVERT(DATE,'02/04/2018',103),	'121985541'),
(	'30',	CONVERT(DATE,'02/04/2018',103),	'29531844'),
(	'1500',	CONVERT(DATE,'03/04/2018',103),	'13514996x')

INSERT INTO mercadoria VALUES
('Mouse',	'24',	'30',	'1'),
('Teclado',	'50',	'20',	'1'),
('Cx. De Som',	'30',	'8',	'2'),
('Monitor17',	'350',	'4',	'3'),
('Notebook',	'1500',	'7',	'4')

INSERT INTO fornecedor VALUES
('Clone'	,'Av. Nações Unidas, 12000',	'1141487000',NULL,		'São Paulo',NULL, NULL, NULL),			
('Logitech',	'28th Street, 100',	'1800145990'	,NULL,	NULL,	'Avião',	'EUA',	'US$'),
('LG',	'Rod. Castello Branco',	'0800664400',	'415997810/0001',	'Sorocaba',NULL, NULL, NULL),	
('PcChips',	'Ponte da Amizade', NULL,	NULL, NULL,	'Navio',	'Py',	'US$')


SELECT CAST(valor * 0.10 AS DECIMAL(6,2)) AS valor_com_desconto FROM pedido WHERE nota_fiscal = '1003'

SELECT CAST(valor * 0.05 AS DECIMAL(6,2)) AS valor_com_desconto FROM pedido WHERE valor > 700.00

SELECT preco FROM mercadoria WHERE quantidade < 10

UPDATE mercadoria SET preco = preco * 1.20 WHERE quantidade < 10

SELECT dt, valor FROM pedido WHERE rg_cliente IN (
      SELECT rg FROM cliente WHERE nome LIKE 'Luiz%'
)

SELECT cpf, nome, logradouro_end AS endereço FROM cliente WHERE rg IN (
     SELECT rg_cliente FROM pedido WHERE nota_fiscal = '1004'
)

SELECT pais, transporte FROM fornecedor WHERE codigo IN (
     SELECT cod_fornecedor FROM mercadoria WHERE descricao = 'Cx. De Som'
)

SELECT descricao, quantidade FROM mercadoria WHERE cod_fornecedor IN (
     SELECT codigo FROM fornecedor WHERE nome = 'Clone'
)

SELECT logradouro_end, telefone FROM fornecedor WHERE codigo IN (
     SELECT cod_fornecedor FROM mercadoria WHERE descricao LIKE '%Monitor%'
)

SELECT moeda FROM fornecedor WHERE codigo IN (
     SELECT cod_fornecedor FROM mercadoria WHERE descricao LIKE '%Notebook%'
)

SELECT DATEDIFF(MONTH,dt,GETDATE()) AS dias_passados,
       CASE WHEN (DATEDIFF(MONTH,dt,GETDATE()) > 6)
	           THEN
			           'atrasado'
			   ELSE
			           'em dia'
	    END AS statu
FROM pedido

SELECT DISTINCT cliente.nome AS cliente, (SELECT COUNT(pedido.nota_fiscal) FROM pedido WHERE rg_cliente = rg) FROM cliente, pedido
WHERE cliente.rg = pedido.rg_cliente

SELECT cliente.rg, cliente.cpf, cliente.nome, cliente.logradouro_end 
FROM cliente LEFT OUTER JOIN pedido
ON cliente.rg = pedido.rg_cliente
WHERE pedido.rg_cliente IS NULL