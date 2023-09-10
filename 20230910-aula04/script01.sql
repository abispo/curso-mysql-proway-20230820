-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS 20230910_aula04;

-- Definir o banco de dados criado como padrão
USE 20230910_aula04;

-- Permitir que cláusulas DELETE e UPDATE sejam executadas sem restrição
SET SQL_SAFE_UPDATES=1;

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

/*
    Criar a tabela tb_pedidos_agregado_por_cliente

    Essa tabela terá 3 colunas: id do cliente, nome do cliente e valor total de compras
    Crie essa tabela e insira os dados utilizando o comando CREATE TABLE ... AS SELECT ...
    Dica: Você vai precisar utilizar INNER JOIN e GROUP BY
*/