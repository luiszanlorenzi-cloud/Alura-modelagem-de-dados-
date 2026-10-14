-- ============================================================
-- PROJETO PRÁTICO: MODELAGEM DE DADOS (MODELO FÍSICO)
-- CURSO: Modelagem de Dados: construindo o modelo físico (Alura)
-- ============================================================

-- 1. Criação da tabela Clientes
CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Criação da tabela Produtos
CREATE TABLE produtos (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco >= 0),
    quantidade_estoque INT NOT NULL DEFAULT 0
);

-- 3. Criação da tabela Pedidos (Relacionamento N:1 com Clientes)
CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_pedidos_clientes 
        FOREIGN KEY (cliente_id) 
        REFERENCES clientes(cliente_id) 
        ON DELETE CASCADE
);

-- 4. Criação da tabela de Itens do Pedido (Tabela Reduzida/Associativa N:N)
CREATE TABLE itens_pedido (
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (pedido_id, produto_id),
    CONSTRAINT fk_itens_pedidos FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    CONSTRAINT fk_itens_produtos FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);
