CREATE DATABASE IF NOT EXISTS 20230924_aula06;
USE 20230924_aula06;

SET SQL_SAFE_UPDATES=0;

-- Desafio 03 (Trigger AFTER DELETE)

CREATE TABLE IF NOT EXISTS tb_orcamento_salarios(
	total FLOAT NOT NULL
);

DROP TRIGGER IF EXISTS tg_pos_remocao_salario;

DELIMITER $$

CREATE TRIGGER tg_pos_remocao_salario
AFTER DELETE
ON tb_salarios FOR EACH ROW
BEGIN
	INSERT INTO tb_orcamento_salarios(TOTAL)
    SELECT SUM(valor) FROM tb_salarios;
END$$

DELIMITER ;

DELETE FROM tb_salarios WHERE funcionario_id = 5;
DELETE FROM tb_salarios WHERE funcionario_id = 4;