CREATE DATABASE IF NOT EXISTS 20230924_aula06;
USE 20230924_aula06;

SET SQL_SAFE_UPDATES=0;

-- Desafio 01 (Trigger AFTER UPDATE)
CREATE TABLE IF NOT EXISTS tb_atletas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);

INSERT INTO tb_atletas(nome) VALUES
	("João da Silva"),
    ("Maria das Dores"),
    ("Paulo Souza");
SELECT * FROM tb_atletas;

CREATE TABLE IF NOT EXISTS tb_pontuacao(
	id INT AUTO_INCREMENT,
    atleta_id INT NOT NULL,
    pontuacao_atual INT NOT NULL,
    
    PRIMARY KEY(id, atleta_id),
    FOREIGN KEY(atleta_id) REFERENCES tb_atletas(id)
);
INSERT INTO tb_pontuacao(atleta_id, pontuacao_atual) VALUES
	(1, 23),
    (2, 11),
    (3, 19);
SELECT * FROM tb_pontuacao;

CREATE TABLE IF NOT EXISTS tb_historico_pontuacao(
	atleta_id INT NOT NULL,
    pontuacao_anterior INT NOT NULL,
    nova_pontuacao INT NOT NULL
);

DELIMITER $$

DROP TRIGGER IF EXISTS tg_pos_atualizacao_pontuacao;

CREATE TRIGGER tg_pos_atualizacao_pontuacao
AFTER UPDATE
ON tb_pontuacao FOR EACH ROW
BEGIN
	IF old.pontuacao_atual <> new.pontuacao_atual THEN
		INSERT INTO tb_historico_pontuacao(atleta_id, pontuacao_anterior, nova_pontuacao)
        VALUES(new.atleta_id, old.pontuacao_atual, new.pontuacao_atual);
	END IF;
END$$

DELIMITER ;

UPDATE tb_pontuacao SET pontuacao_atual = 20 WHERE atleta_id = 1;	-- Insere o registro na tabela tb_historico_pontuacao
UPDATE tb_pontuacao SET pontuacao_atual = 16 WHERE atleta_id = 2;	-- Insere o registro na tabela tb_historico_pontuacao
UPDATE tb_pontuacao SET pontuacao_atual = 19 WHERE atleta_id = 3;	-- Não insere o registro na tabela tb_historico_pontuacao