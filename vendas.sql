DROP  DATABASE IF EXISTS sistema_vendas;
-- CRIA O BANCO COM UTF CORRETO
CREATE DATABASE IF NOT EXISTS sistema_vendas
DEFAULT CHARACTER SET utf8mb4
collate utf8_unicode_ci;

USE sistema_vendas;
-- ----------------------------------------------
-- TABELA USUARIOS
-- ----------------------------------------------
CREATE TABLE IF NOT EXISTS usuarios(
id_usuario INT(11) AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
cargo VARCHAR(255)NOT NULL,
departamento VARCHAR(50) NULL DEFAULT NULL ,
ativo TINYINT(1) NULL DEFAULT '1',-- OU BOOLEAN DEFAULT TRUE
email VARCHAR(255)NULL UNIQUE,
senha VARCHAR(255) NULL,
perfil ENUM('ADM', 'GERENTE', 'VENDEDOR', 'ESTOQUISTA', 'VISUALIZADOR')
);

-- ----------------------------------------------
-- TABELA CLIENTES
-- ----------------------------------------------
CREATE TABLE IF NOT EXISTS clientes(
-- DADOS PESSOAIS
id_cliente INT(11) PRIMARY KEY,
nome VARCHAR(255),
CPF__CNPJ VARCHAR(20) UNIQUE,
tipo_cli ENUM('FÍSICO', 'JURIDICO'),
email VARCHAR(100) UNIQUE,
telefone VARCHAR(20),
-- ENDEREÇO
cidade VARCHAR(100),
estado CHAR(2),
cep VARCHAR(10),
logradouro VARCHAR(100),
pais VARCHAR(20),
numero VARCHAR(5),
bairro VARCHAR(20),
-- ADICIONAIS 
limite_credito DECIMAL(10, 2) NULL DEFAULT '0.00',
data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP -- CURRENT_TIMESTAMP PEGA A HORA QUE O CLIENTE FOI CADASTRADO NO SISTEMA
);

-- ----------------------------------------------
-- TABELA PEDIDOS
-- ----------------------------------------------
CREATE TABLE IF NOT EXISTS pedidos (
id_pedido INT(11) AUTO_INCREMENT PRIMARY KEY,
cliente_id INT(11) NOT NULL,
usuario_id INT(11) NOT NULL,
data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
status_pedido ENUM('PENDENTE', 'CONCLUIDO', 'EM ANDAMENTO', 'CANCELADO'),
valor_total DECIMAL (10, 2) DEFAULT 0.00,
FOREIGN KEY(cliente_id) REFERENCES clientes(id_cliente),
FOREIGN KEY(usuario_id) REFERENCES usuarios(id_usuario)
);

-- ----------------------------------------------
-- TABELA PRODUTOS
-- ----------------------------------------------
CREATE TABLE IF NOT EXISTS produtos (
id_produto INT(11) AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
categoria VARCHAR(50) NOT NULL,
sku VARCHAR(150) NOT NULL,
preco_custo DECIMAL(10,2) NOT NULL,
preco_venda DECIMAL(10,2) NOT NULL,
quantidade_estoque INT(11) NOT NULL DEFAULT 0,
estoque_minimo INT DEFAULT 0,
`status` BOOLEAN DEFAULT TRUE, 
fornecedor VARCHAR(50) NOT NULL
);

-- ----------------------------------------------
-- TABELA ITENS_PEDIDO
-- ----------------------------------------------
CREATE TABLE IF NOT EXISTS itens_pedido (
id_item INT(11) AUTO_INCREMENT PRIMARY KEY,
pedido_id INT(11) NOT NULL,
produto_id INT(11) NOT NULL,
quantidade INT NOT NULL ,
preco_unitario DECIMAL(10, 2) DEFAULT 0.00,
desconto_percentual DECIMAL(10,2),
FOREIGN KEY(pedido_id) REFERENCES pedidos(id_pedido),
FOREIGN KEY(produto_id) REFERENCES produtos(id_produto)
);

-- ----------------------------------------------
-- TABELA PAGAMENTOS
-- ----------------------------------------------
CREATE TABLE IF NOT EXISTS pagamentos (
id_pagamento INT(11) AUTO_INCREMENT PRIMARY KEY,
pedido_id INT(11) NOT NULL,
metodo_pagamento ENUM('PIX', 'CREDITO', 'DEBITO', 'DINHEIRO', 'BOLETO', 'TICKET'),
valor_pago DECIMAL (10, 2) NOT NULL,
`status` ENUM ('PENDENTE', 'APROVADO', 'RECUSADO') DEFAULT 'PENDENTE',
desconto_percentual DECIMAL(10,2),
FOREIGN KEY(pedido_id) REFERENCES pedidos(id_pedido)
);


