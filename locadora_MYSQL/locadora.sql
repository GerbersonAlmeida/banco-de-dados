CREATE DATABASE locadora;

USE locadora;

CREATE TABLE tb_Diretor(
	id_diretor INT PRIMARY KEY,
    Nome_dir VARCHAR(255)
);

CREATE TABLE tb_Filme(
	id_filme INT PRIMARY KEY,
    titulo VARCHAR(255),
    diretor_id INT,
    genero VARCHAR(255),
    ano_lancamento INT(4),
    class_indicativa INT,
    FOREIGN KEY (diretor_id) REFERENCES tb_Diretor(id_diretor)
);

CREATE TABLE tb_Cliente(
	id_cliente INT PRIMARY KEY,
    nome_cli VARCHAR(255),
    email VARCHAR(255),
    dt_nasc DATE,
    cpf VARCHAR(13),
    sexo ENUM("F", "M")
);

CREATE TABLE tb_Locacao(
	id_locacao INT PRIMARY KEY,
    cliente_id INT,
    filme_id INT,
    dt_emprestimo DATE,
    dt_prev_dev DATE,
    dt_devolucao DATE,
    FOREIGN KEY (cliente_id) REFERENCES tb_Cliente(id_Cliente),
	FOREIGN KEY (filme_id) REFERENCES tb_Filme(id_filme)
);

-- 1 Lista de todos os filmes do Steven Spielberg
SELECT f.titulo, d.nome_dir
FROM tb_Filme AS f
INNER JOIN tb_Diretor AS d 
ON f.diretor_id = d.id_diretor
WHERE d.nome_dir = "Steven Spielberg";

-- 2 Lista de todos os filmes por ordem de lançamento
SELECT f.titulo, f.ano_lancamento
FROM tb_Filme AS f
ORDER BY f.ano_lancamento ASC;

-- 3 Lista de todos os filmes por do gênero Drama e Romance
SELECT f.titulo, f.genero
FROM tb_Filme AS f
WHERE f.genero = "Drama" OR f.genero = "Romance";

-- 4 Lista de todos os filmes de terror com classificação de -18 anos
SELECT f.titulo, f.genero, f.class_indicativa
FROM tb_Filme AS f
WHERE f.genero = "terror" AND f.class_indicativa < 18;

-- 5 Qual o nome filme mais locado?
SELECT f.titulo, COUNT(f.titulo) AS vezes
FROM tb_Locacao AS l
INNER JOIN tb_filme AS f
ON l.filme_id = f.id_filme
GROUP BY l.filme_id
HAVING COUNT(Vezes) >= 4





	
