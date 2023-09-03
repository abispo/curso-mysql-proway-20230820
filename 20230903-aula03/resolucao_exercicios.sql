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
INSERT INTO tb_avaliacoes(id, aluno_id, turma_id, nota1, nota2, nota3, nota4, nota5) VALUES
    (1, 101, 201, 8.5, 7.5, 9.0, 7.0, 8.0),
    (2, 102, 202, 7.0, 8.5, 7.5, 8.0, 9.0),
    (3, 103, 201, 9.0, 8.5, 7.5, 8.5, 9.5),
    (4, 104, 203, 7.5, 9.0, 8.5, 9.0, 7.5),
    (5, 105, 202, 8.8, 7.0, 9.5, 7.8, 8.2),
    (6, 106, 203, 6.0, 8.0, 7.0, 9.0, 8.5),
    (7, 107, 201, 9.5, 7.5, 6.5, 8.5, 8.0),
    (8, 108, 202, 7.0, 9.0, 7.0, 9.5, 8.5),
    (9, 109, 201, 8.5, 7.0, 9.0, 7.5, 9.0),
    (10, 110, 202, 6.5, 8.5, 7.5, 8.0, 9.0);

-- Criar view para visualizar os dados completos
CREATE VIEW vw_tb_avaliacoes AS
SELECT *, ((nota1 + nota2 + nota3 + nota4 + nota5) / 5) AS Media FROM tb_avaliacoes
ORDER BY Media DESC;

SELECT * FROM vw_tb_avaliacoes;

-- EXERCÍCIOS CARDINALIDADE ------------------------------------------
-- 1:1 (Um para Um)
-- Relacionamento entre Aluno e Bolsa de Estudo

CREATE TABLE IF NOT EXISTS tb_alunos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_bolsas_de_estudo(
    id INT PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL,
    porcentagem FLOAT NOT NULL,

    FOREIGN KEY(id) REFERENCES tb_alunos(id)
);
INSERT INTO tb_alunos(nome) VALUES
    ("José da Silva"),
    ("Maria das Graças"),
    ("João Souza");

INSERT INTO tb_bolsas_de_estudo(id, tipo, porcentagem) VALUES
    (1, "INTEGRAL", 100),
    (2, "PARCIAL 1", 60),
    (3, "PARCIAL 2", 40);

-- 1:N (Um para Muitos)
-- Relacionamento entre Departamento e Funcionários:
CREATE TABLE IF NOT EXISTS tb_departamentos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);
INSERT INTO tb_departamentos(nome) VALUES
    ("Financeiro"),
    ("Recursos Humanos"),
    ("TI");

CREATE TABLE IF NOT EXISTS tb_funcionarios(
    id INT PRIMARY KEY AUTO_INCREMENT,
    departamento_id INT NOT NULL,
    nome VARCHAR(200),
    salario FLOAT NOT NULL
);
INSERT INTO tb_funcionarios(departamento_id, nome, salario) VALUES
    (1, "Carlos", 2000),
    (1, "Amanda", 3100),
    (1, "Suzana", 1100),
    (2, "Bruna", 1900),
    (2, "Rogério", 800),
    (3, "José", 1500);

-- N:N (Muitos para Muitos)
-- Relacionamento entre Músicas e Playlists:
CREATE TABLE IF NOT EXISTS tb_musicas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    artista VARCHAR(200) NOT NULL,
);
INSERT INTO tb_musicas(nome, artista) VALUES
    ("Robocop Gay", "Mamonas Assassinas"),
    ("Chico Mineiro", "Tonico e Tinoco"),
    ("The Kids aren't alright", "Offspring"),
    ("We are the champions", "Queen"),
    ("Thriller", "Michael Jackson");

CREATE TABLE IF NOT EXISTS tb_playlists(
    id INT PRIMARY KEY NOT NULL,
    nome VARCHAR(200) NOT NULL
);
INSERT INTO tb_playlists(nome) VALUES
    ("Música caipira"),
    ("Música brasileira"),
    ("Música internacional");

-- Criar a tabela associativa
CREATE TABLE IF NOT EXISTS tb_musicas_playlists(
    musica_id INT NOT NULL,
    playlist_id INT NOT NULL,

    PRIMARY KEY(musica_id, playlist_id),

    FOREIGN KEY(musica_id) REFERENCES tb_musicas(id),
    FOREIGN KEY(playlist_id) REFERENCES tb_playlists(id)
);

INSERT INTO tb_musicas_playlists(musica_id, playlist_id) VALUES
    (1, 2),
    (2, 2),
    (2, 1),
    (3, 3),
    (4, 3),
    (5, 3);

SELECT a.nome, a.artista, b.nome FROM tb_musicas a
INNER JOIN tb_musicas_playlists mp
ON a.id = mp.musica_id
INNER JOIN tb_playlists b
ON mp.playlist_id = b.id;
