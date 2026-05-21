-- DROP  DATABASE IF EXISTS sistema_vendas;
-- CRIA O BANCO COM UTF CORRETO
CREATE DATABASE IF NOT EXISTS sistema_vendas
DEFAULT CHARACTER SET utf8
COLLATE utf8_unicode_ci;

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
id_cliente INT(11) AUTO_INCREMENT PRIMARY KEY,
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

-- ÁREA INSERTS

INSERT INTO usuarios (nome, cargo, departamento, ativo, email, senha, perfil) 
VALUES
('Carlos Silva', 'Diretor de TI', 'Tecnologia', 1, 'carlos.silva@empresa.com.br', 'hash_senha_123', 1),
('Ana Souza', 'Gerente Comercial', 'Vendas', 1, 'ana.souza@empresa.com.br', 'hash_senha_123', 3),
('João Pedro', 'Vendedor Interno', 'Vendas', 1, 'joao.pedro@empresa.com.br', 'hash_senha_123', 4),
('Mariana Lima', 'Analista de Logística', 'Estoque', 1, 'mariana.lima@empresa.com.br', 'hash_senha_123', 2),
('Roberto Alves', 'Auditor de Vendas', 'Auditoria', 0, 'roberto.alves@empresa.com.br', 'hash_senha_123', 5);

 INSERT INTO clientes (
    id_cliente, nome, CPF__CNPJ, tipo_cli, email, telefone, 
    cidade, estado, cep, logradouro, pais, numero, bairro, limite_credito
) VALUES
(1, 'Marcos Almeida', '12345678901', 'FÍSICO', 'marcos@email.com', '(11) 99999-1111', 'São Paulo', 'SP', '01001-000', 'Praça da Sé', 'Brasil', '10', 'Sé', 2000.00),
(2, 'Tech Solutions Ltda', '12345678000199', 'JURIDICO', 'contato@tech.com.br', '(11) 3333-2222', 'São Paulo', 'SP', '04538-132', 'Av Faria Lima', 'Brasil', '3000', 'Itaim Bibi', 15000.00),
(3, 'Fernanda Costa', '98765432100', 'FÍSICO', 'fernanda.c@email.com', '(21) 98888-7777', 'Rio de Janeiro', 'RJ', '20000-000', 'Av Rio Branco', 'Brasil', '156', 'Centro', 3500.00),
(4, 'Comercial Souza', '98765432000188', 'JURIDICO', 'vendas@souza.com.br', '(31) 3333-4444', 'Belo Horizonte', 'MG', '30112-010', 'Av Afonso Pena', 'Brasil', '1024', 'Savassi', 8000.00),
(5, 'Lucas Pereira', '45612378900', 'FÍSICO', 'lucas.p@email.com', '(41) 97777-6666', 'Curitiba', 'PR', '80010-000', 'Rua XV de Novembro', 'Brasil', '45', 'Centro', 1200.50),
(6, 'Padaria Doce Pão', '11222333000144', 'JURIDICO', 'adm@docepao.com', '(51) 3222-1111', 'Porto Alegre', 'RS', '90010-000', 'Borges de Medeiros', 'Brasil', '870', 'Praia de Belas', 5000.00),
(7, 'Amanda Silva', '74185296300', 'FÍSICO', 'amanda.silva@email.com', '(71) 99999-8888', 'Salvador', 'BA', '40010-000', 'Av Oceânica', 'Brasil', '12', 'Barra', 2500.00),
(8, 'Construtora Ápice', '55666777000122', 'JURIDICO', 'finan@apice.com.br', '(81) 3444-5555', 'Recife', 'PE', '50010-000', 'Av Boa Viagem', 'Brasil', '450', 'Boa Viagem', 25000.00),
(9, 'Bruno Mendes', '36925814700', 'FÍSICO', 'bruno.m@email.com', '(85) 98888-1111', 'Fortaleza', 'CE', '60010-000', 'Av Beira Mar', 'Brasil', '200', 'Meireles', 1800.00),
(10, 'Clinica Vida', '99888777000166', 'JURIDICO', 'contato@vida.com', '(61) 3222-8888', 'Brasília', 'DF', '70000-000', 'Asa Sul', 'Brasil', 'L1', 'Asa Sul', 12000.00),
(11, 'Carla Nunes', '15975348600', 'FÍSICO', 'carla.n@email.com', '(19) 97777-2222', 'Campinas', 'SP', '13010-000', 'Francisco Glicério', 'Brasil', '800', 'Centro', 4000.00),
(12, 'Oficina do João', '22333444000155', 'JURIDICO', 'joao@oficina.com.br', '(13) 3222-9999', 'Santos', 'SP', '11010-000', 'Av Ana Costa', 'Brasil', '15', 'Gonzaga', 6000.00),
(13, 'Ricardo Lima', '75395145600', 'FÍSICO', 'ricardo.l@email.com', '(92) 98888-3333', 'Manaus', 'AM', '69010-000', 'Av Djalma Batista', 'Brasil', '25', 'Chapada', 3000.00),
(14, 'Logistica Rápida', '44555666000111', 'JURIDICO', 'op@lograpida.com', '(27) 3333-1111', 'Vitória', 'ES', '29010-000', 'Nossa Sra da Penha', 'Brasil', '500', 'Praia do Canto', 18000.00),
(15, 'Patricia Rocha', '85245612300', 'FÍSICO', 'patricia.r@email.com', '(62) 99999-4444', 'Goiânia', 'GO', '74010-000', 'Av Anhanguera', 'Brasil', '100', 'Setor Oeste', 2200.00),
(16, 'Agro Forte', '77888999000100', 'JURIDICO', 'vendas@agroforte.com', '(65) 3222-4444', 'Cuiabá', 'MT', '78010-000', 'Av CPA', 'Brasil', '300', 'CPA', 35000.00),
(17, 'Julio Cesar', '14725836900', 'FÍSICO', 'julio.c@email.com', '(48) 98888-5555', 'Florianópolis', 'SC', '88010-000', 'Rua Felipe Schmidt', 'Brasil', '50', 'Centro', 2800.00),
(18, 'Mercado Central', '33444555000133', 'JURIDICO', 'compras@mercado.com', '(91) 3333-6666', 'Belém', 'PA', '66010-000', 'Av Nazaré', 'Brasil', '200', 'Nazaré', 10000.00),
(19, 'Mariana Dias', '96385274100', 'FÍSICO', 'mariana.d@email.com', '(84) 99999-7777', 'Natal', 'RN', '59010-000', 'Senador Salgado', 'Brasil', '110', 'Tirol', 1600.00),
(20, 'Escola Aprender', '66777888000188', 'JURIDICO', 'diretoria@escola.com', '(83) 3222-7777', 'João Pessoa', 'PB', '58010-000', 'Epitácio Pessoa', 'Brasil', '40', 'Tambau', 9000.00); 

INSERT INTO produtos (nome, categoria, sku, preco_custo, preco_venda, quantidade_estoque, estoque_minimo, status, fornecedor) VALUES
('Notebook Dell Inspiron 15', 'Informática', 'NTB-DLL-001', 2500.00, 3200.00, 15, 5, TRUE, 'Dell'),
('Smartphone Samsung Galaxy S22', 'Celulares', 'SMT-SMS-022', 2800.00, 3500.00, 30, 10, TRUE, 'Samsung'),
('Cadeira Gamer Redragon', 'Móveis', 'CDR-RDG-100', 600.00, 950.00, 20, 5, TRUE, 'Redragon'),
('Monitor LG UltraWide 29"', 'Informática', 'MNT-LG-029', 900.00, 1300.00, 12, 3, TRUE, 'LG'),
('Impressora HP LaserJet Pro', 'Periféricos', 'IMP-HP-500', 700.00, 1100.00, 8, 2, TRUE, 'HP'),
('Mouse Logitech MX Master 3', 'Periféricos', 'MSE-LGT-003', 300.00, 450.00, 25, 5, TRUE, 'Logitech'),
('Teclado Mecânico Corsair K95', 'Periféricos', 'TCL-CSR-095', 500.00, 750.00, 18, 4, TRUE, 'Corsair'),
('Headset HyperX Cloud II', 'Áudio', 'HST-HYX-002', 350.00, 520.00, 22, 6, TRUE, 'HyperX'),
('HD Externo Seagate 2TB', 'Armazenamento', 'HDX-SGT-2000', 280.00, 420.00, 40, 10, TRUE, 'Seagate'),
('SSD Kingston 480GB', 'Armazenamento', 'SSD-KNG-480', 250.00, 380.00, 35, 8, TRUE, 'Kingston'),
('Tablet Apple iPad Air', 'Tablets', 'TBL-APL-010', 2800.00, 3600.00, 12, 3, TRUE, 'Apple'),
('Smartwatch Garmin Forerunner', 'Wearables', 'SWT-GRM-001', 1200.00, 1700.00, 10, 2, TRUE, 'Garmin'),
('Caixa de Som JBL Charge 5', 'Áudio', 'CXS-JBL-005', 600.00, 850.00, 25, 5, TRUE, 'JBL'),
('Projetor Epson PowerLite', 'Eletrônicos', 'PRJ-EPN-010', 1800.00, 2500.00, 7, 2, TRUE, 'Epson'),
('Câmera Canon EOS Rebel T7', 'Fotografia', 'CAM-CNN-007', 2200.00, 3100.00, 9, 2, TRUE, 'Canon'),
('Drone DJI Mini 2', 'Eletrônicos', 'DRN-DJI-002', 1800.00, 2500.00, 6, 2, TRUE, 'DJI'),
('Smart TV Samsung 55"', 'TVs', 'TVS-SMS-055', 2800.00, 3600.00, 14, 3, TRUE, 'Samsung'),
('Smart TV LG OLED 65"', 'TVs', 'TVS-LG-065', 4500.00, 6000.00, 8, 2, TRUE, 'LG'),
('Geladeira Brastemp Frost Free', 'Eletrodomésticos', 'GLD-BRT-001', 3200.00, 4200.00, 10, 2, TRUE, 'Brastemp'),
('Fogão Consul 4 Bocas', 'Eletrodomésticos', 'FGN-CNS-004', 900.00, 1300.00, 15, 3, TRUE, 'Consul'),
('Micro-ondas Electrolux 30L', 'Eletrodomésticos', 'MCR-ELX-030', 600.00, 850.00, 20, 5, TRUE, 'Electrolux'),
('Máquina de Lavar Samsung 11kg', 'Eletrodomésticos', 'MLV-SMS-011', 2500.00, 3400.00, 8, 2, TRUE, 'Samsung'),
('Ar-condicionado Split LG 12000BTU', 'Climatização', 'ARC-LG-012', 1800.00, 2500.00, 12, 3, TRUE, 'LG'),
('Ventilador Arno Turbo', 'Climatização', 'VNT-ARN-001', 150.00, 250.00, 40, 10, TRUE, 'Arno'),
('Liquidificador Philips Walita', 'Eletroportáteis', 'LQD-PHL-001', 200.00, 320.00, 30, 8, TRUE, 'Philips'),
('Aspirador de Pó Electrolux', 'Eletroportáteis', 'ASP-ELX-001', 400.00, 650.00, 18, 4, TRUE, 'Electrolux'),
('Panela Elétrica Mondial', 'Eletroportáteis', 'PNL-MND-001', 250.00, 380.00, 22, 5, TRUE, 'Mondial'),
('Cafeteira Nespresso Essenza', 'Eletroportáteis', 'CFT-NPS-001', 350.00, 520.00, 15, 3, TRUE, 'Nespresso'),
('Smartphone Apple iPhone 14', 'Celulares', 'SMT-APL-014', 4500.00, 6000.00, 20, 5, TRUE, 'Apple'),
('Smartphone Motorola Edge 30', 'Celulares', 'SMT-MTR-030', 2200.00, 3100.00, 25, 6, TRUE, 'Motorola'),
('Notebook Lenovo ThinkPad X1', 'Informática', 'NTB-LNV-001', 4800.00, 6500.00, 10, 2, TRUE, 'Lenovo'),
('Notebook Acer Aspire 5', 'Informática', 'NTB-ACR-005', 2800.00, 3600.00, 12, 3, TRUE, 'Acer'),
('Placa de Vídeo NVIDIA RTX 3060', 'Informática', 'GPU-NVD-3060', 2200.00, 3100.00, 15, 4, TRUE, 'NVIDIA'),
('Fonte Corsair 750W', 'Informática', 'FNT-CSR-750', 500.00, 750.00, 18, 4, TRUE, 'Corsair'),
('Gabinete Cooler Master ATX', 'Informática', 'GBN-CLM-001', 400.00, 600.00, 20, 5, TRUE, 'Cooler Master');

INSERT INTO pedidos (cliente_id, usuario_id, data_pedido, status_pedido, valor_total) VALUES
(1, 2, '2026-05-01 10:15:00', 'CONCLUIDO', 3200.00),
(2, 1, '2026-05-02 14:30:00', 'PENDENTE', 850.00),
(3, 4, '2026-05-03 09:45:00', 'EM ANDAMENTO', 1250.00),
(4, 3, '2026-05-04 16:20:00', 'CANCELADO', 0.00),
(5, 2, '2026-05-05 11:10:00', 'CONCLUIDO', 4500.00),
(6, 1, '2026-05-06 13:40:00', 'PENDENTE', 2200.00),
(7, 5, '2026-05-07 15:25:00', 'CONCLUIDO', 600.00),
(8, 3, '2026-05-08 17:50:00', 'EM ANDAMENTO', 3100.00),
(9, 4, '2026-05-09 12:05:00', 'CONCLUIDO', 950.00),
(10, 2, '2026-05-10 18:30:00', 'PENDENTE', 1800.00),
(1, 1, '2026-05-11 09:00:00', 'CONCLUIDO', 2500.00),
(2, 5, '2026-05-12 14:45:00', 'EM ANDAMENTO', 1300.00),
(3, 3, '2026-05-13 11:20:00', 'PENDENTE', 750.00),
(4, 4, '2026-05-14 16:10:00', 'CONCLUIDO', 2800.00),
(5, 2, '2026-05-15 10:35:00', 'CANCELADO', 0.00),
(6, 1, '2026-05-16 13:25:00', 'CONCLUIDO', 3600.00),
(7, 5, '2026-05-17 15:40:00', 'PENDENTE', 900.00),
(8, 3, '2026-05-18 17:15:00', 'CONCLUIDO', 4200.00),
(9, 4, '2026-05-19 12:50:00', 'EM ANDAMENTO', 1100.00),
(10, 2, '2026-05-20 18:05:00', 'CONCLUIDO', 250.00),
(1, 1, '2026-05-21 09:30:00', 'PENDENTE', 1800.00),
(2, 5, '2026-05-22 14:20:00', 'CONCLUIDO', 6000.00),
(3, 3, '2026-05-23 11:45:00', 'EM ANDAMENTO', 950.00),
(4, 4, '2026-05-24 16:55:00', 'CONCLUIDO', 3100.00),
(5, 2, '2026-05-25 10:40:00', 'PENDENTE', 2200.00),
(6, 1, '2026-05-26 13:15:00', 'CONCLUIDO', 4800.00),
(7, 5, '2026-05-27 15:50:00', 'EM ANDAMENTO', 1250.00),
(8, 3, '2026-05-28 17:35:00', 'CONCLUIDO', 900.00),
(9, 4, '2026-05-29 12:25:00', 'PENDENTE', 1500.00),
(10, 2, '2026-05-30 18:45:00', 'CONCLUIDO', 2800.00),
(1, 1, '2026-06-01 09:10:00', 'CONCLUIDO', 3200.00),
(2, 5, '2026-06-02 14:55:00', 'PENDENTE', 850.00),
(3, 3, '2026-06-03 11:05:00', 'EM ANDAMENTO', 1250.00),
(4, 4, '2026-06-04 16:40:00', 'CONCLUIDO', 4500.00),
(5, 2, '2026-06-05 10:15:00', 'PENDENTE', 2200.00),
(6, 1, '2026-06-06 13:30:00', 'CONCLUIDO', 600.00),
(7, 5, '2026-06-07 15:20:00', 'EM ANDAMENTO', 3100.00),
(8, 3, '2026-06-08 17:45:00', 'CONCLUIDO', 950.00),
(9, 4, '2026-06-09 12:00:00', 'PENDENTE', 1800.00),
(10, 2, '2026-06-10 18:25:00', 'CONCLUIDO', 2500.00),
(1, 1, '2026-06-11 09:50:00', 'EM ANDAMENTO', 1300.00),
(2, 5, '2026-06-12 14:35:00', 'CONCLUIDO', 750.00),
(3, 3, '2026-06-13 11:30:00', 'PENDENTE', 2800.00),
(4, 4, '2026-06-14 16:15:00', 'CONCLUIDO', 3600.00),
(5, 2, '2026-06-15 10:55:00', 'EM ANDAMENTO', 900.00),
(6, 1, '2026-06-16 13:05:00', 'CONCLUIDO', 4200.00),
(7, 5, '2026-06-17 15:45:00', 'PENDENTE', 1100.00),
(8, 3, '2026-06-18 17:25:00', 'CONCLUIDO', 250.00),
(9, 4, '2026-06-19 12:40:00', 'EM ANDAMENTO', 1800.00),
(10, 2, '2026-06-20 18:15:00', 'CONCLUIDO', 6000.00);





INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario, desconto_percentual) VALUES
-- pedidos 1 a 25
(1, 1, 2, 3200.00, 0.00),
(2, 2, 1, 3500.00, 5.00),
(3, 3, 1, 950.00, 0.00),
(4, 4, 2, 1300.00, 10.00),
(5, 5, 1, 1100.00, 0.00),
(6, 6, 3, 450.00, 0.00),
(7, 7, 2, 750.00, 0.00),
(8, 8, 1, 520.00, 0.00),
(9, 9, 4, 420.00, 0.00),
(10, 10, 2, 380.00, 0.00),
(11, 11, 1, 3600.00, 0.00),
(12, 12, 1, 1700.00, 0.00),
(13, 13, 2, 850.00, 0.00),
(14, 14, 1, 2500.00, 0.00),
(15, 15, 1, 3100.00, 0.00),
(16, 16, 1, 2500.00, 0.00),
(17, 17, 1, 3600.00, 0.00),
(18, 18, 1, 6000.00, 0.00),
(19, 19, 1, 4200.00, 0.00),
(20, 20, 1, 1300.00, 0.00),
(21, 21, 1, 850.00, 0.00),
(22, 22, 1, 3400.00, 0.00),
(23, 23, 1, 2500.00, 0.00),
(24, 24, 2, 250.00, 0.00),
(25, 25, 1, 320.00, 0.00),

-- pedidos 26 a 50
(26, 26, 1, 650.00, 0.00),
(27, 27, 2, 380.00, 0.00),
(28, 28, 1, 520.00, 0.00),
(29, 29, 1, 6000.00, 0.00),
(30, 30, 1, 3100.00, 0.00),
(31, 31, 1, 6500.00, 0.00),
(32, 32, 1, 3600.00, 0.00),
(33, 33, 1, 3100.00, 0.00),
(34, 34, 1, 750.00, 0.00),
(35, 35, 1, 600.00, 0.00),
(36, 1, 1, 3200.00, 0.00),
(37, 2, 1, 3500.00, 0.00),
(38, 3, 1, 950.00, 0.00),
(39, 4, 1, 1300.00, 0.00),
(40, 5, 1, 1100.00, 0.00),
(41, 6, 1, 450.00, 0.00),
(42, 7, 1, 750.00, 0.00),
(43, 8, 1, 520.00, 0.00),
(44, 9, 1, 420.00, 0.00),
(45, 10, 1, 380.00, 0.00),
(46, 11, 1, 3600.00, 0.00),
(47, 12, 1, 1700.00, 0.00),
(48, 13, 1, 850.00, 0.00),
(49, 14, 1, 2500.00, 0.00),
(50, 15, 1, 3100.00, 0.00),

-- extras para completar 75
(1, 16, 1, 2500.00, 0.00),
(2, 17, 1, 3600.00, 0.00),
(3, 18, 1, 6000.00, 0.00),
(4, 19, 1, 4200.00, 0.00),
(5, 20, 1, 1300.00, 0.00),
(6, 21, 1, 850.00, 0.00),
(7, 22, 1, 3400.00, 0.00),
(8, 23, 1, 2500.00, 0.00),
(9, 24, 1, 250.00, 0.00),
(10, 25, 1, 320.00, 0.00),
(11, 26, 1, 650.00, 0.00),
(12, 27, 1, 380.00, 0.00),
(13, 28, 1, 520.00, 0.00),
(14, 29, 1, 6000.00, 0.00),
(15, 30, 1, 3100.00, 0.00),
(16, 31, 1, 6500.00, 0.00),
(17, 32, 1, 3600.00, 0.00),
(18, 33, 1, 3100.00, 0.00),
(19, 34, 1, 750.00, 0.00),
(20, 35, 1, 600.00, 0.00),
(21, 16, 1, 2500.00, 0.00),
(22, 17, 1, 3600.00, 0.00),
(23, 18, 1, 6000.00, 0.00),
(24, 19, 1, 4200.00, 0.00),
(25, 20, 1, 1300.00, 0.00);

INSERT INTO pagamentos (pedido_id, metodo_pagamento, valor_pago, status, desconto_percentual) VALUES
(1, 'PIX', 3200.00, 'APROVADO', 0.00),
(2, 'CREDITO', 850.00, 'PENDENTE', 5.00),
(3, 'DEBITO', 1250.00, 'APROVADO', 0.00),
(4, 'BOLETO', 2800.00, 'RECUSADO', 0.00),
(5, 'DINHEIRO', 4500.00, 'APROVADO', 10.00),
(6, 'PIX', 2200.00, 'APROVADO', 0.00),
(7, 'CREDITO', 600.00, 'APROVADO', 0.00),
(8, 'DEBITO', 3100.00, 'PENDENTE', 0.00),
(9, 'DINHEIRO', 950.00, 'APROVADO', 0.00),
(10, 'PIX', 1800.00, 'RECUSADO', 0.00),

(11, 'CREDITO', 2500.00, 'APROVADO', 0.00),
(12, 'DEBITO', 1300.00, 'PENDENTE', 0.00),
(13, 'PIX', 750.00, 'APROVADO', 0.00),
(14, 'BOLETO', 2800.00, 'RECUSADO', 0.00),
(15, 'DINHEIRO', 0.00, 'RECUSADO', 0.00),
(16, 'PIX', 3600.00, 'APROVADO', 0.00),
(17, 'CREDITO', 900.00, 'PENDENTE', 0.00),
(18, 'DEBITO', 4200.00, 'APROVADO', 0.00),
(19, 'PIX', 1100.00, 'APROVADO', 0.00),
(20, 'DINHEIRO', 250.00, 'APROVADO', 0.00),

(21, 'CREDITO', 1800.00, 'PENDENTE', 0.00),
(22, 'PIX', 6000.00, 'APROVADO', 0.00),
(23, 'DEBITO', 950.00, 'APROVADO', 0.00),
(24, 'BOLETO', 3100.00, 'RECUSADO', 0.00),
(25, 'DINHEIRO', 2200.00, 'APROVADO', 0.00),
(26, 'PIX', 4800.00, 'APROVADO', 0.00),
(27, 'CREDITO', 1250.00, 'PENDENTE', 0.00),
(28, 'DEBITO', 900.00, 'APROVADO', 0.00),
(29, 'PIX', 1500.00, 'APROVADO', 0.00),
(30, 'DINHEIRO', 2800.00, 'APROVADO', 0.00),

(31, 'CREDITO', 3200.00, 'APROVADO', 0.00),
(32, 'PIX', 850.00, 'PENDENTE', 0.00),
(33, 'DEBITO', 1250.00, 'APROVADO', 0.00),
(34, 'BOLETO', 4500.00, 'RECUSADO', 0.00),
(35, 'DINHEIRO', 2200.00, 'APROVADO', 0.00),
(36, 'PIX', 600.00, 'APROVADO', 0.00),
(37, 'CREDITO', 3100.00, 'PENDENTE', 0.00),
(38, 'DEBITO', 950.00, 'APROVADO', 0.00),
(39, 'PIX', 1800.00, 'RECUSADO', 0.00),
(40, 'DINHEIRO', 2500.00, 'APROVADO', 0.00),

(41, 'CREDITO', 1300.00, 'PENDENTE', 0.00),
(42, 'PIX', 750.00, 'APROVADO', 0.00),
(43, 'DEBITO', 2800.00, 'RECUSADO', 0.00),
(44, 'BOLETO', 3600.00, 'APROVADO', 0.00),
(45, 'DINHEIRO', 900.00, 'APROVADO', 0.00),
(46, 'PIX', 4200.00, 'APROVADO', 0.00),
(47, 'CREDITO', 1100.00, 'PENDENTE', 0.00),
(48, 'DEBITO', 250.00, 'APROVADO', 0.00),
(49, 'PIX', 1800.00, 'APROVADO', 0.00),
(50, 'DINHEIRO', 6000.00, 'APROVADO', 0.00);



-- LISTA DE VIWS

-- VIWS PARA PRODUOS E ESTOQUE 

-- lista de produtos ativos
CREATE OR REPLACE VIEW vw_produtos_ativos AS
SELECT id_produto, sku, nome, categoria, preco_venda, quantidade_estoque
FROM produtos
WHERE `status` = TRUE;

SELECT * FROM vw_produtos_ativos;

-- Lista de produtos com estoque abaixo do minimo
CREATE OR REPLACE VIEW vw_alerta_estoque_minimo AS
SELECT sku, nome, quantidade_estoque, estoque_minimo
FROM produtos
WHERE quantidade_estoque <= estoque_minimo AND ´status = TRUE;

SELECT * FROM vw_alerta_estoque_minimo;

-- VIEWS PARA GESTÃO DE CLIENTES
CREATE OR REPLACE VIEW vw_contatos_marketing AS 
SELECT nome, email, telefone, cidade, estado
FROM clientes
WHERE email IS NOT NULL;

SELECT * FROM vw_contatos_marketing;

-- view para pessoas fisicas
CREATE OR REPLACE VIEW vw_clientes_pf AS 
SELECT id_cliente, nome, CPF__CNPJ AS CPF
FROM clientes
WHERE tipo_cli = 'FÍSICO';

-- view para pessoa juridica
CREATE OR REPLACE VIEW vw_clientes_pj AS 
SELECT id_cliente, nome, CPF__CNPJ AS CNPJ
FROM clientes
WHERE tipo_cli = 'JURIDICO';

SELECT * FROM vw_clientes_pf;

SELECT * FROM vw_clientes_pj;

-- VIEWS PARA VENDAS
-- view para resumo de vendas
CREATE OR REPLACE VIEW vw_resumo_pedidos AS
SELECT p.id_pedido, p.data_pedido, c.nome AS cliente, p.status_pedido, p.valor_total
FROM pedidos AS p
JOIN clientes AS c ON p.cliente_id = c.id_cliente
JOIN usuarios AS u ON p.usuario_id = u.id_usuario;

SELECT * FROM vw_resumo_pedidos;













