CREATE DATABASE db_CDS;
USE db_CDS;

CREATE TABLE tb_artista(
	pk_id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nome_artista VARCHAR (100)
);

DESCRIBE tb_artista;
SELECT*FROM tb_artista;

CREATE TABLE tb_gravadora( 
	pk_id_gravadora INT AUTO_INCREMENT PRIMARY KEY,
    nome_gravadora VARCHAR (50)
);

DESCRIBE tb_gravadora;
SELECT*FROM tb_gravadora;

CREATE TABLE tb_categoria(
	pk_id_gravadora INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR (50)
);

DESCRIBE tb_categoria;
SELECT*FROM tb_categoria;

CREATE TABLE tb_estado(
	pk_id_estado INT AUTO_INCREMENT PRIMARY KEY,
    nome_estado CHAR (50),
    sigla_estado CHAR (2)
);

DESCRIBE tb_estado;
SELECT*FROM tb_estado;

CREATE TABLE tb_cidade(
	pk_id_cidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_cidade VARCHAR (100)
);

ALTER TABLE tb_cidade
ADD COLUMN fk_id_estado INT;
ALTER TABLE tb_cidade
ADD CONSTRAINT fk_id_estado
FOREIGN KEY (fk_id_estado) REFERENCES tb_estado (pk_id_estado);

SELECT c.pk_id_cidade, e.sigla_estado, c.nome_cidade
FROM tb_cidade AS c
JOIN tb_estado AS e
ON c.pk_id_cidade = e.pk_id_estado;

DESCRIBE tb_cidade;
SELECT*FROM tb_cidade;

CREATE TABLE tb_cliente(
	pk_id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR (100),
    endereco_cliente VARCHAR (200),
    renda_cliente DECIMAL (10,2),
    sexo_cliente CHAR (1)
);

ALTER TABLE tb_cliente
ADD COLUMN fk_id_cidade INT;
ALTER TABLE tb_cliente
ADD CONSTRAINT fk_id_cliente
FOREIGN KEY (fk_id_cidade) REFERENCES tb_cidade (pk_id_cidade);

SELECT c.pk_id_cliente, c.nome_cliente, ci.pk_id_cidade, c.endereco_cliente, c.renda_cliente, c.sexo_cliente
FROM tb_cliente AS c
JOIN tb_cidade AS ci
ON c.pk_id_cliente = ci.pk_id_cidade;

DESCRIBE tb_cliente;
SELECT*FROM tb_cliente;

CREATE TABLE tb_conjuge(
	pk_id_conjuge INT AUTO_INCREMENT PRIMARY KEY,
    nome_conjuge VARCHAR (100),
    renda_conjuge DECIMAL (10,2),
    sexo_conjuge ENUM ('F', 'M')
);

ALTER TABLE tb_conjuge
ADD COLUMN fk_id_cliente INT;
ALTER TABLE tb_conjuge
ADD CONSTRAINT fk_id_cliente
FOREIGN KEY (fk_id_cliente) REFERENCES tb_cidade (pk_id_cliente);

SELECT co.pk_id_conjuge, c.nome_cliente, ci.pk_id_cidade, c.endereco_cliente, c.renda_cliente, c.sexo_cliente
FROM tb_conjuge AS co
JOIN tb_cliente AS c
ON co.pk_id_cliente = c.pk_id_cidade;

DESCRIBE tb_conjuge;
SELECT*FROM tb_conjuge;

CREATE TABLE tb_funcionario(
	pk_id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR (100),
    endereco_funcionario VARCHAR (200),
    renda_funcionario DECIMAL (10,2),
    sexo_funcionario ENUM ('F', 'M')
);

DESCRIBE tb_funcionario;
SELECT*FROM tb_funcionario;

CREATE TABLE tb_dependente(
	pk_id_dependente INT AUTO_INCREMENT PRIMARY KEY,
    nome_dependente VARCHAR (100),
    sexo_dependente ENUM ('F', 'M')
);

ALTER TABLE tb_dependente
ADD COLUMN fk_id_funcionario INT;
ALTER TABLE tb_dependente
ADD CONSTRAINT fk_id_funcionario
FOREIGN KEY (fk_id_funcionario) REFERENCES tb_estado (pk_id_funcionario);

SELECT pk_id_dependente, pk_id_funcionario, nome_dependente, sexo_dependente
FROM tb_dependente AS d
JOIN tb_funcionario AS f
ON d.pk_id_dependente = f.pk_id_funcionario;

DESCRIBE tb_dependente;
SELECT*FROM tb_dependente;

CREATE TABLE tb_titulo(
	pk_id_titulo INT AUTO_INCREMENT PRIMARY KEY,
    nome_cd VARCHAR (100),
    valor_cd DECIMAL (10,2),
    quantidade_estoque INT 
);

ALTER TABLE tb_titulo
ADD COLUMN fk_id_categoria INT;
ALTER TABLE tb_titulo
ADD CONSTRAINT fk_id_categoria
FOREIGN KEY (fk_id_categoria) REFERENCES tb_estado (pk_id_categoria);
ALTER TABLE tb_titulo
ADD COLUMN fk_id_gravadora INT;
ALTER TABLE tb_titulo
ADD CONSTRAINT fk_id_cgravadora
FOREIGN KEY (fk_id_gravadora) REFERENCES tb_estado (pk_id_gravadora);

SELECT pk_id_titulo, pk_id_categoria, pk_id_gravadora, nome_cd, valor_cd, quantidade_estoque
FROM tb_titulo AS t
JOIN tb_categoria AS c
ON t.pk_id_titulo = c.pk_id_categoria
JOIN tb_gravadora AS g
ON d.pk_id_titulo = f.pk_id_gravadora;

DESCRIBE tb_titulo;
SELECT*FROM tb_titulo;

CREATE TABLE tb_pedido(
	pk_id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME,
    valor_pedido DECIMAL (10,2)
);

ALTER TABLE tb_pedido
ADD COLUMN fk_id_cliente INT;
ALTER TABLE tb_pedido
ADD CONSTRAINT fk_id_categoria
FOREIGN KEY (fk_id_pedido) REFERENCES tb_estado (pk_id_categoria);
ALTER TABLE tb_pedido
ADD COLUMN fk_id_funcionario INT;
ALTER TABLE tb_pedido
ADD CONSTRAINT fk_id_funcionario
FOREIGN KEY (fk_id_pedido) REFERENCES tb_estado (pk_id_funcionario);

SELECT pk_id_pedido, pk_id_cliente, pk_id_funcionario, data_pedido, valor_pedido
FROM tb_pedido AS t
JOIN tb_cliente AS c
ON t.pk_id_pedido = c.pk_id_cliente
JOIN tb_funcionario AS f
ON d.pk_id_pedido = f.pk_id_funcionario;

DESCRIBE tb_pedido;
SELECT*FROM tb_pedido;

CREATE TABLE tb_titulo_pedido(
    quantidade_cd INT,
    valor_cd DECIMAL (10,2)
);

ALTER TABLE tb_titulo_pedido
ADD COLUMN fk_id_pedido INT;
ALTER TABLE tb_titulo_pedido
ADD CONSTRAINT fk_id_pedido
FOREIGN KEY (fk_id_titulo_pedido) REFERENCES tb_estado (pk_id_pedido);
ALTER TABLE tb_titulo_pedido
ADD COLUMN fk_id_titulo INT;
ALTER TABLE tb_titulo_pedido
ADD CONSTRAINT fk_id_titulo
FOREIGN KEY (fk_id_titulo_pedido) REFERENCES tb_estado (pk_id_titulo);

SELECT pk_id_titulo_pedido, pk_id_titulo, pk_id_pedido, dquantidade_cd, valor_cd
FROM tb_titulo_pedido AS tp
JOIN tb_titulo AS t
ON tp.pk_id_titulo_pedido = t.pk_id_titulo
JOIN tb_pedido AS p
ON tb.pk_id_titulo_pedido = p.pk_id_pedido;

DESCRIBE tb_titulo_pedido;
SELECT*FROM tb_titulo_pedido;

CREATE TABLE tb_titulo_artista(
    quantidade_cd INT,
    valor_cd DECIMAL (10,2)
);

ALTER TABLE tb_titulo_artista
ADD COLUMN fk_id_artista INT;
ALTER TABLE tb_titulo_artista
ADD CONSTRAINT fk_id_artista
FOREIGN KEY (fk_id_titulo_artista) REFERENCES tb_estado (pk_id_artista);
ALTER TABLE tb_titulo_pedido
ADD COLUMN fk_id_titulo INT;
ALTER TABLE tb_titulo_artista
ADD CONSTRAINT fk_id_titulo
FOREIGN KEY (fk_id_titulo_artista) REFERENCES tb_estado (pk_id_titulo);

SELECT pk_id_titulo, pk_id_artista
FROM tb_titulo_artista AS tp
JOIN tb_titulo AS t
ON tp.pk_id_titulo_artista = t.pk_id_titulo
JOIN tb_artista AS p
ON tb.pk_id_titulo_artista = p.pk_id_artista;

DESCRIBE tb_titulo_artista;
SELECT*FROM tb_titulo_artista;