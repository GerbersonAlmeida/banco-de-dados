DROP DATABASE escola_senai;

CREATE DATABASE escola_senai;

USE escola_senai;

-- Criando aentidade curso
-- NA COLUNA dur_curs - FOI UTILIZADO O FORMATO INTEIRO PARA REPRESENTAR MINUTOS (total de minutos / 60 = horas totais)
CREATE TABLE tb_curso(
	cod_curs INT PRIMARY KEY AUTO_INCREMENT,
    nome_curs VARCHAR(45),
    per_curs ENUM("MATUTINO", "VESPERTINO", "NOTURNO"),
    dur_curs INT(10),
    valor_curs DECIMAL(9,2)
);

-- inserindo valores na tabela curso

INSERT INTO tb_curso
		VALUES
			(DEFAULT, "INFORMATICA", 2, 1800, 9000.00),
            (DEFAULT, "DESENVOLVIMENTO DE SISTEMAS", 3, 1800, 9000.00),
			(DEFAULT, "AUTOMAÇÃO", 1, 1800, 9000.00),
            (DEFAULT, "CYBER SEGURANÇA", 2, 1800, 9600.00),
            (DEFAULT, "REDES", 3, 1800, 9000.00);
            
SELECT * FROM tb_curso;
            
        
-- criando a entidade aluno
CREATE TABLE tb_aluno(
	ra_alun INT PRIMARY KEY AUTO_INCREMENT,
    nome_alu VARCHAR(255),
    dt_nasc_alu DATE,
    cpf_alU VARCHAR(15) NOT NULL,
    sexo_alu ENUM("MASCULINO","FEMININO")
);


INSERT INTO tb_aluno
	VALUES
		(DEFAULT, "ANTONIO", 20010323, "123678435-78", 1);
        
SELECT * FROM tb_aluno;

INSERT INTO tb_aluno
	VALUES
		(DEFAULT, "MAURO", 20030403, "126678435-71", 1),
        (DEFAULT, "ANA", 20060512, "123878435-48", 2),
        (DEFAULT, "CLARA", 20070813, "163678435-72", 2),
        (DEFAULT, "ALFREDO", 19960521, "123633435-34", 1),
		(DEFAULT, "GLAUBER", 20101121, "123568435-73", 1),
        (DEFAULT, "ANA", 20010323, "123678435-78", 1),
        (DEFAULT, "MELISSA", 20090220, "123678445-77", 2),
        (DEFAULT, "NATASHA", 20100614, "156678435-55", 2),
        (DEFAULT, "ALESSANDRO", 19970829, "123678435-68", 1);
        

        

-- Criando a entidade matricula
CREATE TABLE tb_matricula(
	cod_mat INT PRIMARY KEY AUTO_INCREMENT,
    ip_aluno INT,
    data_mat DATE NOT NULL,
    ip_curso INT,
    FOREIGN KEY (ip_aluno) REFERENCES tb_aluno(ra_alun),
    FOREIGN KEY (ip_curso) REFERENCES tb_curso(cod_curs)
    
);

-- declaraando valores na tabela tb_matriculas
	INSERT INTO tb_matricula
		VALUES
			(DEFAULT, 2, 20260912, 2),
			(DEFAULT, 1, 20260912, 3),
            (DEFAULT, 2, 20260912,3),
            (DEFAULT, 1, 20260912, 4),
            (DEFAULT, 3, 20260912, 2),
            (DEFAULT, 3, 20260912, 5),
            (DEFAULT, 3, 20260912, 4),
            (DEFAULT, 3, 20260912, 3),
            (DEFAULT, 4, 20260913, 1),
            (DEFAULT, 5, 20260913, 1),
            (DEFAULT, 6, 20260913, 1),
            (DEFAULT, 7, 20260914, 2),
            (DEFAULT, 7, 20260914, 3),
            (DEFAULT, 7, 20260914, 5),
            (DEFAULT, 8, 20260912, 1),
            (DEFAULT, 8, 20260912, 2),
            (DEFAULT, 8, 20260912, 3),
            (DEFAULT, 9, 20260912, 1),
            (DEFAULT, 9, 20260912, 2),
            (DEFAULT, 10, 20260912, 1);
            
SELECT * FROM tb_matricula;

-- utilizando JOIN para fazer uma consulta relacional com junção
SELECT
	m.cod_mat,
    a.ra_alun,
    a.nome_alu,
	c.cod_curs,
	c.nome_curs,
    m.data_mat
    FROM tb_matricula m
    JOIN tb_aluno a ON m.ip_aluno = a.ra_alun
    JOIN tb_curso c ON m.ip_curso = c.cod_curs
    WHERE cod_mat = 3;
    
	
	
            





