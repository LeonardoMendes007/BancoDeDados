-- Fazer um algoritmo que calcule a tabuada de um dado número
declare @a as int
declare @cont as int
set @a = 12
set @cont = 1
while @cont <= 10
	begin
		if @cont = 1
			begin
				print ((convert (char(2),@a)+' x 0 = '+convert (char(4),(@cont - 1))))
				print ((convert (char(2),@a)+' x 1 = '+convert (char(4),@a)))
				set @cont = @cont + 1
			end
		else
			begin
				print ((convert (char(2),@a)+' x '+(convert (varchar(2),@cont))+' = '+(convert (char(4),(@a*@cont)))))
				set @cont = @cont + 1
			end
	end


/*Fazer um algoritmo que leia 3 valores e retorne se os valores formam um triângulo e se ele é
isóceles, escaleno ou equilátero.
Condições para formar um triângulo
	Nenhum valor pode ser = 0
	Um lado não pode ser maior que a soma dos outros 2.
*/

DECLARE @X INT , @Y INT , @Z INT
SET @X = 6
SET @Y = 6
SET @Z = 6

IF(@X = 0 OR @Y = 0 OR @Z = 0)
BEGIN 
 PRINT 'Nenhum valor pode ser = 0' 
END
ELSE
BEGIN
 IF((@X + @Y) < @Z OR (@X + @Z) < @Y OR (@Y + @Z) < @X)
 BEGIN
  PRINT 'Um lado não pode ser maior que a soma dos outros 2'
 END
 ELSE
 BEGIN
  IF(@X = @Y AND @Y = @Z)
  BEGIN
   PRINT 'O TRIÂNGULO É EQUILATERO.'
  END
  ELSE
  BEGIN
   IF(@X = @Y OR @Y = @Z OR @Z = @X)
   BEGIN
    PRINT 'O TRIÂNGULO É ISÓCELES.'
   END
   ELSE
   BEGIN
    PRINT 'O TRIÂNGULO É ESCALENO' 
   END
  END
 END
END

-- Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles


DECLARE @VALOR INT

SET @VALOR = 0

IF(@VALOR % 2 = 0 AND @VALOR != 0)
BEGIN
  IF(@VALOR % 3 = 0)
  BEGIN
    IF(@VALOR % 5 = 0)
	BEGIN
	  PRINT 'O número ' + CONVERT(VARCHAR(5),@VALOR) + ' é múltiplo de 2,3,5.'
	END
	ELSE
	BEGIN
	  PRINT 'O número ' + CONVERT(VARCHAR(5),@VALOR) + ' é múltiplo de 2,3.'
	END
  END
  ELSE
  BEGIN
    IF(@VALOR % 5 = 0)
	BEGIN
	  PRINT 'O número ' + CONVERT(VARCHAR(5),@VALOR) + ' é múltiplo de 2,5.'
	END
	ELSE
	BEGIN
	  PRINT 'O número ' + CONVERT(VARCHAR(5),@VALOR) + ' é múltiplo de 2.'
	END
  END
END
ELSE
BEGIN 
 IF(@VALOR % 3 = 0 AND @VALOR != 0)
  BEGIN
    IF(@VALOR % 5 = 0 AND @VALOR != 0)
	BEGIN
	  PRINT 'O número ' + CONVERT(VARCHAR(5),@VALOR) + ' é múltiplo de 3,5.'
	END
	ELSE
	BEGIN
	  PRINT 'O número ' + CONVERT(VARCHAR(5),@VALOR) + ' é múltiplo de 3.'
	END
  END
  ELSE
  BEGIN
    IF(@VALOR % 5 = 0 AND @VALOR != 0)
	BEGIN
	  PRINT 'O número ' + CONVERT(VARCHAR(5),@VALOR) + ' é múltiplo de 5.'
	END
	ELSE
	BEGIN
	  PRINT 'O NÚMERO ' + CONVERT(VARCHAR(5),@VALOR) + ' NÃO E MÚLTIPLO DE NENHUM DOS TRÊS NÚMEROS.'
	END
    
  END
END

 -- Fazer um algoritmo que leia 3 número e mostre o maior e o menor

DECLARE @MAX INT, @MIN INT, @X1 INT,@X2 INT, @X3 INT

SET @X1 = 0
SET @X2 = 2
SET @X3 = 5

SET @MAX = @X1
SET @MIN = @X1

IF(@MAX < @X2)
BEGIN
  SET @MAX = @X2
END

IF(@MIN > @X2)
BEGIN
  SET @MIN = @X2
END

IF(@MAX < @X3)
BEGIN
  SET @MAX = @X3
END

IF(@MIN > @X3)
BEGIN
  SET @MIN = @X3
END


PRINT 'O MAIOR NÚMERO É ' + CONVERT(VARCHAR(5), @MAX)
PRINT 'O MENOR NÚMERO É ' + CONVERT(VARCHAR(5), @MIN)


/*
Fazer um algoritmo que calcule os 15 primeiros termos da série
1,1,2,3,5,8,13,21,...
E calcule a soma dos 15 termos
*/

DECLARE @OUT VARCHAR(100), @X1 INT, @X2 INT, @COUNT INT

SET @X1 = 1
SET @X2 = 0
SET @COUNT = 0
SET @OUT = ' '

WHILE(@COUNT < 15)
BEGIN

 IF(@COUNT != 0)
 BEGIN
  SET @OUT = @OUT + ','
 END

 IF(@COUNT % 2 = 0)
 BEGIN
  SET @X1 = @X1 + @X2
  SET @OUT = @OUT + ' ' + CONVERT(VARCHAR(3),@X1)
 END
 ELSE
 BEGIN
  SET @X2 = @X2 + @X1
  SET @OUT = @OUT + ' ' +  CONVERT(VARCHAR(3),@X2)
 END

 SET @COUNT = @COUNT + 1

END

PRINT @OUT


-- Fazer um algorimto que separa uma frase, colocando todas as letras em maiúsculo e em minúsculo

DECLARE @MAIUSCULO VARCHAR(100), @MINUSCULO VARCHAR(100), @FRASE VARCHAR(100)

SET @FRASE = 'Banco de dados é muito melhor que engenharia de software'
SET @MAIUSCULO = UPPER(@FRASE)
SET @MINUSCULO = LOWER(@FRASE)

PRINT @MAIUSCULO
PRINT @MINUSCULO

-- Fazer um algoritmo que inverta uma palavra

DECLARE @PALAVRA VARCHAR(50)

SET @PALAVRA = 'INVERTA'

PRINT REVERSE(@PALAVRA)


-- Verificar palindromo

DECLARE @PALAVRA VARCHAR(50), @PALAVRA_INVERSA VARCHAR(50)

SET @PALAVRA = 'INVERTA'
SET @PALAVRA_INVERSA = REVERSE(@PALAVRA)

IF(@PALAVRA = @PALAVRA_INVERSA)
BEGIN
  PRINT 'A palavra é um palindromo'
END
ELSE
BEGIN
  PRINT	'A palavra não é um palindromo'
END
