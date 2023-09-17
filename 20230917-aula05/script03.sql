-- STORED PROCEDURES --

CREATE DATABASE IF NOT EXISTS 20230917_aula05;
USE 20230917_aula05;
SET SQL_SAFE_UPDATES=0;

/*
	Stored Procedures são blocos de código SQL que podem conter instruções, lógica condicional e controle de fluxo. Elas são usadas
    principalmente para realizar operações de inclusão (INSERT), atualização (UPDATE) e exclusão (DELETE) de dados, além de executar consultas
    complexas. É importante mencionar que as procedures não retornam valores.
    
    Procedures podem receber parâmetros, que podem ser de 3 tipos: IN (Entrada), OUT (saída) e INOUT (entrada e saída).
*/

CREATE TABLE IF NOT EXISTS tb_clientes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    sobrenome VARCHAR(200) NOT NULL,
    data_de_nascimento DATE NOT NULL,
    sexo CHAR(1) NOT NULL);
    
INSERT INTO tb_clientes(nome, sobrenome, data_de_nascimento, sexo) VALUES
	("Maria", "das Dores", "1967-08-13", "F"),
    ("João", "da Silva", "1978-05-19", "M"),
    ("José", "de Souza", "1988-12-11", "M"),
    ("Paula", "de Castro", "1991-08-17", "F"),
    ("Barbara", "Andrade", "1993-09-20", "F");
    
SELECT * FROM tb_clientes;

-- Criar uma stored procedure que exibe os dados da tabela tb_clientes

-- Se a stored procedure já existe, a apagamos.
DROP PROCEDURE IF EXISTS sp_pegar_dados_tb_clientes;

-- Aqui precisamos alterar o delimitador padrão de comandos do MySQL. O padrão é o ponto-e-vírgula(;), porém precisamos alterar
-- temporariamente esse delimitador para que seja possível criarmos a stored procedure
DELIMITER $$

-- Criamos a stored_procedure com o comando CREATE PROCEDURE. O prefixo sp significa Stored Procedure
CREATE PROCEDURE sp_pegar_dados_tb_clientes()
-- As instruções SQL ficam dentro do bloco BEGIN... END
BEGIN
	SELECT * FROM tb_clientes;
END $$		-- Aqui utilizamos o novo delimitador padrão ($$)

DELIMITER ;	-- Aqui definimos novamente o delimitador padrão como ponto-e-vírgula(;)sp_pegar_dados_tb_clientessp_pegar_dados_tb_clientes

-- Utilizamos o comando CALL para chamar uma Stored Procedure
CALL sp_pegar_dados_tb_clientes;

-- Criando stored procedures com parâmetros IN (Entrada)
-- Criar Stored Procedure que salve um novo cliente

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_salvar_novo_cliente;

-- A sintaxe dos parâmetros é a seguinte:
-- Tipo do parâmetro (IN, OUT ou INOUT)
-- Nome do parâmetro
-- Tipo de dado, com o tamanho se for obrigatório

CREATE PROCEDURE sp_salvar_novo_cliente(
	IN in_nome VARCHAR(200),
    IN in_sobrenome VARCHAR(200),
    IN in_data_de_nascimento DATE,
    IN in_sexo CHAR(1)
)
BEGIN
	INSERT INTO tb_clientes(nome, sobrenome, data_de_nascimento, sexo)
    VALUES(in_nome, in_sobrenome, in_data_de_nascimento, in_sexo);
END$$

DELIMITER ;

-- Inserir um novo cliente
CALL sp_salvar_novo_cliente("Carlos", "de Jesus", "1984-09-10", "M");
CALL sp_pegar_dados_tb_clientes;

-- Criar tabela tb_estados
CREATE TABLE IF NOT EXISTS tb_estados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL);
    
INSERT INTO `tb_estados` (`id`, `nome`, `uf`) VALUES
(1, 'Acre', 'AC'),
(2, 'Alagoas', 'AL'),
(3, 'Amazonas', 'AM'),
(4, 'Amapá', 'AP'),
(5, 'Bahia', 'BA'),
(6, 'Ceará', 'CE'),
(7, 'Distrito Federal', 'DF'),
(8, 'Espírito Santo', 'ES'),
(9, 'Goiás', 'GO'),
(10, 'Maranhão', 'MA'),
(11, 'Minas Gerais', 'MG'),
(12, 'Mato Grosso do Sul', 'MS'),
(13, 'Mato Grosso', 'MT'),
(14, 'Pará', 'PA'),
(15, 'Paraíba', 'PB'),
(16, 'Pernambuco', 'PE'),
(17, 'Piauí', 'PI'),
(18, 'Paraná', 'PR'),
(19, 'Rio de Janeiro', 'RJ'),
(20, 'Rio Grande do Norte', 'RN'),
(21, 'Rondônia', 'RO'),
(22, 'Roraima', 'RR'),
(23, 'Rio Grande do Sul', 'RS'),
(24, 'Santa Catarina', 'SC'),
(25, 'Sergipe', 'SE'),
(26, 'São Paulo', 'SP'),
(27, 'Tocantins', 'TO');

-- Criar tabela tb_cidades
CREATE TABLE IF NOT EXISTS tb_cidades(
	id INT PRIMARY KEY AUTO_INCREMENT,
    estado_id INT NOT NULL,
    nome VARCHAR(200) NOT NULL,
    
    FOREIGN KEY(estado_id) REFERENCES tb_estados(id)
);

INSERT INTO tb_cidades(nome, estado_id) VALUES
	("Curitiba", 18),
    ("Florianópolis", 24),
    ("Porto Alegre", 23),
    ("Blumenau", 24),
    ("Itajaí", 24);
    
-- Criar tabela tb_galpoes
CREATE TABLE IF NOT EXISTS tb_galpoes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    cidade_id INT NOT NULL,
    nome VARCHAR(200) NOT NULL
);

INSERT INTO tb_galpoes(cidade_id, nome) VALUES
	(1, "Galpão PR 01"),
    (1, "Galpão PR 02"),
    (3, "Galpão RS 01"),
    (4, "Galpão SC 01"),
    (4, "Galpão SC 02"),
    (2, "Galpão SC 03"),
    (5, "Galpão SC 04");
    
-- Criar uma stored procedure com um parâmetro de saída (OUT) contendo a quantidade de galpões que existem em uma determinada cidade

DROP PROCEDURE IF EXISTS sp_pegar_qtd_galpoes_por_cidade;

DELIMITER $$

CREATE PROCEDURE sp_pegar_qtd_galpoes_por_cidade(
	IN in_cidade_id INT,
    OUT out_qtd_galpoes_por_cidade INT
)
BEGIN
	SELECT COUNT(*) INTO out_qtd_galpoes_por_cidade FROM tb_galpoes WHERE cidade_id = in_cidade_id;
END$$

DELIMITER ;

-- Mostra todas as stored procedures armazenadas no servidos
SHOW PROCEDURE STATUS;

-- Chamar a stored procedure. Perceba que o padrão out é uma variável
CALL sp_pegar_qtd_galpoes_por_cidade(1, @total);
SELECT @total;

-- Criar uma stored procedure que funcione como um incremento de um valor
-- Criar a variável contador

DROP PROCEDURE IF EXISTS sp_incrementa_contador;

DELIMITER $$

CREATE PROCEDURE sp_incrementa_contador(
	INOUT contador INT
)
BEGIN
	SET contador = contador + 1;
END$$

DELIMITER ;

SET @contador = 1;
CALL sp_incrementa_contador(@contador);
CALL sp_incrementa_contador(@contador);
CALL sp_incrementa_contador(@contador);

SELECT @contador;
