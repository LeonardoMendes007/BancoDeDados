CREATE DATABASE inst_saude
GO
USE inst_saude

CREATE TABLE paciente(

cpf CHAR(11) NOT NULL,
nome VARCHAR(50) NOT NULL,
logradouro VARCHAR(100) NOT NULL,
num INT NOT NULL,
bairro VARCHAR(60) NOT NULL,
telefone CHAR(8),
PRIMARY KEY (cpf)

)

CREATE TABLE medico(

codigo INT IDENTITY(1,1),
nome VARCHAR(50) NOT NULL,
especialidade VARCHAR(20) NOT NULL,
PRIMARY KEY (codigo)

)

CREATE TABLE prontuario(

dt DATE NOT NULL,
cpf_paciente CHAR(11) NOT NULL,
codigo_medico INT NOT NULL,
diagnostico VARCHAR(60) NOT NULL,
medicamento VARCHAR(60) NOT NULL,
PRIMARY KEY (dt,cpf_paciente, codigo_medico),
FOREIGN KEY (cpf_paciente) REFERENCES paciente(cpf),
FOREIGN KEY (codigo_medico) REFERENCES medico(codigo)
)

INSERT INTO paciente VALUES
('35454562890',	'José Rubens',	'Campos Salles',	'2750',	'Centro',	'21450998'),
('29865439810',	'Ana Claudia',	'Sete de Setembro',	'178',	'Centro',	'97382764'),
('82176534800',	'Marcos Aurélio',	'Timóteo Penteado',	'236',	'Vila Galvão',	'68172651'),
('12386758770',	'Maria Rita',	'Castello Branco',	'7765',	'Vila Rosália',	 NULL),
('92173458910',	'Joana de Souza',	'XV de Novembro',	'298',	'Centro',	'21276578')

INSERT INTO medico VALUES
('Wilson Cesar',	'Pediatra'),
('Marcia Matos','Geriatra'),
('Carolina Oliveira',	'Ortopedista'),
('Vinicius Araujo',	'Clínico Geral')

INSERT INTO prontuario VALUES
(CONVERT(date, '10/09/2020', 103),	'35454562890',	'2',	'Reumatismo',	'Celebra'),
(CONVERT(date, '10/09/2020', 103),	'92173458910',	'2',	'Renite Alérgica',	'Allegra'),
(CONVERT(date, '12/09/2020', 103),	'29865439810',	'1',	'Inflamação de garganta',	'Nimesulida'),
(CONVERT(date, '13/09/2020', 103),	'35454562890',	'2',	'H1N1',	'Tamiflu'),
(CONVERT(date, '15/09/2020', 103),	'82176534800',	'4',	'Gripe',	'Resprin'),
(CONVERT(date, '15/09/2020', 103),	'12386758770',	'3',	'Braço Quebrado',	'Dorflex + Gesso')


--Consultas

SELECT especialidade FROM medico WHERE nome = 'Carolina Oliveira'

SELECT medicamento FROM prontuario WHERE diagnostico = 'reumatismo'

--Consultas usando subqueries

SELECT diagnostico, medicamento FROM prontuario
WHERE cpf_paciente IN (
SELECT cpf FROM paciente WHERE nome = 'José Rubens'
)

SELECT nome, SUBSTRING(especialidade,1,3) + '.' FROM medico 
WHERE codigo IN (

     SELECT codigo_medico FROM prontuario 
	 WHERE cpf_paciente IN (
           SELECT cpf FROM paciente WHERE nome = 'José Rubens'
     )
)

SELECT SUBSTRING(cpf,1,3) + '.' + SUBSTRING(cpf,4,3) + '.'+ SUBSTRING(cpf,7,3) + '-'+ SUBSTRING(cpf,10,2) AS cpf, nome, logradouro + ' ' + CAST(num AS VARCHAR(10)) + ' - ' + bairro AS endereco_completo, SUBSTRING(telefone, 1,4) + '-' + SUBSTRING(telefone,5,8) AS telefone FROM paciente
WHERE cpf IN (
     
	 SELECT cpf_paciente FROM prontuario 
	 WHERE codigo_medico IN (
	       SELECT codigo FROM medico WHERE nome = 'Vinicius Araujo'
	 )

)

SELECT DATEDIFF(DAY,dt,getdate()) AS dias_desde_ultima_consulta FROM prontuario
WHERE cpf_paciente IN (
     SELECT cpf FROM paciente WHERE nome = 'Maria Rita'

)

UPDATE paciente SET telefone = '98345621' WHERE nome = 'Maria Rita'

SELECT telefone FROM paciente WHERE nome = 'Maria Rita'

UPDATE paciente SET logradouro = 'Voluntários da Pátria', num = '1980', bairro = 'Jd. Aeroporto' WHERE nome = 'Joana de Souza'

SELECT * FROM paciente WHERE nome = 'Joana de Souza'