-- Inserir dados de exemplo
USE datalake_local;
GO

INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'SE', 'Aracaju/SE', 169414, 32, 2616, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'PA', 'Bujaru/PA', 2081, 4, 43, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'MT', 'CASO SEM LOCALIZAÇÃO DEFINIDA/MT', 0, 0, 0, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'RS', 'Cacique Doble/RS', 1443, 0, 15, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'RS', 'Caxias do Sul/RS', 168401, 255, 1701, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'SP', 'Cristais Paulista/SP', 1307, 0, 20, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'SP', 'Fernão/SP', 747, 0, 5, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'MG', 'Fervedouro/MG', 1655, 0, 20, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'BA', 'Ipirá/BA', 3329, 1, 80, 0, 2023, 3);
INSERT INTO dbo.covid19_brazil (data, estado, cidade, casos_totais, casos_novos, obitos_totais, obitos_novos, ano, mes) VALUES ('2023-03-18', 'PE', 'Itapetim/PE', 2879, 1, 39, 0, 2023, 3);

GO

PRINT 'Dados inseridos com sucesso!';
GO