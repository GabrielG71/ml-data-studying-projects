-- Script de criação da tabela COVID-19
-- Gerado automaticamente pelo pipeline ETL
-- Data: 16/10/2025

USE datalake_local;
GO

-- Limpar tabela se existir
IF OBJECT_ID('dbo.covid19_brazil', 'U') IS NOT NULL
    DROP TABLE dbo.covid19_brazil;
GO

-- Criar tabela
CREATE TABLE dbo.covid19_brazil (
    data DATE NOT NULL,
    estado VARCHAR(2),
    cidade VARCHAR(200),
    casos_totais INT,
    casos_novos INT,
    obitos_totais INT,
    obitos_novos INT,
    ano INT,
    mes INT,
    data_carga DATETIME DEFAULT GETDATE()
);
GO

-- Índices para performance
CREATE INDEX idx_data ON dbo.covid19_brazil(data);
CREATE INDEX idx_estado ON dbo.covid19_brazil(estado);
CREATE INDEX idx_cidade ON dbo.covid19_brazil(cidade);
GO

PRINT 'Tabela covid19_brazil criada';
GO
