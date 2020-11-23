CREATE DATABASE operadora
GO
USE operadora

CREATE TABLE plano (
cod_plano INT IDENTITY,
nome_plano VARCHAR(50) NOT NULL,
valor_plano INT NOT NULL,
PRIMARY KEY (cod_plano)
)

CREATE TABLE servico (
cod_servico INT IDENTITY,
nome_servico VARCHAR(50) NOT NULL,
valor_servico INT NOT NULL,
PRIMARY KEY (cod_servico)
)

CREATE TABLE cliente (
cod_cliente INT NOT NULL,
nome_cliente VARCHAR(50) NOT NULL,
data_inicio DATE NOT NULL,
PRIMARY KEY (cod_cliente)
)

CREATE TABLE contratos (
cod_cliente INT NOT NULL,
cod_plano INT NOT NULL,
cod_servico INT NOT NULL,
status_contrato CHAR(1) NOT NULL ,
dat DATE NOT NULL,
CONSTRAINT chk_status CHECK( status_contrato = 'E' OR status_contrato = 'D' OR status_contrato = 'A'),
PRIMARY KEY (cod_cliente, cod_plano, cod_servico, status_contrato),
FOREIGN KEY (cod_cliente) REFERENCES cliente (cod_cliente),
FOREIGN KEY (cod_plano) REFERENCES plano (cod_plano),
FOREIGN KEY (cod_servico) REFERENCES servico (cod_servico)
)

INSERT INTO plano VALUES
('100 Minutos',	80),
('150 Minutos',	130),
('200 Minutos',	160),
('250 Minutos',	220),
('300 Minutos',	260),
('600 Minutos',	350)

INSERT INTO servico VALUES
('100 SMS',	10),
('SMS Ilimitado',	30),
('Internet 500 MB',	40),
('Internet 1 GB',	60),
('Internet 2 GB',	70)


INSERT INTO cliente VALUES 
(1234,	'Cliente A',CONVERT(DATE,'15/10/2012',103)	),
(2468,	'Cliente B',CONVERT(DATE,'20/11/2012',103)	),
(3702,	'Cliente C',CONVERT(DATE,'25/11/2012',103)	),
(4936,	'Cliente D',CONVERT(DATE,'01/12/2012',103)	),
(6170,	'Cliente E',	CONVERT(DATE,'18/12/2012',103)),
(7404,	'Cliente F',	CONVERT(DATE,'20/01/2013',103)),
(8638,	'Cliente G',CONVERT(DATE,'25/01/2013',103)	)


INSERT INTO contratos VALUES 
(1234,	3,	1,	'E',CONVERT(DATE,'15/10/2012',103)	),
(1234,	3,	3,	'E',CONVERT(DATE,'15/10/2012',103)	),
(1234,	3,	3,	'A',CONVERT(DATE,'16/10/2012',103)	),
(1234,	3,	1,	'A',CONVERT(DATE,'16/10/2012',103)	),
(2468,	4,	4,	'E',CONVERT(DATE,'20/11/2012',103)	),
(2468,	4,	4,	'A',CONVERT(DATE,'21/11/2012',103)	),
(6170,	6,	2,	'E',CONVERT(DATE,'18/12/2012',103)	),
(6170,	6,	5,	'E',CONVERT(DATE,'19/12/2012',103)	),
(6170,	6,	2,	'A',CONVERT(DATE,'20/12/2012',103)	),
(6170,	6,	5,	'A',CONVERT(DATE,'21/12/2012',103)	),
(1234,	3,	1,	'D',CONVERT(DATE,'10/01/2013',103)	),
(1234,	3,	3,	'D',CONVERT(DATE,'10/01/2013',103)	),
(1234,	2,	1,	'E',CONVERT(DATE,'10/01/2013',103)	),
(1234,	2,	1,	'A',CONVERT(DATE,'11/01/2013',103)	),
(2468,	4,	4,	'D',CONVERT(DATE,'25/01/2013',103)	),
(7404,	2,	1,	'E',CONVERT(DATE,'20/01/2013',103)	),
(7404,	2,	5,	'E',CONVERT(DATE,'20/01/2013',103)	),
(7404,	2,	5,	'A',CONVERT(DATE,'21/01/2013',103)	),
(7404,	2,	1,	'A',CONVERT(DATE,'22/01/2013',103)	),
(8638,	6,	5,	'E',CONVERT(DATE,'25/01/2013',103)	),
(8638,	6,	5,	'A',CONVERT(DATE,'26/01/2013',103)	),
(7404,	2,	5,	'D',CONVERT(DATE,'03/02/2013',103)	)

-- Consultar o nome do cliente, o nome do plano, a quantidade de estados de contrato (sem repetições) por contrato, dos planos cancelados, ordenados pelo nome do cliente

SELECT c.nome_cliente AS nome_cliente, p.nome_plano AS plano, COUNT (co.status_contrato) AS planos_cancelados
FROM  cliente c,  contratos co, plano p
WHERE c.cod_cliente = co.cod_cliente
   AND p.cod_plano = co.cod_plano
GROUP BY c.nome_cliente, p.nome_plano, co.status_contrato
HAVING (co.status_contrato = 'D')
ORDER BY c.nome_cliente

-- Consultar o nome do cliente, o nome do plano, a quantidade de estados de contrato (sem repetições) por contrato, dos planos não cancelados, ordenados pelo nome do cliente										

SELECT DISTINCT c.nome_cliente AS nome_cliente, p.nome_plano AS plano, COUNT (co.status_contrato) AS planos_nao_cancelados
FROM  cliente c,  contratos co, plano p
WHERE c.cod_cliente = co.cod_cliente
   AND p.cod_plano = co.cod_plano
GROUP BY c.nome_cliente, p.nome_plano, co.status_contrato
HAVING (co.status_contrato <> 'D')
ORDER BY c.nome_cliente

-- Consultar o nome do cliente, o nome do plano, e o valor da conta de cada contrato que está ou esteve ativo, sob as seguintes condições:								
	-- A conta é o valor do plano, somado à soma dos valores de todos os serviços							
	-- Caso a conta tenha valor superior a R$400.00, deverá ser incluído um desconto de 8%							
	-- Caso a conta tenha valor entre R$300,00 a R$400.00, deverá ser incluído um desconto de 5%							
	-- Caso a conta tenha valor entre R$200,00 a R$300.00, deverá ser incluído um desconto de 3%							
	-- Contas com valor inferiores a R$200,00 não tem desconto							

SELECT c.nome_cliente AS nome_cliente, p.nome_plano AS plano, 
CASE WHEN ((s.valor_servico + p.valor_plano) > 400.00)
		THEN 
		((s.valor_servico + p.valor_plano) * 0.92)
		WHEN ((s.valor_servico + p.valor_plano) >= 300.00 AND (s.valor_servico + p.valor_plano) <= 400.00)
		THEN
		((s.valor_servico + p.valor_plano) * 0.95)
		WHEN ((s.valor_servico + p.valor_plano) >= 200.00 AND (s.valor_servico + p.valor_plano) <= 300.00)
		THEN 
		((s.valor_servico + p.valor_plano) * 0.97)
		ELSE 
		(s.valor_servico + p.valor_plano)
		END AS valor_conta
FROM cliente c, plano p, contratos co, servico s
WHERE c.cod_cliente = co.cod_cliente
AND co.cod_plano = p.cod_plano
AND co.cod_servico = s.cod_servico
GROUP BY c.nome_cliente, p.nome_plano, co.status_contrato, s.valor_servico , p.valor_plano
HAVING (co.status_contrato = 'A' OR co.status_contrato = 'E')
ORDER BY c.nome_cliente

-- Consultar o nome do cliente, o nome do serviço, e a duração, em meses (até a data de hoje) do serviço, dos cliente que nunca cancelaram nenhum plano									

SELECT c.nome_cliente AS cliente, s.nome_servico AS servico, DATEDIFF(MONTH,co.dat, GETDATE()) AS meses_de_servico
FROM cliente c, servico s, contratos co
WHERE c.cod_cliente = co.cod_cliente
AND co.cod_servico = s.cod_servico
GROUP BY c.nome_cliente, s.nome_servico, co.status_contrato, co.dat
HAVING (co.status_contrato <> 'D')
ORDER BY c.nome_cliente, s.nome_servico
