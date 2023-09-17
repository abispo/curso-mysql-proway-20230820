-- TRIGGERS --

/*
    Trigger (ou disparador) é um programa que é chamado automaticamente em resposta a algum tipo de evento, como INSERT, UPDATE e DELETE, que vai ocorrer em uma tabela associada. Por exemplo, você pode desenvolver um trigger que é chamado automaticamente sempre antes de um registro ser inserido em determinada tabela.
*/

CREATE DATABASE IF NOT EXISTS 20230917_aula05;
USE 20230917_aula05;
SET SQL_SAFE_UPDATES=0;

-- Tabela de salas, que armazena o nome da sala e a capacidade máxima de lugares
CREATE TABLE IF NOT EXISTS tb_salas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    capacidade INT NOT NULL
);

-- Criar a tabela que irá armazenar a capacidade máximas de lugares de todas as salar
CREATE TABLE IF NOT EXISTS tb_salas_agregado(
	capacidade_maxima INT NOT NULL
);

-- Criar um trigger que irá ser disparado sempre que um registro for inserido na tabela tb_salas
DELIMITER $$

CREATE TRIGGER tg_pre_insercao_tb_salas
BEFORE INSERT					-- A trigger será disparada antes do INSERT
ON tb_salas FOR EACH ROW		-- Essa trigger estará associada à tabela tb_salas
BEGIN
	DECLARE v_capacidade_maxima INT DEFAULT 0;
    
    SELECT SUM(capacidade) INTO v_capacidade_maxima FROM tb_salas;
    
    -- new representa os novos dados que serão inseridos. Nesse caso, "new" terá a estrutura da
    -- tabela tb_salas
    
    IF v_capacidade_maxima > 0 THEN
		UPDATE tb_salas_agregado SET capacidade_maxima = capacidade_maxima + new.capacidade;
	ELSE
		INSERT INTO tb_salas_agregado(capacidade_maxima) VALUES (new.capacidade);
	END IF;
    
END$$

DELIMITER ;

-- Inserindo um registro na tabela tb_salas. Esse INSERT irá disparar o trigger
INSERT INTO tb_salas(nome, capacidade) VALUES ("Blue", 19);

SELECT * FROM tb_salas;
SELECT * FROM tb_salas_agregado;

-- Inserindo um novo registro na tb_salas. A linha na tb_salas_agregado será atualizada com a soma das
-- capacidades das salas
INSERT INTO tb_salas(nome, capacidade) VALUES ("Red", 25);
SELECT * FROM tb_salas_agregado;

-- Criar um trigger que será disparado após um registro ser inserido na tabela tb_membros

-- Criar a tabela tb_membros
CREATE TABLE IF NOT EXISTS tb_membros(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(200),
    data_de_nascimento DATE
);

-- Criar a tabela tb_lembretes
CREATE TABLE IF NOT EXISTS tb_lembretes(
	id INT AUTO_INCREMENT,
    membro_id INT NOT NULL,
    mensagem VARCHAR(200) NOT NULL,
    
    PRIMARY KEY(id, membro_id),
    FOREIGN KEY(membro_id) REFERENCES tb_membros(id)
);

-- Criar o trigger que irá preencher a tabela tb_lembretes, caso algum dado falte no cadastro
DROP TRIGGER IF EXISTS tg_pos_lembretes_usuario;

DELIMITER $$

CREATE TRIGGER tg_pos_lembretes_usuario
AFTER INSERT
ON tb_membros FOR EACH ROW
BEGIN
	IF new.email IS NULL THEN
		INSERT INTO tb_lembretes(membro_id, mensagem)
        VALUES (new.id, CONCAT("Olá ", new.nome, ". Por favor, preencha o seu e-mail."));
	END IF;
    
	IF new.data_de_nascimento IS NULL THEN
		INSERT INTO tb_lembretes(membro_id, mensagem)
        VALUES (new.id, CONCAT("Olá ", new.nome, ". Por favor, preencha a sua data de nascimento."));
	END IF;
END$$

DELIMITER ;

INSERT INTO tb_membros(nome, email, data_de_nascimento) VALUES
	("João da Silva", "joao@email.com", "2000-07-21"),		-- Todos os dados preenchidos
    ("Maria de Lourdes", "maria@email.com", NULL),			-- Sem a data de nascimento
    ("Jorge de Almeida", NULL, "1993-08-04"),				-- Sem o e-mail
    ("Carlos Mendes", NULL, NULL);							-- Apenas o nome
    
SELECT * FROM tb_membros;
SELECT * FROM tb_lembretes;
