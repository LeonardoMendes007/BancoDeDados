CREATE DATABASE mecanica
GO
USE mecanica

CREATE TABLE cliente(

nome VARCHAR(70) NOT NULL,
logradouro VARCHAR(100) NOT NULL,
num INT NOT NULL,
bairro VARCHAR(60) NOT NULL,
telefone CHAR(8) NOT NULL,
carro CHAR(7) NOT NULL,
PRIMARY KEY (carro),
FOREIGN KEY (carro) REFERENCES  carro(placa)

)

CREATE TABLE carro(

placa CHAR(7) NOT NULL,
marca VARCHAR(30) NOT NULL,
modelo VARCHAR(20) NOT NULL,
cor VARCHAR(20) NOT NULL,
ano DATE NOT NULL,
PRIMARY KEY (placa)

)

CREATE TABLE peca(

codigo INT IDENTITY(1,1),
nome VARCHAR(40) NOT NULL,
valor INT NOT NULL,
PRIMARY KEY (codigo)

)

CREATE TABLE servico(

carro CHAR(7) NOT NULL,
peca INT NOT NULL,
quatidade INT NOT NULL,
valor INT NOT NULL,
dt DATE NOT NULL,
PRIMARY KEY(carro,peca,dt),
FOREIGN KEY (carro) REFERENCES  carro(placa),
FOREIGN KEY (peca) REFERENCES peca(codigo)
)

INSERT INTO carro VALUES
('AFT9087',	'VW',	'Gol',	'Preto',	'2007'),
('DXO9876',	'Ford',	'Ka',	'Azul',	'2000'),
('EGT4631',	'Renault',	'Clio',	'Verde',	'2004'),
('LKM7380',	'Fiat',	'Palio',	'Prata',	'1997'),
('BCD7521',	'Ford',	'Fiesta',	'Preto',	'1999')

INSERT INTO peca (nome,valor) VALUES
('Vela',	'70'),
('Correia Dentada',	'125'),
('Trambulador',	'90'),
('Filtro de Ar',	'30')

INSERT INTO cliente VALUES
('Jo�o Alves',	'R. Pereira Barreto', '1258',	'Jd. Oliveiras',	'21549658',	'DXO9876'),
('Ana Maria',	'R. 7 de Setembro',	'259',	'Centro',	'96588541',	'LKM7380'),
('Clara Oliveira',	'Av. Na��es Unidas',	'10254',	'Pinheiros',	'24589658',	'EGT4631'),
('Jos� Sim�es',	'R. XV de Novembro',	'36',	'�gua Branca',	'78952459',	'BCD7521'),
('Paula Rocha',	'R. Anhaia',	'548',	'Barra Funda',	'69582548',	'AFT9087')

INSERT INTO servico VALUES
('DXO9876',	'1',	'4',	'280',	'01/08/2020'),
('DXO9876',	'4',	'1',	'30', '01/08/2020'),
('EGT4631',	'3',	'1',	'90',	'02/08/2020'),
('DXO9876',	'2',	'1',	'125',	'07/08/2020')

SELECT telefone FROM cliente	
WHERE carro IN 
(SELECT placa FROM carro WHERE modelo = 'Ka' AND cor = 'Azul')

SELECT logradouro + ', ' + CAST(num AS VARCHAR(10)) + ' - ' + bairro  AS endereco FROM cliente
WHERE carro IN (
SELECT carro FROM servico WHERE dt = '02/08/2020'
)

SELECT ano FROM carro WHERE ano < '2001'

SELECT marca + ' ' + modelo + ' ' + cor FROM carro WHERE ano > '2005' 

SELECT codigo , nome FROM peca WHERE valor < '80'