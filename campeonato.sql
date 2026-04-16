DROP DATABASE campeonato;
-- cria o banco
CREATE DATABASE campeonato;

-- usando o banco campeonato
USE campeonato;

-- cria a tabela equipe
CREATE TABLE tb_equipe (
	cod_equipe INT PRIMARY KEY AUTO_INCREMENT,
    nome_equipe VARCHAR(45) NOT NULL,
    sigla_equipe VARCHAR(3) UNIQUE,
    estado char (2)
);

-- cria tabela de jogador
CREATE TABLE tb_jogador(
	cod_jogador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    nascionalidade VARCHAR(50),
    -- DECIMAL - voce precisa utilizar dois parametros entre os parenteses, o primeiro é para a quantidade de casa inteiro, e o segundo é para as casas flutuantes
    altura DECIMAL(3,2),
    peso DECIMAL(6,2),
    idade INT,
    numero_camisa INT,
    posicao ENUM("GOLEIRO", "ZAGEIRO", "MEIO-CAMPO", "ATACANTE"),
    id_equipe INT,
    FOREIGN KEY (id_equipe) REFERENCES 	tb_equipe(cod_equipe)
);


-- CRUD  no banco
-- C = create
--  R = read
--   U = update
--    D = delete
-- INSERT INTO - é a função para inserir valores no banco de dados CRUD(CREATE)
-- FORMA 1 - com colunas
INSERT INTO tb_equipe(nome_equipe, sigla_equipe, estado)
				VALUES("Gama", "GAM", "DF");
-- FORMA 2 - sem colunas
INSERT INTO tb_equipe
VALUES 
	(DEFAULT, "Vasco da Gama ", "VAS", "RJ"),
    (DEFAULT, "Bota Fogo ", "BOT", "RJ"),
	(DEFAULT, "Fluminense ", "FLU", "RJ");

INSERT INTO tb_equipe(nome_equipe, sigla_equipe, estado)
	VALUES("Flamengo", "FLA", "RJ");
    
INSERT INTO tb_equipe
	VALUES
		(DEFAULT,"Bahia", "BHA", "BA"),
        (DEFAULT,"Real Madrid", "RMD", "AC"),
        (DEFAULT,"Manchester United", "MUN", "PA");

-- SELECT * FROM - é a função para mostrar os dados do banco CRUD(READ)
SELECT * FROM tb_equipe;

-- UPDATE - é a função para mudar valores no banco de dados CRUD(CREATE)
UPDATE tb_equipe
SET estado = "MD"
WHERE nome_equipe = "Real Madrid";

-- DELETE - é a função para deletar valores no banco de dados CRUD(CREATE)
DELETE FROM tb_equipe
WHERE cod_equipe = 1;
 
 INSERT INTO tb_jogador (nome, peso , numero_camisa, posicao, id_equipe)
						VALUES
							("Vinicius Junior", 73.0, 7, "ATACANTE", 7),
                            ("Bruno Henrique", 75.0, 11, "ATACANTE", 5),
                            ("Arascaeta", 74.0, 9, "ATACANTE", 5),
                            ("Rodrigo", 71.0, 11, 3, 7);
                            
							
							
UPDATE tb_jogador
SET cod_jogador =  6
WHERE cod_jogador = 1; 


SELECT * FROM tb_jogador;



