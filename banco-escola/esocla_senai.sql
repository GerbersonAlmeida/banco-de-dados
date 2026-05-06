CREATE DATABASE escola_senai1;

USE escola_senai1;

CREATE TABLE campus(
	cod_camp INT PRIMARY KEY AUTO_INCREMENT,
    cidade VARCHAR(50),
    endereco VARCHAR(500)
);

CREATE TABLE curso(
	cod_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curs VARCHAR(255),
	turno VARCHAR(50),
	semestre INT,
    valor DECIMAL(6, 2),
    campus_cod INT,
    FOREIGN KEY (campus_cod) REFERENCES campus(cod_camp)
);

CREATE TABLE aluno(
	ra INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    dt_nasc DATE,
    cpf VARCHAR(16),
    sexo ENUM('M', 'F', 'C')
);

CREATE TABLE matricula(
	cod_mat INT PRIMARY KEY AUTO_INCREMENT,
    dt_mat DATE,
    rua VARCHAR(255),
    id_aluno INT,
	id_curso INT,
    FOREIGN KEY (id_aluno) REFERENCES aluno(ra),
    FOREIGN KEY (id_curso) REFERENCES curso(cod_curso) 
);
-- 1 busca - Lista de todos os cursos do campus de Vitória
SELECT C.nome_curs, CA.cidade
FROM curso AS C
JOIN aluno AS A
ON CA.cod_camp = C.campus_cod
WHERE CA.cidade = "VITORIA";

-- 2 busca - Lista de todos os cursos em ordem Alfabética
SELECT nome_curs
FROM curso AS C
ORDER BY nome_curs ASC;

-- 3 Quais os 5 cursos mais caros?
SELECT nome_curs, valor
FROM curso AS C
ORDER BY valor DESC
LIMIT 5;

-- 4 busca - Qual curso é o mais barato no Campus da Serra?
SELECT C.nome_curs, C.valor, CA.cidade
FROM curso AS C
JOIN campus AS CA
ON CA.cod_camp = C.campus_cod
WHERE CA.cidade = "SERRA"
ORDER BY C.valor ASC
LIMIT 1;

-- 5 busca - Qual o turno com mais cursos disponíveis?
SELECT  turno, COUNT(turno) as contagem
FROM curso AS C
GROUP BY turno
ORDER BY contagem DESC
LIMIT 2;

-- 6 busca - Quantos cursos duram mais de dois anos e meio?
SELECT COUNT(semestre) AS maiores
FROM curso AS C
WHERE semestre > 5; -- maior do que 5 porque 5 semestres passam de 2 anos

-- 7 busca - Quais os cursos com maior quantidade de alunos inscritos?
SELECT C.nome_curs, COUNT(nome_curs) as contagem
FROM matricula AS M
JOIN curso AS C
ON M.id_curso = C.cod_curso
GROUP BY c.nome_curs
HAVING contagem = 8
ORDER BY contagem DESC;

-- 8 busca - Qual a média de preço dos cursos listados?
SELECT AVG(valor) AS media_preco
FROM curso;

-- 9 busca - Quais cursos duram mais tempo
SELECT  nome_curs, semestre
FROM curso AS C
WHERE semestre = (SELECT max(semestre) FROM curso);

-- 10 busca - Quantos alunos estão matriculados em cada turno?
SELECT C.turno, COUNT(C.turno) AS total
FROM curso AS C
JOIN matricula AS M
ON M.id_curso = C.cod_curso
GROUP BY C.turno;

-- 11 busca - Qual o campus com mais cursos?
SELECT CA.cidade, COUNT(CA.cidade) AS total
FROM campus AS CA
JOIN curso AS c
ON CA.cod_camp = C.campus_cod
GROUP BY CA.cidade
ORDER BY total DESC
LIMIT 1;

-- 12 busca - Quais cursos não possuem alunos cadastrados?
SELECT nome_curs, cod_mat
FROM curso AS C
LEFT JOIN matricula AS M
ON M.id_curso = C.cod_curso
WHERE M.cod_mat IS NULL;

-- 13 busca - Quem se matriculou em 2021?
SELECT nome, dt_mat
FROM aluno AS A
JOIN matricula AS M
ON A.ra = M.id_aluno
WHERE dt_mat BETWEEN '2021-01-01' AND '2021-12-31';

-- 14 busca - Qual a data de matrícula da aluna “Fernanda Lima”?
SELECT A.nome, M.dt_mat
FROM aluno AS A
JOIN matricula AS M
ON A.ra = M.id_aluno
WHERE A.nome = "Fernanda Lima";

-- 15 busca - Quais alunos não se cadastraram em nenhum curso?
SELECT nome, cod_mat
FROM aluno AS A
JOIN matricula AS M
ON A.ra = M.id_aluno
WHERE M.cod_mat IS NULL;

-- 16 busca - Quais alunos não se cadastraram em nenhum curso?
SELECT A.nome, M.dt_mat
FROM aluno AS A
JOIN matricula AS M
ON A.ra = M.id_aluno
WHERE A.nome = "Fernanda Lima";

-- 17 busca - Quais alunos estão matriculados 3 cursos?
SELECT nome, COUNT(M.id_aluno) AS vezes
FROM aluno AS A
JOIN matricula AS M
ON A.ra = M.id_aluno
GROUP BY A.nome
HAVING vezes = 3;

-- 18 busca - Qual o curso do aluno “Guilherme Costa”? 
SELECT *
FROM vw_alunos_e_cursos
WHERE aluno = "Guilherme Costa";

-- 19 busca - Quais os alunos matriculados em “Ciência da computação”
SELECT *
FROM vw_alunos_e_cursos
WHERE curso = "CIencia da computação";


-- 20 busca - Relação completa de todos os alunos e seus cursos
CREATE VIEW vw_alunos_e_cursos AS
	SELECT A.nome AS aluno, C.nome_curs AS curso
	FROM matricula AS M
	JOIN aluno AS A
		ON A.ra = M.id_aluno
	JOIN curso AS C
		ON C.cod_curso = M.id_curso;
        
SELECT *
FROM vw_alunos_e_cursos;
