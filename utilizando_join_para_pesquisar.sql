CREATE DATABASE livraria;

USE livraria;

-- INNER JOIN - mostra o que tem em comum entre as tabelas
SELECT *
FROM autores AS A
JOIN livros AS L
ON A.autor_id = L.autor_id;

SELECT A.autor_id, L.titulo, A.name
FROM autores AS A
JOIN livros AS L
ON A.autor_id = L.autor_id;

-- LEFT JOIN - 
SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
LEFT JOIN livros AS L
ON A.autor_id = L.autor_id;

-- RIGHT JOIN - 
SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
RIGHT JOIN livros AS L
ON A.autor_id = L.autor_id;

-- LEFT EXCLUIDING JOIN
-- MOSTRA SO O QUE ESTA NA TABELA LEFT
-- NESSE CASO, MOSTRA SÓ OS AUTORES QUE NÃO TEM LIVRO ASSOCIADO
SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
LEFT JOIN livros AS L
ON A.autor_id = L.autor_id
WHERE L.livro_id IS NULL;

-- RIGHT EXCLUDING JOIN
-- MOSTRA SÓ O QUE ESTÁ NA TABELA RIGHT 
-- NESSE CASO, MOSTRA SÓ OS LIVROS QEU NÃO TEM AUTOR ASSOCIADO
SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
RIGHT JOIN livros AS L
ON A.autor_id = L.autor_id
WHERE A.autor_id = 0 OR A.autor_id IS NULL;

-- OUTER JOIN 
-- JUNÇÃO DE DOIS OU MAIS JOINS
SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
LEFT JOIN livros AS L
ON A.autor_id = L.autor_id

-- OPERADOR DE UNIÃO 
UNION

SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
RIGHT JOIN livros AS L
ON A.autor_id = L.autor_id;

-- OUTER EXCLUDING JOIN 
-- JUNÇÃO DOS DOIS JOINS

-- MOSTRA SO O QUE ESTA NA TABELA LEFT
-- NESSE CASO, MOSTRA SÓ OS AUTORES QUE NÃO TEM LIVRO ASSOCIADO
SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
LEFT JOIN livros AS L
ON A.autor_id = L.autor_id
WHERE L.livro_id IS NULL

-- OPERDOR PARA UNIR OS JOINS
UNION


-- RIGHT EXCLUDING JOIN
-- MOSTRA SÓ O QUE ESTÁ NA TABELA RIGHT 
-- NESSE CASO, MOSTRA SÓ OS LIVROS QEU NÃO TEM AUTOR ASSOCIADO
SELECT L.autor_id, L.titulo, A.name AS autor
FROM autores AS A
RIGHT JOIN livros AS L
ON A.autor_id = L.autor_id
WHERE A.autor_id = 0 OR A.autor_id IS NULL;

-- O JOIN MAIS TOP
-- JOIN COM TRES TABELA
-- SELECIONANDO A PRIMIEIRA TABELA
SELECT L.titulo, G.name AS genero, A.name AS autor
FROM livros AS L
-- faco juncão entre a tabela livros e a tabela autores
JOIN autores AS A
ON L.autor_id = A.autor_id
-- faco juncão entre a tabela livros e a tabela generos
JOIN generos AS G
ON G.genero_id = L.genero_id;

SELECT *
FROM autores;

SELECT *
FROM generos;

SELECT *
FROM livros;