CREATE DATABASE comercio
GO
USE comercio

CREATE TABLE cliente(
cpf CHAR(11),
nome VARCHAR(50) NOT NULL,
telefone CHAR(9) NOT NULL,
email VARCHAR(100) NOT NULL,
PRIMARY KEY (cpf))

CREATE TABLE produto(
codigo INT IDENTITY,
nome VARCHAR(50) NOT NULL,
descricao VARCHAR(200) NOT NULL,
valor_unitario DECIMAL(7,2) NOT NULL,
PRIMARY KEY (codigo)
)

CREATE TABLE venda(
cpf_cliente CHAR(11),
codigo_produto INT,
quantidade INT NOT NULL,
dt DATE,
PRIMARY KEY (cpf_cliente, codigo_produto),
FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
FOREIGN KEY (codigo_produto) REFERENCES produto(codigo))

INSERT INTO cliente VALUES
('11111111111', 'Fulano', '999999999', 'fulano@gmail.com' ),
('22222222222', 'Cicrano', '888888888', 'cicrano@gmail.com' )

INSERT INTO produto VALUES
('placa de video','gtx 2080 TI super poderosa', 5000.00),
('placa mãe',' asus rogue sei lá oq', 3000.00)

INSERT INTO venda VALUES
('11111111111',1,20,'06/03/2021'),
('22222222222',2,30,'06/03/2021'),
('11111111111',2,10,'12/03/2021')

select * from venda


CREATE FUNCTION fn_total()
RETURNS @table TABLE (
nome_cliente VARCHAR(50),
nome_produto VARCHAR(50),
quantidade INT,
valor_total DECIMAL(10,2)
)
AS
BEGIN
	INSERT INTO @table (nome_cliente, nome_produto, quantidade, valor_total)
		SELECT c.nome, p.codigo, v.quantidade, (v.quantidade*p.valor_unitario) FROM cliente c, produto p, venda v
		WHERE c.cpf = v.cpf_cliente AND v.codigo_produto = p.codigo
 
	RETURN
END


CREATE FUNCTION fn_somaultimacompra(@cpf INT)
RETURNS DECIMAL(20,2)
AS
BEGIN
	RETURN (SELECT SUM(p.valor_unitario * v.quantidade) FROM cliente c, produto p , venda v 
			WHERE c.cpf = v.cpf_cliente and v.codigo_produto = p.codigo and v.cpf_cliente = @cpf
			and v.dt = (select MAX(v.dt) from venda v where v.cpf_cliente = @cpf))
END
