-- Criando o banco
CREATE DATABASE spotify;

-- Utilizando o banco para realizar as operações
USE spotify;

-- criando a tabela 
CREATE TABLE top(
	posicao INT PRIMARY KEY AUTO_INCREMENT,
    artista VARCHAR(50),
    musica VARCHAR(255),
    dias INT,
    top_vezes DOUBLE,
    maior_posicao INT,
    vezes_maior_posicao VARCHAR(10),
    pico_streams INT,
    total_streams INT
    );  
    
    
SELECT * FROM spotify.top;

-- filtando colunas
SELECT posicao, artista, musica FROM top;

-- filtrando com WHERE
-- selecione na coluna "posicao, artista , musica"
SELECT posicao, artista, musica 
-- na tabela "top"
FROM top 
-- onde o dado dentro da coluna artista for igual a "TravisScott"
WHERE artista = "Travis Scott";

-- filtrando com operadores relacionais >, <, <>, <=, >=
SELECT *
FROM top
WHERE top_vezes > 100;

-- filtrando com operadores logicos - AND, OR, NOT
SELECT *
FROM top
WHERE artista = "SZA" AND maior_posicao = 5;

-- ordenando = ORDER BY, ASC = DE CIMA PARA BAIXO, DESC = DE BAIXO PARA CIMA
SELECT artista, musica
FROM top
ORDER BY artista ASC;

-- ENTRE = BETWEEN
SELECT *
FROM top
WHERE maior_posicao BETWEEN 10 AND 15
ORDER BY maior_posicao ASC;

-- IN - Dentro de uma lista
SELECT *
FROM top
WHERE artista IN ('Justin Bieber', 'Maroon 5', 'Queen');

SELECT *
FROM top
WHERE dias IN (20, 30, 40)
ORDER BY dias ASC;

-- LIKE - PESQUISA NOMES

-- No fim do texto haverá a palavra escrita 
SELECT artista, musica
FROM top
WHERE musica LIKE 'Super%';

-- NO inicio do texto haverá a palavra escrita
SELECT artista, musica
FROM top
WHERE musica LIKE '%Super';

-- Em algum lugar do texto haverá a palavra escrita entre os % %
SELECT artista, musica
FROM top
WHERE musica LIKE '%boy%';

-- COUNT - conta o retorno do resultado da pesquisa
SELECT COUNT(*) AS contagem
FROM TOP
WHERE artista = 'Travis Scott';

-- DISTINCT - registros diferentes 
SELECT DISTINCT artista AS diferente 
FROM top
ORDER BY artista;

-- contagem de artistas diferentes
SELECT COUNT(DISTINCT artista) AS diferente 
FROM top
ORDER BY artista;

-- agrupar resultados
SELECT artista, COUNT(artista) AS vezes
FROM top
GROUP BY artista;

-- LIMIT - limita os resultados 
SELECT *
FROM top
WHERE maior_posicao = 7
LIMIT 5;

-- SOMA DE RSULTADOS
SELECT SUM(total_streams) AS total_de_streams_da_tabela
FROM top;

-- Media de resultados
SELECT AVG(total_streams) AS media_de_streams_da_tabela
FROM top;

-- valor maximo de resultados
SELECT MAX(total_streams) AS maximo_de_streams_da_tabela
FROM top;

-- valor minimo de resultados
SELECT MIN(total_streams) AS media_de_streams_da_tabela
FROM top;

-- VERIFICA SE VALOR É NULO
SELECT *
FROM top
WHERE artista IS NULL;






-- 1 Contagem de quantos artistas estão com valor nulo no nome.
SELECT COUNT(artista) AS artistas_com_valor_nulo
FROM top
WHERE artista IS NULL;

-- 2 Contagem total de quantos registros tem na tabela.
SELECT COUNT(*)
FROM top;

-- 3 Contagem de quantas músicas estiveram no top 1.
SELECT COUNT(maior_posicao) AS total_musicas_maior_posicao
FROM top
WHERE maior_posicao = 1;

-- 4 Qual a música que ficou por mais vezes no top 1.
SELECT posicao, musica, artista, 
	CAST(REPLACE(REPLACE(REPLACE(vezes_maior_posicao, 'x', ''), '(', ''), ')', '') AS UNSIGNED) AS vezes
FROM top
WHERE maior_posicao = 1
ORDER BY vezes DESC
LIMIT 1;

-- 5 Quantos artistas diferentes há.
SELECT
	COUNT(DISTINCT artista) AS artistas
FROM top
ORDER BY posicao asc ;

-- 6 Qual música com mais streams.
SELECT musica, total_streams
FROM top
WHERE total_streams = (SELECT MAX(total_streams)
FROM top);

-- 7 Qual música com maior pico de streams.
SELECT musica, pico_streams
FROM top
WHERE pico_streams = (SELECT MAX(pico_streams)
FROM top);

-- 8 Qual artista ficou mais vezes no top 1.
select max(vezes_maior_posicao)
from top;










