CREATE DATABASE querydinamica
GO
USE querydinamica

CREATE TABLE produto (
codigo INT,
nome VARCHAR(50),
valor DECIMAL(5,2),
PRIMARY KEY (codigo))

CREATE TABLE entrada(
codigo_transacao INT,
codigo_produto INT,
quantidade INT,
valor_total DECIMAL(5,2),
PRIMARY KEY (codigo_transacao)
)

CREATE TABLE saida(
codigo_transacao INT,
codigo_produto INT,
quantidade INT,
valor_total DECIMAL(5,2),
PRIMARY KEY (codigo_transacao)
)

CREATE PROCEDURE sp_inserirproduto(@codigo CHAR(5), @codigo_transacao INT,@codigo_produto INT, @quantidade INT)
AS
  DECLARE @query VARCHAR(MAX),@tabela VARCHAR(100),@valor_total DECIMAL(5,2)

  SET @codigo = lower(@codigo)

  IF (@codigo = 'e' or @codigo = 's')
  BEGIN
    IF(@codigo = 'e')
	BEGIN
	  SET @tabela = 'entrada'
	END
	ELSE
	BEGIN
	  SET @tabela = 'saida'
	END

	SET @valor_total = @quantidade * (select p.valor from produto p WHERE p.codigo = @codigo_produto )

	              
	SET @query = 'INSERT INTO '+@tabela+' VALUES ('+
				CAST(@codigo_transacao AS VARCHAR(5))+ ','+ CAST(@codigo_produto AS VARCHAR(5))+ ',' +CAST(@quantidade AS VARCHAR(5))+ ',' +CAST(@valor_total AS VARCHAR(50))+')'

	PRINT @query

	 EXEC (@query)
  END
  ELSE
  BEGIN
    RAISERROR('O código é inválido', 16,1)
  END


  INSERT INTO produto VALUES ('1','CALÇA',30.00)

  select * from produto

  EXEC sp_inserirproduto 'e',3, 1, 10

  select * from entrada
  select * from saida