CREATE DATABASE func_dependente
GO
USE func_dependente

use master

drop database func_dependente

CREATE TABLE funcionario(
codigo INT IDENTITY,
nome VARCHAR(50) NOT NULL,
salario DECIMAL(7,2) NOT NULL,
PRIMARY KEY (codigo))

CREATE TABLE dependente(
codigo INT IDENTITY,
codigo_funcionario INT,
nome_dependente VARCHAR(50) NOT NULL,
salario_dependente DECIMAL(7,2) NOT NULL,
PRIMARY KEY (codigo)
)

INSERT INTO funcionario VALUES 
('Fulano',1400),
('Cicrano',2000),
('Cachubeira',700)

select * from funcionario

INSERT INTO dependente VALUES 
(1,'fulaninho',700),
(1,'fulaninha',500),
(2,'Cicraninho',1200),
(3,'Cachu',2000),
(3,'Cachubinha',1000)

select * from dependente

CREATE FUNCTION fn_func_depen()
RETURNS @table TABLE (
nome_funcionario		VARCHAR(50),
nome_dependentes		VARCHAR(50),
salario_funcionario		DECIMAL(7,2),
salario_dependente		DECIMAL(7,2)
)
AS
BEGIN
	INSERT INTO @table (nome_funcionario, nome_dependentes, salario_funcionario, salario_dependente)
		SELECT f.nome, d.nome_dependente, f.salario, d.salario_dependente FROM funcionario f , dependente d WHERE f.codigo = d.codigo_funcionario
 
	RETURN
END

SELECT * FROM fn_func_depen()


CREATE FUNCTION fn_calcsalario(@cod INT)
RETURNS DECIMAL(7,2)
AS
BEGIN
	DECLARE @salario	DECIMAL(7,2),
			@salario_dependente	DECIMAL(7,2),
			@total	DECIMAL(7,2)

		SELECT @salario = salario FROM funcionario
			WHERE codigo = @cod

        SELECT @salario_dependente = SUM(salario_dependente) FROM dependente WHERE codigo_funcionario = @cod
		SET @total = @salario + @salario_dependente
	RETURN (@total)
END

select dbo.fn_calcsalario(1) as soma_salario