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
SELECT artista, CAST(REPLACE(REPLACE(REPLACE(vezes_maior_posicao, 'x', ''), '(', ''), ')', '') AS UNSIGNED) AS mais_vezes_top
FROM top
WHERE maior_posicao = 1 
AND CAST(REPLACE(REPLACE(REPLACE(vezes_maior_posicao, 'x', ''), '(', ''), ')', '') AS UNSIGNED) > 0
ORDER BY mais_vezes_top DESC
LIMIT 1;

-- 9 Qual artista possui mais registros.
SELECT artista, COUNT(artista) AS registros
FROM top
GROUP BY artista
ORDER BY COUNT(artista) DESC
LIMIT 1;

-- 10 Quantos artistas possuem nome iniciando com a letra “H”.
SELECT COUNT(DISTINCT artista) AS artistas_comecam_com_h
FROM top
WHERE artista LIKE 'H%';

-- 11 Quais as músicas da artista “Anitta” estão na tabela.
SELECT posicao, musica, artista
FROM top
WHERE artista LIKE '%Anitta%';

-- 12 Quantas músicas passaram da marca de 500 mil streams.    
SELECT  COUNT(total_streams) AS total_streams_maior_500_mil
FROM top
WHERE total_streams > 500000;

-- 13 Qual a música no registro 3480.
SELECT  posicao, artista, musica
FROM top
WHERE posicao = 3480;

-- 14 Quantas músicas o artista “The Weeknd” possui e quais.
SELECT COUNT(musica) AS total_musicas
FROM top
WHERE artista LIKE '%The Weeknd%';

SELECT musica, artista
FROM top
WHERE artista LIKE '%The Weeknd%';

-- 15 Quantas músicas possuem “girl” no nome.
SELECT COUNT(musica) AS total_musicas_com_girl
FROM top
WHERE musica LIKE '%girl%';

-- 16 Qual o total de streams do artista “Post Malone”.
SELECT SUM(total_streams) total_streams_PostMalone
FROM top
WHERE artista LIKE '%Post Malone%';

-- 17 Quais são os 5 artistas com mais registros, de forma decrescente.
SELECT artista, COUNT(artista) AS vezes
FROM top
GROUP BY artista
ORDER BY COUNT(artista) DESC
LIMIT 5;

-- 18 Qual o total de streams das 10 músicas com mais streams.

-- 19 Quais as músicas que já estiveram no top 1 e estiveram 7 vezes na maior posição

-- 20 Quais músicas tiveram menos de 500 mil streams e ficaram entre o top 5 e 10.

-- 21 Qual a música com o mínimo de streams que atingiu a 1ª posição no top 10.

-- 22 Qual a música com o mínimo de streams da artista Taylor Swift.

