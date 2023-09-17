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