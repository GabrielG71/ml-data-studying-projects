-- Selecionar o banco de dados correto
USE datalake_local;
GO

-- Limpeza (Se necessário, caso já exista)
IF OBJECT_ID('dbo.vendas', 'U') IS NOT NULL
    DROP TABLE dbo.vendas;

IF OBJECT_ID('dbo.produtos', 'U') IS NOT NULL
    DROP TABLE dbo.produtos;

IF OBJECT_ID('dbo.clientes', 'U') IS NOT NULL
    DROP TABLE dbo.clientes;

IF OBJECT_ID('dbo.categorias', 'U') IS NOT NULL
    DROP TABLE dbo.categorias;
GO

-- Criação de Tabelas:

-- Tabela: Categorias   
CREATE TABLE dbo.categorias (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nome_categoria VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);
GO

-- Tabela: Produtos
CREATE TABLE dbo.produtos (
    id_produto INT PRIMARY KEY IDENTITY(1,1),
    nome_produto VARCHAR(200) NOT NULL,
    id_categoria INT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,
    data_cadastro DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_categoria) REFERENCES dbo.categorias(id_categoria)
);
GO

-- Tabela: Clientes
CREATE TABLE dbo.clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(150) UNIQUE,
    telefone VARCHAR(20),
    cidade VARCHAR(100),
    estado CHAR(2),
    data_cadastro DATETIME DEFAULT GETDATE()
);
GO

-- Tabela: Vendas
CREATE TABLE dbo.vendas (
    id_venda INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    data_venda DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_cliente) REFERENCES dbo.clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES dbo.produtos(id_produto)
);
GO

-- Povoando as tabelas com dados Dummy:

-- Inserir Categorias
INSERT INTO dbo.categorias (nome_categoria, descricao) VALUES
('Eletrônicos', 'Dispositivos eletrônicos e gadgets'),
('Livros', 'Livros físicos e digitais'),
('Roupas', 'Vestuário e acessórios'),
('Alimentos', 'Produtos alimentícios'),
('Móveis', 'Móveis para casa e escritório');
GO

-- Inserir Produtos
INSERT INTO dbo.produtos (nome_produto, id_categoria, preco, estoque) VALUES
('Notebook Dell', 1, 3500.00, 15),
('Mouse Logitech', 1, 89.90, 50),
('Dom Casmurro (Livro)', 2, 85.00, 100),
('Clean Code (Livro)', 2, 65.00, 80),
('Camiseta Branca', 3, 39.90, 200),
('Calça Jeans', 3, 129.90, 150),
('Lasanha Bolonhesa', 4, 25.00, 300),
('Camarão Empanado', 4, 12.50, 250),
('Mesa de Escritório', 5, 899.00, 20),
('Cadeira Ergonômica', 5, 1200.00, 25);
GO

-- Inserir Clientes
INSERT INTO dbo.clientes (nome, email, telefone, cidade, estado) VALUES
('João Silva', 'joao.silva@email.com', '(11) 98765-4321', 'São Paulo', 'SP'),
('Maria Santos', 'maria.santos@email.com', '(21) 97654-3210', 'Rio de Janeiro', 'RJ'),
('Pedro Oliveira', 'pedro.oliveira@email.com', '(31) 96543-2109', 'Belo Horizonte', 'MG'),
('Ana Costa', 'ana.costa@email.com', '(41) 95432-1098', 'Curitiba', 'PR'),
('Carlos Souza', 'carlos.souza@email.com', '(51) 94321-0987', 'Porto Alegre', 'RS');
GO

-- Inserir Vendas
INSERT INTO dbo.vendas (id_cliente, id_produto, quantidade, valor_total, data_venda) VALUES
(1, 1, 1, 3500.00, '2025-10-01 10:30:00'),
(2, 4, 2, 130.00, '2025-10-01 14:20:00'),
(3, 6, 1, 129.90, '2025-10-02 09:15:00'),
(4, 9, 1, 899.00, '2025-10-02 16:45:00'),
(5, 8, 2, 25.00, '2025-10-03 11:00:00'),
(1, 2, 2, 179.80, '2025-10-04 13:30:00'),
(2, 10, 1, 1200.00, '2025-10-05 10:00:00'),
(3, 3, 1, 85.00, '2025-10-06 15:20:00');
GO

-- Query para teste (Vendas por Categoria):
PRINT '=== VENDAS POR CATEGORIA ===';
SELECT 
    c.nome_categoria,
    COUNT(v.id_venda) AS total_vendas,
    SUM(v.valor_total) AS valor_total
FROM dbo.vendas v
INNER JOIN dbo.produtos p ON v.id_produto = p.id_produto
INNER JOIN dbo.categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.nome_categoria
ORDER BY valor_total DESC;
GO

-- Fim do Script
PRINT 'Script executado com sucesso!';
GO