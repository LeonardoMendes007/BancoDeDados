CREATE DATABASE academia
GO 
USE academia

use master

drop database academia

CREATE TABLE aluno(
codigo_aluno INT IDENTITY(1,1),
nome VARCHAR(80),
PRIMARY KEY (codigo_aluno)
)

CREATE TABLE atividade(
codigo INT IDENTITY(1,1),
descricao VARCHAR(200),
imc float,
PRIMARY KEY (codigo)
)

CREATE TABLE atividade_aluno(
codigo_aluno INT,
altura float,
peso float,
imc float,
atividade VARCHAR(200),
PRIMARY KEY (codigo_aluno),
FOREIGN KEY (codigo_aluno) REFERENCES aluno (codigo_aluno)
)

INSERT INTO atividade VALUES
('Corrida + Step', 18.5),
('Biceps + Costas + Pernas',24.9),
('Esteira + Biceps + Costas + Pernas',29.9),
('Bicicleta + Biceps + Costas + Pernas',34.9),
('Esteira + Bicicleta',39.9) 



CREATE PROCEDURE sp_alunoatividades(@codigo_aluno INT, @nome VARCHAR(80), @altura float, @peso float)
AS

DECLARE @imc float

IF( @altura IS NULL OR @altura <= 0 OR @peso IS NULL OR @peso <= 0)
BEGIN

  IF(@altura IS NULL OR @altura <= 0 )
  BEGIN
   RAISERROR('A altura é menor ou igual a 0',16,1)
  END
  ELSE
  BEGIN
   RAISERROR('O peso é menor ou igual a 0',16,1)
  END

END
ELSE
BEGIN

	SET @imc = @peso / (@altura*@altura) 

	IF(@codigo_aluno = '' OR @codigo_aluno IS NULL)
	BEGIN
  
	  IF(@nome = '' OR @nome IS NULL)
	  BEGIN
		RAISERROR('O codigo e o nome é nulo',16,1)
	  END
	  ELSE
	  BEGIN
		INSERT INTO aluno VALUES (@nome)

		INSERT INTO atividade_aluno VALUES 
		(@@IDENTITY, @altura, @peso, @imc, (SELECT a.descricao FROM atividade a WHERE a.codigo = (select max(codigo) from atividade where atividade.imc <= @imc)))
		print 'insert realizado com sucesso'
	  END

	END
	ELSE
	BEGIN

	  IF((SELECT a.codigo_aluno from atividade_aluno a WHERE a.codigo_aluno = @codigo_aluno) IS NULL)
	  BEGIN
		 RAISERROR('O codigo não existe na base de dados',16,1)
	  END
	  ELSE
	  BEGIN
		 UPDATE atividade_aluno SET altura = @altura, peso = @peso, imc = @imc, atividade = (SELECT a.descricao FROM atividade a WHERE a.codigo = (select max(codigo) from atividade where atividade.imc <= @imc)) where atividade_aluno.codigo_aluno = @codigo_aluno
		 print 'Update realizado com sucesso'
	 END
  
	END

END


EXEC sp_alunoatividades '','LEONARDO',1.80,80.0

select * from atividade_aluno

