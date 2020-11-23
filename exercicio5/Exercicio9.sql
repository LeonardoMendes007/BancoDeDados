CREATE DATABASE livraria_exe9
GO 
USE livraria_exe9

CREATE TABLE editora (
codigo INT IDENTITY,
nome VARCHAR(50) NOT NULL,
sites VARCHAR (100) NULL,
PRIMARY KEY (codigo)
)

CREATE TABLE autor (
codigo INT IDENTITY(101,1),
nome VARCHAR(100) NOT NULL,
breve_biografia VARCHAR(100) NOT NULL,
PRIMARY KEY (codigo)
)


CREATE TABLE estoque (
codigo INT IDENTITY(10001,1),
nome VARCHAR(100) NOT NULL UNIQUE,
quantidade INT NOT NULL,
valor DECIMAL(7,2) NOT NULL CHECK( valor > 0 ),
cod_editora INT NOT NULL,
cod_autor INT NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (cod_editora) REFERENCES editora (codigo),
FOREIGN KEY (cod_autor) REFERENCES autor (codigo)
)

CREATE TABLE compras (
codigo INT NOT NULL,
cod_livro INT NOT NULL,
qtd_comprada INT NOT NULL CHECK ( qtd_comprada > 0 ),
valor DECIMAL(7,2) NOT NULL, CHECK ( valor > 0 ), 
data_compra DATE NOT NULL,
PRIMARY KEY (codigo, cod_livro),
FOREIGN KEY (cod_livro) REFERENCES estoque (codigo)
)

INSERT INTO editora VALUES
('Pearson',	'www.pearson.com.br'),
('Civilização Brasileira', NULL),	
('Makron Books',	'www.mbooks.com.br'),
('LTC',	'www.ltceditora.com.br'),
('Atual',	'www.atualeditora.com.br'),
('Moderna',	'www.moderna.com.br')

INSERT INTO autor VALUES 
('Andrew Tannenbaun',	'Desenvolvedor do Minix'),
('Fernando Henrique Cardoso',	'Ex-Presidente do Brasil'),
('Diva Marília Flemming',	'Professora adjunta da UFSC'),
('David Halliday',	'Ph.D. da University of Pittsburgh'),
('Alfredo Steinbruch',	'Professor de Matemática da UFRS e da PUCRS'),
('Willian Roberto Cereja',	'Doutorado em Lingüística Aplicada e Estudos da Linguagem'),
('William Stallings',	'Doutorado em Ciências da Computacão pelo MIT'),
('Carlos Morimoto',	'Criador do Kurumin Linux')

INSERT INTO estoque VALUES 
('Sistemas Operacionais Modernos', 	4,	108.00,	1,	101),
('A Arte da Política',	2,	55.00,	2,	102),
('Calculo A',	12,	79.00,	3,	103),
('Fundamentos de Física I',	26,	68.00,	4,	104),
('Geometria Analítica',	1,	95.00,	3,	105),
('Gramática Reflexiva',	10,	49.00,	5,	106),
('Fundamentos de Física III',	1,	78.00,	4,	104),
('Calculo B',	3,	95.00,	3,	103)

INSERT INTO compras VALUES
(15051,	10003,	2,	158.00,	'04/07/2020'),
(15051,	10008,	1,	95.00,	'04/07/2020'),
(15051,	10004,	1,	68.00,	'04/07/2020'),
(15051,	10007,	1,	78.00,	'04/07/2020'),
(15052,	10006,	1,	49.00,	'05/07/2020'),
(15052,	10002,	3,	165.00,	'05/07/2020'),
(15053,	10001,	1,	108.00,	'05/07/2020'),
(15054,	10003,	1,	79.00,	'06/08/2020'),
(15054,	10008,	1,	95.00,	'06/08/2020')

SELECT * FROM autor

SELECT * FROM editora

SELECT * FROM estoque

--Consultar nome, valor unitário, nome da editora e nome do autor dos livros do estoque que foram vendidos. Não podem haver repetições.	

SELECT  e.nome, e.valor, ed.nome, a.nome
FROM estoque e, editora ed, autor a, compras c
WHERE e.cod_editora = ed.codigo
AND e.cod_autor = a.codigo
AND c.cod_livro = e.codigo
GROUP BY e.nome, e.valor, ed.nome, a.nome

--Consultar nome do livro, quantidade comprada e valor de compra da compra 15051

SELECT  e.nome, c.qtd_comprada, c.valor
FROM estoque e, compras c
WHERE c.cod_livro = e.codigo
AND c.codigo = '15051'

--Consultar Nome do livro e site da editora dos livros da Makron books (Caso o site tenha mais de 10 dígitos, remover o www.).			

SELECT  e.nome, 
CASE WHEN (LEN(ed.sites) > 10)
THEN REPLACE(ed.sites,'www.','')
WHEN (LEN(ed.sites) < 10) 
THEN ed.sites
END AS site
FROM estoque e, editora ed
WHERE e.cod_editora = ed.codigo
AND ed.nome = 'Makron books'

--Consultar nome do livro e Breve Biografia do David Halliday	

SELECT e.nome, a.breve_biografia AS biografia
FROM estoque e,  autor a
WHERE e.cod_autor = a.codigo
AND a.nome = 'David Halliday'


--Consultar código de compra e quantidade comprada do livro Sistemas Operacionais Modernos							

SELECT c.codigo, c.qtd_comprada AS quatidade
FROM compras c, estoque e
WHERE c.cod_livro = e.codigo
AND e.nome = 'Sistemas Operacionais Modernos'

--Consultar quais livros não foram vendidos		

SELECT e.nome
FROM compras c RIGHT JOIN estoque e
ON c.cod_livro = e.codigo
WHERE c.codigo IS NULL

--Consultar quais livros foram vendidos e não estão cadastrados		

SELECT c.cod_livro
FROM compras c RIGHT JOIN estoque e
ON c.cod_livro = e.codigo
WHERE e.codigo IS NULL

--Consultar Nome e site da editora que não tem Livros no estoque (Caso o site tenha mais de 10 dígitos, remover o www.)			

SELECT  ed.nome, 
CASE WHEN (LEN(ed.sites) > 10)
THEN REPLACE(ed.sites,'www.','')
WHEN (LEN(ed.sites) < 10) 
THEN ed.sites
END AS site
FROM estoque e, editora ed
WHERE e.cod_editora = ed.codigo
AND e.quantidade = 0

--Consultar Nome e biografia do autor que não tem Livros no estoque (Caso a biografia inicie com Doutorado, substituir por Ph.D.)	

SELECT  a.nome, a.breve_biografia
FROM autor a, estoque e
WHERE e.cod_autor = a.codigo
AND e.quantidade = 0

--Consultar o nome do Autor, e o maior valor de Livro no estoque. Ordenar por valor descendente		

SELECT  a.nome, MAX(e.valor) AS livro_mais_caro
FROM autor a, estoque e
WHERE e.cod_autor = a.codigo
GROUP BY a.nome
ORDER BY livro_mais_caro DESC

--Consultar o código da compra, o total de livros comprados e a soma dos valores gastos. Ordenar por Código da Compra ascendente.

SELECT c.codigo, SUM(c.qtd_comprada) AS quantidade, SUM(c.valor) AS valor_total_compra
FROM compras c, estoque e
WHERE c.cod_livro = e.codigo
GROUP BY c.codigo
ORDER BY c.codigo

--Consultar o nome da editora e a média de preços dos livros em estoque.Ordenar pela Média de Valores ascendente.

SELECT ed.nome, CAST(AVG(e.valor) AS DECIMAL(7,2)) AS média
FROM estoque e, editora ed
WHERE e.cod_editora = ed.codigo
GROUP BY ed.nome

--Consultar o nome do Livro, a quantidade em estoque o nome da editora, o site da editora (Caso o site tenha mais de 10 dígitos, remover o www.), criar uma coluna status onde:												
--	Caso tenha menos de 5 livros em estoque, escrever Produto em Ponto de Pedido											
--	Caso tenha entre 5 e 10 livros em estoque, escrever Produto Acabando											
--	Caso tenha mais de 10 livros em estoque, escrever Estoque Suficiente											
--	A Ordenação deve ser por Quantidade ascendente							

SELECT e.nome, e.quantidade, ed.nome,
CASE WHEN (LEN(ed.sites) > 10)
THEN REPLACE(ed.sites,'www.','')
WHEN (LEN(ed.sites) < 10) 
THEN ed.sites
END AS site,
CASE WHEN (e.quantidade < 5)
THEN 'Produto em Ponto de Pedido'
WHEN (e.quantidade <= 10 AND e.quantidade >= 5) 
THEN 'Produto Acabando'
WHEN (e.quantidade > 10) 
THEN 'Estoque Suficiente'
END AS status
FROM estoque e, editora ed
WHERE e.cod_editora = ed.codigo
ORDER BY e.quantidade

--Para montar um relatório, é necessário montar uma consulta com a seguinte saída: Código do Livro, Nome do Livro, Nome do Autor, Info Editora (Nome da Editora + Site) de todos os livros												
--	Só pode concatenar sites que não são nulos											
									
SELECT  e.codigo, e.nome, a.nome AS autor, ed.nome + ISNULL( ' - ' + ed.sites,'') AS editora 
FROM autor a, estoque e, editora ed
WHERE e.cod_autor = a.codigo
AND e.cod_editora = ed.codigo

--Consultar Codigo da compra, quantos dias da compra até hoje e quantos meses da compra até hoje		

SELECT DISTINCT c.codigo, DATEDIFF(DAY, c.data_compra, GETDATE()) AS dias_passados_compra, DATEDIFF(MONTH, c.data_compra, GETDATE()) AS meses_passados_compra  
FROM compras c

--Consultar o código da compra e a soma dos valores gastos das compras que somam mais de 200.00		

SELECT c.codigo, SUM(c.valor) AS valor_total 
FROM compras c
GROUP BY c.codigo
HAVING (SUM(c.valor) > 200)