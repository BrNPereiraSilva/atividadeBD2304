CREATE DATABASE bd_videolocadora;
GO

USE bd_videolocadora;
GO

CREATE TABLE cliente (
    idCliente INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100)
);

CREATE TABLE filme (
    idFilme INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(100),
    genero VARCHAR(50),
    anoLancamento INT
);

CREATE TABLE locacao (
    idLocacao INT IDENTITY(1,1) PRIMARY KEY,
    idCliente INT,
    idFilme INT,
    dataLocacao DATE,
    valor DECIMAL(5,2),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    FOREIGN KEY (idFilme) REFERENCES filme(idFilme)
);
GO

INSERT INTO cliente (nome, cidade) VALUES
('Carlos Silva', 'Sao Paulo'),
('Ana Souza', 'Rio de Janeiro'),
('Marcos Lima', 'Belo Horizonte'),
('Fernanda Dias', 'Sao Paulo'),
('Bruno Pereira', 'Sao Paulo'),
('Claudio Lima', 'Sao Paulo');

INSERT INTO filme (titulo, genero, anoLancamento) VALUES
('Matrix', 'Ficcao Cientifica', 1999),
('Titanic', 'Romance', 1997),
('Vingadores', 'Acao', 2012),
('Coringa', 'Drama', 2019),
('John Wick', 'Acao', 2014),
('Carros', 'Animacao', 2006),
('Deadpool', 'Acao', 2016);

INSERT INTO locacao (idCliente, idFilme, dataLocacao, valor) VALUES
(1, 1, '2023-05-01', 5.00),  -- Carlos Silva - Matrix
(1, 3, '2023-05-03', 6.00),  -- Carlos Silva - Vingadores
(2, 2, '2023-05-02', 4.50),  -- Ana Souza - Titanic
(2, 1, '2023-05-04', 5.00),  -- Ana Souza - Matrix
(3, 4, '2023-05-01', 6.50),  -- Marcos Lima - Coringa
(4, 1, '2023-05-01', 5.00),  -- Fernanda Dias - Matrix
(4, 4, '2023-05-05', 6.50);  -- Fernanda Dias - Coringa

INSERT INTO locacao (idCliente, idFilme, dataLocacao, valor) VALUES
(5, 5, '2023-05-02', 6.00),  -- Bruno - John Wick
(5, 6, '2023-05-03', 4.00),  -- Bruno - Carros
(5, 7, '2023-05-04', 6.50),  -- Bruno - Deadpool
(6, 3, '2023-05-01', 6.00),  -- Claudio - Vingadores
(6, 2, '2023-05-05', 4.50);  -- Claudio - Titanic

SELECT * FROM filme;

SELECT * FROM cliente
WHERE cidade = 'Sao Paulo';

SELECT 
    locacao.idLocacao,
    cliente.nome AS nomeCliente,
    filme.titulo AS tituloFilme,
    locacao.dataLocacao,
    locacao.valor
FROM locacao
INNER JOIN cliente ON locacao.idCliente = cliente.idCliente
INNER JOIN filme ON locacao.idFilme = filme.idFilme;

SELECT 
    cliente.nome AS nomeCliente,
    COUNT(locacao.idLocacao) AS totalLocacoes
FROM locacao
INNER JOIN cliente ON locacao.idCliente = cliente.idCliente
GROUP BY cliente.nome
ORDER BY totalLocacoes DESC;

SELECT * FROM filme
ORDER BY anoLancamento DESC;

SELECT 
    cliente.nome AS nomeCliente,
    COUNT(locacao.idLocacao) AS totalLocacoes
FROM locacao
INNER JOIN cliente ON locacao.idCliente = cliente.idCliente
GROUP BY cliente.nome
HAVING COUNT(locacao.idLocacao) > 1
ORDER BY totalLocacoes DESC;


