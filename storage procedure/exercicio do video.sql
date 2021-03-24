CREATE DATABASE videoaulaproc
GO
USE videoaulaproc

CREATE TABLE cliente(
id INT NOT NULL,
nome VARCHAR(100),
telefone char(11),
dt_registro date,
PRIMARY KEY (id)
)
                
select * from cliente

CREATE PROCEDURE sp_inserecliente(@nome VARCHAR(100), @telefone CHAR(11), @saida VARCHAR(max) OUTPUT)
AS

DECLARE @count INT

IF(@nome != '' AND @telefone != '')
BEGIN

   SET @count = (select COUNT(cliente.id) from cliente) + 1
   
   INSERT INTO cliente VALUES (@count, @nome, @telefone, GETDATE())

   SET @saida = 'Inserido com sucesso!'
  
END
ELSE
BEGIN

  IF (@nome = '') 
  BEGIN
    SET @saida = 'O campo nome esta vázio.'
  END
  ELSE
  BEGIN
    SET @saida = 'O campo telefone esta vázio.'
  END

END