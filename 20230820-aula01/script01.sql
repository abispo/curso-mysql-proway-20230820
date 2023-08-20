
-- Isso é um comentário de uma linha
# Outro comentário de uma linha

/*
Esse é um comentário multilinha
*/

-- Criar do banco de dados 20230820_aula01
-- Se não existir, cria o banco de dados. Se existir, mostra um aviso
CREATE DATABASE IF NOT EXISTS 20230820_aula01;

-- Após o banco ser criado, precisamos definí-lo como o banco de dados padrão onde
-- os comandos serão executados.
USE 20230820_aula01;

-- Também utilizamos o comando CREATE para criar tabelas
CREATE TABLE IF NOT EXISTS tb_clientes(
	-- id é a coluna chave primária. Ou seja, o seu valor não será repetido
	id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- O tipo varchar é o tipo texto, de tamanho variável, não nulo
    nome VARCHAR(100) NOT NULL,
    
    -- data_de_nascimento é do tipo date, não nulo
    data_de_nascimento DATE NOT NULL,
    saldo VARCHAR(100) NOT NULL,
    
    -- Observacao é do tipo TEXT (sem limite) e permite valores nulos
    observacao TEXT
);

-- Alterando o tipo de dado da coluna saldo para FLOAT
ALTER TABLE tb_clientes MODIFY saldo FLOAT;

-- O comando DESCRIBE mostra informações sobre a tabela
DESCRIBE tb_clientes;

-- Podemos alterar também o nome da coluna
ALTER TABLE tb_clientes CHANGE COLUMN data_de_nascimento dt_nascimento DATE;
DESCRIBE tb_clientes;

-- Adicionando uma coluna na tabela
ALTER TABLE tb_clientes ADD categoria_id INTEGER NOT NULL;
DESCRIBE tb_clientes;

-- Removendo a coluna saldo da tabela
ALTER TABLE tb_clientes DROP COLUMN saldo;
DESCRIBE tb_clientes;

ALTER TABLE tb_clientes MODIFY dt_nascimento DATE NOT NULL;
-- -------------------------------------------------

-- Inserindo um registo na tabela tb_clientes
INSERT INTO tb_clientes (nome, dt_nascimento, observacao, categoria_id) VALUES (
	"José da Silva", "1980-11-29", "Usuário antigo", 1
);

-- Inserindo vários registros de uma vez só
INSERT INTO tb_clientes (nome, dt_nascimento, categoria_id) VALUES 
	("Janaína Souza", "1985-04-03", 1),
    ("Mario Puzzo", "1976-02-06", 1),
    ("Rebecca Ramalho", "1999-09-10", 2);
    
-- Visualizando os registros da tabela
-- O * significa trazer todas as colunas
SELECT * FROM tb_clientes;

-- Trazendo apenas o nome dos usuários que estão na categoria 2
SELECT nome FROM tb_clientes WHERE categoria_id = 2;

-- Por padrão, o MySQL WOrkbench bloqueia comandos UPDATE e DELETE sem cláusula WHERE. Para
-- desabilitar esse comportamento, execute o comando abaixo;
SET SQL_SAFE_UPDATES=0;

-- Atualizar todas as linhas que possem categoria_id = 2, para o texto "Usuário a regularizar"
-- Para atualizar dados em uma tabela, utilizamos o comando UPDATE
UPDATE tb_clientes SET observacao = "Usuário a regularizar";

-- Por acidente, alteramos todos os registros.
SELECT * FROM tb_clientes;

-- Vamos voltar ao estado inicial
-- Atualizar observacao para null
UPDATE tb_clientes SET observacao = NULL;
SELECT * FROM tb_clientes;

-- Voltar o valor que o registro de id 1 tinha para a coluna observacao
UPDATE tb_clientes SET observacao = "Usuário antigo" WHERE id = 1;
SELECT * FROM tb_clientes;

-- Rodando o último UPDATE
UPDATE tb_clientes SET observacao = "Usuário a regularizar" WHERE categoria_id = 2;
SELECT * FROM tb_clientes;

-- Vamos excluir os usuário que possuem o id 2 e 3
-- Podemos utilizar operadores lógicos (AND, OR, NOT) para montar a nossa consulta
DELETE FROM tb_clientes WHERE id = 2 OR id = 3;
SELECT * FROM tb_clientes;

UPDATE tb_clientes SET id = 2 WHERE categoria_id=2;

-- Apagando a tabela tb_clientes
DROP TABLE tb_clientes;

-- ---------------------------------------------------------------
/*
	DESAFIO
    1) Crie a tabela tb_produtos. Ela terá a seguinte estrutura:
		* A coluna id vai ser do tipo int, será uma chave primária e terá auto incremento.
        * A coluna nome vai ser do tipo varchar, de tamanho máximo 200. Não pode receber valores nulos.
        * A coluna descricao vai ser do tipo varchar, tamanho máximo 200. Não pode receber valores nulos
        * A coluna preco vai ser do tipo INT, nao pode receber valores nulos
	2) Altere a coluna tb_produtos, modificando o tipo da coluna preco de INT para FLOAT
    3) Insira os seguintes dados na tabela tb_produtos
		Celular		iPhone XS		3000
        Bola		Topper			140
        Mouse		Multilaser		90
        Notebook	Dell			5500
        Cadeira		Koerich			100
	4) Insira uma nova coluna na tabela, chamada categoria_id. Essa coluna deve ter o valor padrão de 1
    5) Atualize a informação de preço dos produtos acima de 3000. O novo preço terá 10% de desconto.
*/

