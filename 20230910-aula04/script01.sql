-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS 20230910_aula04;

-- Definir o banco de dados criado como padrão
USE 20230910_aula04;

-- Permitir que cláusulas DELETE e UPDATE sejam executadas sem restrição
SET SQL_SAFE_UPDATES=0;

/*
O comando CREATE TABLE permite criar uma tabela e automaticamente inserir
registros nessa tabela recém-criada a partir dos dados de outra tabela.
*/

-- Criar a tabela tb_clientes
CREATE TABLE IF NOT EXISTS tb_clientes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    data_de_nascimento DATE NOT NULL,
    sexo CHAR(1) NOT NULL
);

-- Inserir alguns registros
INSERT INTO tb_clientes(nome, data_de_nascimento, sexo) VALUES
('Maria da Silva', '1990-01-01', 'F'),
('José de Souza', '1980-02-02', 'M'),
('João Pedro dos Santos', '1986-03-03', 'M'),
('Ana Maria Silva', '1993-04-04', 'F'),
('Pedro Paulo Souza', '1999-05-05', 'M'),
('Luiza das Neves', '1989-06-06', 'F'),
('Carlos Eduardo dos Santos', '1981-07-07', 'M'),
('Clara Maria Silva', '1973-08-08', 'F'),
('Francisco Carlos Souza', '1956-09-09', 'M');

SELECT * FROM tb_clientes;

-- Criar a tabela para agregação dos valores da coluna sexo da tb_clientes
CREATE TABLE IF NOT EXISTS tb_agregado_sexo(
	masculino INT NOT NULL,
    feminino INT NOT NULL
);

-- Pegando a quantidade de clientes do sexo masculino
-- Salvar o valor de retorno em uma variável
SELECT COUNT(id) FROM tb_clientes WHERE sexo = 'M' INTO @qtd_clientes_sexo_m;

-- Pegando a quantidade de clientes do sexo feminino
-- Salvar o valor de retorno em uma variável
SELECT COUNT(*) FROM tb_clientes WHERE sexo = 'F' INTO @qtd_clientes_sexo_f;

-- Verificar os valores das variáveis
SELECT @qtd_clientes_sexo_m, @qtd_clientes_sexo_f;

-- Inserir os valores na tabela tb_agregado_sexo
INSERT INTO tb_agregado_sexo(masculino, feminino) VALUES
	(@qtd_clientes_sexo_m, @qtd_clientes_sexo_f);

-- Verificar se os dados foram salvos com sucesso
SELECT * FROM tb_agregado_sexo;

DROP TABLE IF EXISTS tb_agregado_sexo;

-- Podemos inserir os dados na tabela tb_agregado_sexo no momento de sua criação. Para
-- isso, utilizamos a seguinte sintaxe
CREATE TABLE IF NOT EXISTS tb_clientes_agregado_sexo
AS SELECT
	-- O CASE no mysql corresponde ao switch case em algumas linguagens
	COUNT(CASE WHEN sexo = 'M' THEN 1 END) qtd_sexo_m,
    COUNT(CASE WHEN sexo = 'F' THEN 1 END) qtd_sexo_f FROM tb_clientes;

SELECT * FROM tb_clientes_agregado_sexo;

-- Desafio!

CREATE TABLE IF NOT EXISTS tb_pedidos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    valor_pedido FLOAT NOT NULL
);

INSERT INTO tb_pedidos (cliente_id, data_pedido, valor_pedido) VALUES
(1, '2020-02-18', 115.32),
(3, '2020-07-02', 127.43),
(4, '2020-09-27', 139.54),
(6, '2021-01-12', 151.65),
(7, '2021-04-26', 163.76),
(8, '2021-07-11', 175.87),
(9, '2021-10-25', 187.98),
(1, '2022-02-09', 199.09),
(3, '2022-05-23', 210.20),
(4, '2022-08-07', 221.31),
(6, '2023-01-21', 232.42),
(7, '2023-04-05', 243.53),
(8, '2023-07-19', 254.64),
(9, '2023-10-03', 265.75),
(3, '2020-03-08', 276.86),
(4, '2020-06-22', 287.97),
(6, '2020-09-06', 299.08),
(7, '2020-12-25', 1001.29),
(8, '2021-03-05', 310.19),
(9, '2021-05-03', 321.30),
(1, '2021-07-27', 332.41),
(2, '2021-10-11', 343.52),
(3, '2022-03-05', 354.63),
(4, '2022-06-19', 365.74),
(6, '2022-09-03', 376.85),
(7, '2022-12-25', 1001.29),
(8, '2023-02-17', 387.96),
(9, '2023-05-01', 399.07),
(1, '2023-07-25', 410.18),
(2, '2023-10-09', 421.29);

/*
    Criar a tabela tb_pedidos_agregado_por_cliente

    Essa tabela terá 3 colunas: id do cliente, nome do cliente e valor total de compras
    Crie essa tabela e insira os dados utilizando o comando CREATE TABLE ... AS SELECT ...
    Dica: Você vai precisar utilizar INNER JOIN e GROUP BY
*/
CREATE TABLE IF NOT EXISTS tb_pedidos_agregados_por_cliente AS
SELECT
	tb_clientes.id,
    tb_clientes.nome,
    FORMAT(SUM(tb_pedidos.valor_pedido), 2) AS total
FROM tb_clientes
INNER JOIN tb_pedidos ON
tb_clientes.id = tb_pedidos.cliente_id
GROUP BY (tb_pedidos.cliente_id)
ORDER BY tb_pedidos.cliente_id;

DROP TABLE IF EXISTS tb_clientes_agregado_sexo;
DROP TABLE IF EXISTS tb_pedidos_agredados_por_cliente;

-- ----------------------------------------------------------

-- INSERT com SELECT
-- Exemplo: Inserir um novo pedido não sabendo o id do cliente que o fez

INSERT INTO tb_pedidos(cliente_id, data_pedido, valor_pedido)
VALUES ((
    SELECT id FROM tb_clientes
    WHERE
        nome = "Pedro Paulo Souza" AND
        data_de_nascimento = "1999-05-05" AND
        sexo = "M"
    ), NOW(), 254.93
);

SELECT * FROM tb_pedidos;

-- UPDATE com SELECT (subconsulta)
-- Alterar o valor do pedido para 500 para o id 5
UPDATE tb_pedidos SET valor_pedido = 500 WHERE cliente_id IN (
	SELECT id FROM tb_clientes
    WHERE
        nome = "Pedro Paulo Souza" AND
        data_de_nascimento = "1999-05-05" AND
        sexo = "M"
);

SELECT * FROM tb_pedidos;

-- desafio!
-- Aumentar em 10% o valor_pedido da tabela tb_pedidos para os clientes
-- Maria da Silva e Ana Maria Silva. Utilize uma subconsulta como no
-- exemplo anterior
-- (valor_pedido + (valor_pedido * 0.1))

UPDATE tb_pedidos SET valor_pedido = valor_pedido * 1.1
WHERE cliente_id IN (
	SELECT id FROM tb_clientes
    WHERE
        nome = "Maria da Silva" OR nome = "Ana Maria Silva"
);

-- DELETE com SELECT (subconsulta)
-- Excluir todos os pedidos dos clientes
-- Pedro Paulo Souza e Luiza das Neves
DELETE FROM tb_pedidos
WHERE cliente_id IN (
	SELECT id FROM tb_clientes
    WHERE
        nome = "Pedro Paulo Souza" OR nome = "Luiza das Neves"
);

SELECT * FROM tb_pedidos WHERE cliente_id IN (5, 6);