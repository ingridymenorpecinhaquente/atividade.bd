CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE Cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    celular VARCHAR(20),
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE Endereco (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rua VARCHAR(150) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id)
);

CREATE TABLE Produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    categoria VARCHAR(80),
    preco DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL
);

CREATE TABLE Compra(
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_compra DATETIME NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    cliente_id INT NOT NULL,
    endereco_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (endereco_id) REFERENCES Endereco(id)
);

CREATE TABLE Item_Compra(
    compra_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (compra_id, produto_id),
    FOREIGN KEY (compra_id) REFERENCES Compra(id),
    FOREIGN KEY  (produto_id) REFERENCES Produto(id)
);

INSERT INTO Cliente (nome, senha, celular, cpf, email)
VALUES ('Maria Silva', 'maria123', '42999999999', '12345678910', 'maria@gmail.com');

INSERT INTO Endereco (rua, numero, bairro, cidade, estado, cliente_id)
VALUES ('Rua das Flores', '123', 'Centro', 'Ponta Grossa', 'PR', 1);

INSERT INTO Produto (nome, descricao, categoria, preco, quantidade)
VALUES ('Notebook', 'Notebook para estudos', 'Eletronicos', 2500.00, 10);

INSERT INTO Compra (data_compra, forma_pagamento, valor_total, cliente_id, endereco_id)
VALUES (NOW(), 'Pix', 2500.00, 1, 1);

INSERT INTO Item_Compra (compra_id, produto_id, quantidade, valor_unitario)
VALUES (1, 1, 1, 2500.00);

SELECT
    Cliente.nome AS cliente,
    Produto.nome AS produto,
    Compra.forma_pagamento,
    Compra.valor_total,
    Item_Compra.quantidade
FROM Compra
INNER JOIN Cliente ON Compra.cliente_id = Cliente.id
INNER JOIN Item_Compra ON Compra.id = Item_Compra.compra_id
INNER JOIN Produto ON Item_Compra.produto_id = Produto.id;
