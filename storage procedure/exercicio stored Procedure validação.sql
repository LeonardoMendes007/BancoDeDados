CREATE DATABASE cadastro
GO 
USE cadastro

CREATE TABLE pessoa(
cpf CHAR(11),
nome VARCHAR(80),
PRIMARY KEY (cpf)
)

CREATE PROCEDURE sp_validar_cpf(@CPF VARCHAR(14), @OUT BIT OUTPUT)
AS
	DECLARE @COUNT INT, @SOMA INT, @RESTO_DIGITO INT, @DIGITO INT, @NUM CHAR(2), @NUM_VERIFICADOR VARCHAR(2)
	SET @COUNT = 11
	SET @SOMA = 0

	-- Verificando se o cpf é composto de somente um algarismo e calculando número verificador

	IF(SUBSTRING(@CPF,1,10) != SUBSTRING(@CPF,2,11))
	BEGIN
	  SET @NUM = SUBSTRING(@CPF,10 ,11)
	  SET @CPF = SUBSTRING(@CPF,1 ,9)

	  WHILE(2 <= @COUNT)
	  BEGIN
  
	  SET @SOMA = @SOMA  + (@COUNT * CONVERT(INT, SUBSTRING(@CPF,11 - @COUNT ,1)))
	  SET @COUNT = @COUNT - 1;

	  END

	  SET @RESTO_DIGITO = (@SOMA % 11)

	  IF(2 <= @RESTO_DIGITO)
	  BEGIN
	  SET @DIGITO = 11 - @RESTO_DIGITO
	  END
	  ELSE
	  BEGIN
	  SET @DIGITO = 0
	  END

	  SET @CPF = @CPF + CONVERT(CHAR(1), @DIGITO)

	  SET @NUM_VERIFICADOR = CONVERT(CHAR(1), @DIGITO)

	  SET @COUNT = 11

	  SET @SOMA = 0

	  WHILE(2 <= @COUNT)
	  BEGIN

	  SET @SOMA = @SOMA  + (@COUNT * CONVERT(INT, SUBSTRING(@CPF,11 - (@COUNT-1) ,1)))
	  SET @COUNT = @COUNT - 1;

	  END

	  SET @RESTO_DIGITO = (@SOMA % 11)

	  IF(2 <= @RESTO_DIGITO)
	  BEGIN
	  SET @DIGITO = 11 - @RESTO_DIGITO
	  END
	  ELSE
	  BEGIN
	  SET @DIGITO = 0
	  END


	-- Verificando se o codigo verificador é válido

	  SET @NUM_VERIFICADOR =  @NUM_VERIFICADOR + CONVERT(CHAR(1), @DIGITO)

	  IF(@NUM_VERIFICADOR = @NUM)
	  BEGIN
	    SET @OUT = 1
	  END
	  ELSE
	  BEGIN
	    RAISERROR('O cpf é inválido.',16,1)
	  END
	END
	ELSE
	BEGIN
	  RAISERROR('O cpf é inválido, todos os algarismos são iguais.',16,1)
	END


CREATE PROCEDURE sp_insert_pessoa(@CPF VARCHAR(14), @NOME VARCHAR(80), @SAIDA VARCHAR(MAX) OUTPUT)
AS
        SET @CPF = REPLACE(@CPF, '.', '')
	    SET @CPF = REPLACE(@CPF, '-', '')

	    DECLARE @BIT_VALIDADOR_CPF BIT
		EXEC sp_validar_cpf @CPF, @BIT_VALIDADOR_CPF OUTPUT

        IF (LEN(@NOME) > 0 AND @BIT_VALIDADOR_CPF = 1)
		BEGIN
			INSERT INTO pessoa VALUES (@CPF,@NOME)
			SET @SAIDA = 'pessoa inserida com sucesso'
		END
		ELSE
		BEGIN
			--Tratamento de erro nome vázio
			IF (@NOME = '' OR @NOME IS NULL)
			BEGIN
				RAISERROR('O nome é vázio ou nulo', 16, 1)
			END
		END
        

DECLARE @SAIDA VARCHAR(MAX)
EXEC sp_insert_pessoa '222.333.666-38', 'leonardo', @SAIDA OUTPUT
PRINT @SAIDA

SELECT * FROM pessoa
