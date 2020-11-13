CREATE DATABASE farmacia
GO
USE farmacia

CREATE TABLE cliente(

cpf CHAR(11) NOT NULL,
nome VARCHAR(50) NOT NULL,
logradouro_end VARCHAR(70) NOT NULL,
num_end INT NOT NULL,
bairro_end VARCHAR(30) NOT NULL,
telefone CHAR(9) NOT NULL,
PRIMARY KEY (cpf)

)

CREATE TABLE venda(

nota_fiscal INT NOT NULL,
cpf_cliente CHAR(11) NOT NULL,
codigo_medicamento INT NOT NULL,
quantidade INT NOT NULL,
valor_total DECIMAL(7,2) NOT NULL,
dt DATE NOT NULL,
PRIMARY KEY (nota_fiscal, cpf_cliente, codigo_medicamento),
FOREIGN KEY (cpf_cliente) REFERENCES cliente (cpf),
FOREIGN KEY (codigo_medicamento) REFERENCES medicamento (codigo)

)

CREATE TABLE medicamento(

codigo INT IDENTITY(1,1),
nome VARCHAR(90) NOT NULL,
apresentacao VARCHAR(50) NOT NULL,
unidade_de_cadastro VARCHAR(20) NOT NULL,
preco DECIMAL(5,3) NOT NULL,
PRIMARY KEY (codigo)
)

INSERT INTO medicamento VALUES
('Acetato de medroxiprogesterona',  	 '150 mg/ml',  	 'Ampola',  	'6.700'),
('Aciclovir',  	 '200mg/comp.', 	 'Comprimido',  	'0.280'),
('Ácido Acetilsalicílico',  	'500mg/comp.',  	 'Comprimido' , 	'0.035'),
('Ácido Acetilsalicílico',	 '100mg/comp.',  	 'Comprimido',  	'0.030'),
('Ácido Fólico',  	 '5mg/comp.',  	 'Comprimido',  	'0.054'),
('Albendazol',  	 '400mg/comp. mastigável',  	 'Comprimido',  	'0.560'),
('Alopurinol',  	 '100mg/comp.',  	 'Comprimido',  	'0.080'),
('Amiodarona',  	 '200mg/comp.',  	 'Comprimido',  	'0.200'),
('Amitriptilina(Cloridrato)',  	 '25mg/comp.', 	 'Comprimido',  '0.220'),
('Amoxicilina', 	 '500mg/cáps.',  	 'Cápsula',  	'0.190')

SELECT * FROM medicamento 

INSERT INTO cliente VALUES
('34390898700',	'Maria Zélia',	'Anhaia',	'65',	'Barra Funda',	'92103762'),
('21345986290',	'Roseli Silva',	'Xv. De Novembro',	'987',	'Centro',	'82198763'),
('86927981825',	'Carlos Campos',	'Voluntários da Pátria',	'1276',	'Santana',	'98172361'),
('31098120900',	'João Perdizes',	'Carlos de Campos',	'90',	'Pari',	'61982371')

SELECT * FROM cliente

INSERT INTO venda VALUES
('31501',	'86927981825',	'10',	'3',	'0.57',	CONVERT(DATE,'01/11/2010',103)),
('31501',	'86927981825',	'2',	'10',	'2.8',	CONVERT(DATE,'01/11/2010',103)),
('31501',	'86927981825',	'5',	'30',	'1.05',	CONVERT(DATE,'01/11/2010',103)),
('31501',	'86927981825',	'8',	'30',	'6.6',	CONVERT(DATE,'01/11/2010',103)),
('31502',	'34390898700',	'8',	'15',	'3'	 ,   CONVERT(DATE,'01/11/2010',103)),
('31502',	'34390898700',	'2',	'10',	'2.8',   CONVERT(DATE,'01/11/2010',103)),
('31502',	'34390898700',	'9',	'10',	'2.2',   CONVERT(DATE,'01/11/2010',103)),
('31503',	'31098120900',	'1',	'20',	'134',   CONVERT(DATE,'02/11/2010',103))

SELECT * FROM venda

SELECT m.nome,m.apresentacao,m.unidade_de_cadastro,m.preco 
FROM medicamento m LEFT OUTER JOIN venda v
ON m.codigo = v.codigo_medicamento
WHERE v.codigo_medicamento IS NULL

SELECT c.nome 
FROM cliente c, venda v, medicamento m
WHERE c.cpf = v.cpf_cliente
AND v.codigo_medicamento = m.codigo
AND m.nome = 'Amiodarona'

SELECT c.cpf, c.logradouro_end + ', ' + CAST(c.num_end AS VARCHAR(10)) + ' - ' + c.bairro_end AS endereco_completo, m.nome, m.apresentacao, m.unidade_de_cadastro, m.preco, v.quantidade, v.valor_total 
FROM cliente c, venda v, medicamento m
WHERE m.codigo = v.codigo_medicamento
AND v.cpf_cliente = c.cpf
AND c.nome = 'Maria Zélia'

SELECT DISTINCT CONVERT(CHAR(10) , v.dt, 103) 
FROM venda v, cliente c
WHERE c.cpf = v.cpf_cliente
AND c.nome = 'Carlos Campos'

UPDATE medicamento SET nome = 'Cloridrato de Amitriptilina' WHERE nome = 'Amitriptilina(Cloridrato)'

SELECT nome FROM medicamento