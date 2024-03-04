DESCRIBE CD;

SELECT * FROM CD;

SELECT Nome_CD, Data_Lancamento FROM CD;

SELECT 
    * 
FROM
    CD
WHERE
    Nome_CD LIKE '%a'; -- Aqui, % tem o mesmo significado que asterisco em uma busca no terminal!

SELECT 
    Nome_CD,
    Preco_Venda,
    Data_Lancamento
FROM 
    CD 
WHERE 
    Preco_Venda >= 13;
    
SELECT 
    Nome_CD, Preco_Venda, Data_Lancamento
FROM 
    CD 
WHERE 
    Preco_Venda >= 13
ORDER BY 
    Data_Lancamento DESC;
    
SELECT 
    Nome_CD, Preco_Venda, Data_Lancamento
FROM 
    CD 
WHERE 
    Preco_Venda >= 13
ORDER BY 
    3 DESC;
    
SELECT 
    Nome_CD
FROM 
    CD 
WHERE 
    Preco_Venda >= 13
ORDER BY 
    Data_Lancamento ASC
LIMIT 1;

SELECT 
    Nome_CD as cd,
    Preco_Venda as valor,
    Data_Lancamento as data_lanc
FROM 
    CD 
WHERE 
    Preco_Venda >= 13
ORDER BY 
    Data_Lancamento DESC;
    
SELECT * FROM musica;

SELECT 
	Nome_Musica as nome_musica_mais_longa,
    duracao as maior_duracao
FROM 
	musica
ORDER BY
	duracao DESC
limit 1;

SELECT * FROM gravadora;

SELECT Nome_gravadora FROM GRAVADORA where Endereco IS NULL;




SELECT
	Nome_CD
FROM
	CD
where
	year(Data_Lancamento) >= 1990
AND
	year(Data_Lancamento) <= 1999;
    
    
SELECT
	Nome_CD
FROM
	CD
WHERE
	year(Data_Lancamento) >= 1990
AND
	year(Data_Lancamento) <= 1999
AND Preco_Venda <= 10;



SELECT
	*
FROM
	CD;


SELECT
	DISTINCT CD_Indicado
FROM
	CD
WHERE
	CD_Indicado IS NOT NULL;