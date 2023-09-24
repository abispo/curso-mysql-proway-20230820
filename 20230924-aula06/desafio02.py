CREATE DATABASE IF NOT EXISTS 20230924_aula06;
USE 20230924_aula06;

SET SQL_SAFE_UPDATES=0;

-- Desafio 02 (Trigger BEFORE DELETE)

CREATE TABLE IF NOT EXISTS tb_salarios(
	id INT PRIMARY KEY AUTO_INCREMENT,
    funcionario_id INT NOT NULL,
    valor FLOAT NOT NULL
);
INSERT INTO tb_salarios(funcionario_id, valor) VALUES
	(1, 1600),
	(2, 1850),
	(3, 1454),
	(4, 2160),
	(5, 2920);
    
CREATE TABLE tb_historico_salarios(
	id INT PRIMARY KEY AUTO_INCREMENT,
    funcionario_id INT NOT NULL,
    valor FLOAT NOT NULL,
    removido_em TIMESTAMP DEFAULT NOW()
);

DROP TRIGGER IF EXISTS tg_pre_remocao_salario;

DELIMITER $$

CREATE TRIGGER tg_pre_remocao_salario
BEFORE DELETE
ON tb_salarios FOR EACH ROW
BEGIN
	INSERT INTO tb_historico_salarios(funcionario_id, valor) VALUES
		(old.funcionario_id, old.valor);
END$$

DELIMITER ;

DELETE FROM tb_salarios WHERE funcionario_id = 3;
