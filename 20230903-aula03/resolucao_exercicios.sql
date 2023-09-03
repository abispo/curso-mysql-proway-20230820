# Resolução dos exercícios

/*
O Enunciado dos execícios se encontra no seguinte endereço: https://github.com/abispo/curso-mysql-proway-20230820/blob/main/20230827-aula02/README.md
*/

# 2FN
use 20230827_exercicios;

-- Exercicio 01 ------------------------------------------------
-- Criar a tabela tb_clientes
CREATE TABLE IF NOT EXISTS tb_clientes(
, id INT PRIMARY KEY AUTO_INCREMENT,
, nome VARCHAR(200) NOT NULL
);

INSERT INTO tb_clientes(nome) VALUES
, ("José da Silva"),
    ("Maria Santos"),
    ("João Souza");
    
-- Criar a tabela tb_produtos
CREATE TABLE IF NOT EXISTS tb_produtos(
, id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);
INSERT INTO tb_produtos(nome) VALUES
, ("Teclado"),
    ("Mouse Gamer"),
    ("Monitor 24''"),
    ("Headset");

    
-- Criar a tabela tb_pedidos
CREATE TABLE IF NOT EXISTS tb_pedidos(
, id INT NOT NULL,
    cliente_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    
    PRIMARY KEY(id, cliente_id, produto_id),
    FOREIGN KEY(cliente_id) REFERENCES tb_clientes(id),
    FOREIGN KEY(produto_id) REFERENCES tb_produtos(id));
    
-- Popular a tabela tb_pedidos
INSERT INTO tb_pedidos(id, cliente_id, produto_id, quantidade) VALUES
, (1, 1, 2, 3),
    (2, 2, 1, 2),
    (3, 1, 3, 1),
    (4, 3, 4, 1),
    (5, 2, 2, 1);
SELECT * FROM tb_pedidos;

DROP TABLE IF EXISTS tb_pedidos;
DROP TABLE IF EXISTS tb_clientes;
DROP TABLE IF EXISTS tb_produtos

-- Exercicio 02 (tb_estudantes) ------------------------------------------------
-- tb_estudantes
CREATE TABLE IF NOT EXISTS tb_estudantes(
    id  INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);
INSERT INTO tb_estudantes(nome) VALUES
    ("Ana Silva"),
    ("Pedro Santos"),
    ("Maria Costa"),
    ("João Oliveira"),
    ("Sofia Almeida");

-- tb_disciplinas
CREATE TABLE IF NOT EXISTS tb_disciplinas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);
INSERT INTO tb_disciplinas(id, nome) VALUES
    (101, "Matemática"),
    (102, "História"),
    (103, "Física"),
    (104, "Química"),
    (105, "Biologia");

-- tb_estudantes_disciplinas
CREATE TABLE IF NOT EXISTS tb_estudantes_disciplinas(
    estudante_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    nota FLOAT NOT NULL,

    PRIMARY KEY(estudante_id, disciplina_id),
    FOREIGN KEY(estudante_id) REFERENCES tb_estudantes(id),
    FOREIGN KEY(disciplina_id) REFERENCES tb_disciplinas(id)
);
INSERT INTO tb_estudantes_disciplinas(estudante_id, disciplina_id, nota) VALUES
    (1, 101, 85),
    (2, 102, 70),
    (3, 103, 92),
    (4, 101, 78),
    (5, 104, 88),
    (1, 102, 93),
    (3, 105, 80),
    (4, 103, 65),
    (2, 104, 75),
    (5, 101, 87);

DROP TABLE IF EXISTS tb_estudantes_disciplinas;
DROP TABLE IF EXISTS tb_estudantes;
DROP TABLE IF EXISTS tb_disciplinas;

-- Exercícios 3FN (Terceira Forma Normal)
-- Passar para a terceira forma normal a tb_avaliacoes

CREATE TABLE IF NOT EXISTS tb_avaliacoes(
    id INT NOT NULL,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,
    nota1 FLOAT NOT NULL,
    nota2 FLOAT NOT NULL,
    nota3 FLOAT NOT NULL,
    nota4 FLOAT NOT NULL,
    nota5 FLOAT NOT NULL,

    PRIMARY KEY (id, aluno_id, turma_id)
);
INSERT INTO tb_avaliacoes(id, aluno_id, nota1, nota2, nota3, nota4, nota5) VALUES
    (1, 101, 201, 8.5, 7.5, 9.0, 7.0, 8.0, 8.0),
    (2, 102, 202, 7.0, 8.5, 7.5, 8.0, 9.0, 8.0),
    (3, 103, 201, 9.0, 8.5, 7.5, 8.5, 9.5, 8.8),
    (4, 104, 203, 7.5, 9.0, 8.5, 9.0, 7.5, 8.5),
    (5, 105, 202, 8.8, 7.0, 9.5, 7.8, 8.2, 8.3),
    (6, 106, 203, 6.0, 8.0, 7.0, 9.0, 8.5, 7.7),
    (7, 107, 201, 9.5, 7.5, 6.5, 8.5, 8.0, 8.0),
    (8, 108, 202, 7.0, 9.0, 7.0, 9.5, 8.5, 8.4),
    (9, 109, 201, 8.5, 7.0, 9.0, 7.5, 9.0, 8.2),
    (10, 110, 202, 6.5, 8.5, 7.5, 8.0, 9.0, 7.9);