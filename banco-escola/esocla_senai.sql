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
    sexo ENUM('M', 'F')
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

select * from aluno