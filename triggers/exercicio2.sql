create database comercio
go
use comercio

create table cliente(
codigo INT NOT NULL,
nome VARCHAR(50) NOT NULL,
PRIMARY KEY (codigo)
)

INSERT INTO cliente values 
(1,'cliente 1'),
(2,'cliente 2'),
(3,'cliente 3'),
(4,'cliente 4'),
(5,'cliente 5')

create table pontos(
codigo_cliente INT NOT NULL,
total_pontos INT,
PRIMARY KEY (codigo_cliente),
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo)
)

DROP TABLE venda

create table venda(
codigo_venda INT IDENTITY(1,1),
codigo_cliente INT NOT NULL,
valor_total DECIMAL(7,2) NOT NULL,
PRIMARY KEY (codigo_venda),
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo))

INSERT INTO venda values
(5,100.00)

select * from venda
select * from pontos

CREATE TRIGGER t_vendadelete ON Venda
AFTER DELETE
AS
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Não se pode deletar registros da tabela venda', 16, 1)
END

CREATE TRIGGER t_vendaupdate ON Venda
INSTEAD OF UPDATE
AS
BEGIN
	select c.nome,v.valor_total from cliente c, venda v where c.codigo = v.codigo_cliente and v.codigo_venda = (select MAX(codigo_venda) from venda)
END

update venda set valor_total = 600.00 where venda.codigo_cliente = 1
select * from venda

CREATE TRIGGER t_vendainsert ON Venda
AFTER INSERT
AS
BEGIN
     DECLARE @codigo_cliente INT, @pontos DECIMAL(7,2)

	 SET @pontos = (select valor_total from inserted) * 0.1;
	 SET @codigo_cliente = (select codigo_cliente from inserted)
	 IF(0 = (select COUNT(p.codigo_cliente) from pontos p where p.codigo_cliente = @codigo_cliente))
	 BEGIN
	   insert into pontos values (@codigo_cliente, @pontos)
	 END
	 ELSE
	 BEGIN
	   update Pontos set  total_pontos = total_pontos + @pontos where codigo_cliente = @codigo_cliente
	 END

	IF (select total_pontos from Pontos where codigo_cliente = @codigo_cliente) >= 1
	BEGIN
		print 'Ganhou'
	END
END

