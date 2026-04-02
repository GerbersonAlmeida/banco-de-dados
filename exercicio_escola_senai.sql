DROP DATABASE escola_senai;

CREATE DATABASE escola_senai;

USE escola_senai;

CREATE TABLE tb_curso(
	cod_curs INT PRIMARY KEY AUTO_INCREMENT,
    nome_curs VARCHAR(45),
    per_curs ENUM("MATUTINO", "VESPERTINO", "NOTURNO"),
    dur_curs TIME,
    valor_curs DECIMAL(9,2)
);


