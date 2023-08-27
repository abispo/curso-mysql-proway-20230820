/*
Cardinalidade em Banco de Dados.

Em um banco de dados relacional, as relações entre os objetos
desse banco (tabelas), representam o conceito fundamental de
SGBDRs. É muito importante entender os tipos de relações que as
tabelas podem ter entre si. No processo de modelagem das tabelas,
é muito importante definirmos corretamente as relações entre elas,
sob o risco de termos dados inconsistentes ou não confiáveis no
nosso banco de dados.

As tabelas podem se relacionar em diferentes níveis, que são:

1:1 (Um para Um)
1:N (Um para Muitos)
N:N (Muitos para Muitos)
*/

CREATE DATABASE IF NOT EXISTS curso_mysql_proway_20230827_aula02;
USE curso_mysql_proway_20230827_aula02;

/*
Imagine que foi dada a você a tarefa de modelagem do banco de dados
de um sistema de postagens (semelhante ao twitter). Foram identificadas
algumas entidades que devem ter seus valores armazenados em tabelas.
As entidades são as sequintes:

Usuario
Perfil
Postagem
Categoria
Comentario

Na nossa modelagem, separamos os dados do usuário em 2 entidades: Usuario e Perfil.
A entidade Usuario vai armazenar dados de acesso, como email e senha. A entidade
Perfil irá armazenar dados pessoais do usuário, como nome, data_de_nascimento e sexo.

Nessa modelagem, 1 Usuário terá apenas 1 perfil, e 1 perfil estará associado a 
apenas 1 usuário. Nesse caso, teremos uma relação de 1:1.
*/

-- Criando a relação 1:1 entre Usuario e Perfil

-- 1º Passo: Criar a tabela tb_usuarios
CREATE TABLE IF NOT EXISTS tb_usuarios(
	id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(200) NOT NULL,
    senha VARCHAR(200) NOT NULL,
    data_hora_criacao DATETIME NOT NULL
);

-- 2º Passo. Criar a tabela tb_perfis. Essa tabela terá uma chave estrangeira para
-- tb_usuarios

CREATE TABLE IF NOT EXISTS tb_perfis(
	id INT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    sobrenome VARCHAR(200) NOT NULL,
    data_de_nascimento DATE NULL,
    sexo CHAR(1) NULL,
    
    /*
    Nesse caso, a coluna id da tabela tb_perfis será uma
    chave primária e uma chave estrangeira ao mesmo tempo.
    Isso significa que o id do usuário na tabela tb_usuarios
    será idêntico ao id do perfil desse usuário na tabela tb_perfis
    */
    FOREIGN KEY(id) REFERENCES tb_usuarios(id)
);

-- Inserindo alguns itens de usuario
INSERT INTO tb_usuarios (email, senha, data_hora_criacao) VALUES
	("jose@email.com", "123", NOW());
    
-- A função NOW() retorna a date e hora atuais.
SELECT * FROM tb_usuarios;

-- Inserindo os dados de perfil do usuario jose@email.com
INSERT INTO tb_perfis(id, nome, sobrenome, data_de_nascimento, sexo) VALUES
	(1, "José", "da Silva", "1980-03-21", "M");

SELECT * FROM tb_perfis;

-- O comando abaixo não irá funcionar, pois já existe um valor igual para a chave primária
-- Tentando associar mais de 1 perfil a um usuário
INSERT INTO tb_perfis(id, nome, sobrenome, data_de_nascimento, sexo) VALUES
	(1, "João", "Batista", "1956-09-10", "M");

-- O comando abaixo não irá funcionar, pois o id informado não existe na tabela tb_usuarios
-- A chave estrangeira que indicamos na criação da tabela tb_perfis proíbe isso.
INSERT INTO tb_perfis(id, nome, sobrenome, data_de_nascimento, sexo) VALUES
	(1000, "ET", "de Varginha", "1800-01-01", NULL);

-- --------------------------------------------------------------------------------------------

/*
No processo que foi modelado, identificamos que um usuário pode fazer várias postagens, porém
uma postagem tem como autor apenas 1 usuário.

Nesse caso, teremos uma relação de 1:N entre Usuario e Postagem. Quando temos esse tipo de relação,
sempre devemos criar a chave estrangeira na tabela filha (ou, tabela dependente), que é a tabela
que representa a entidade no lado 'N' da relação.
*/

-- Criar a tabela tb_postagens
CREATE TABLE IF NOT EXISTS tb_postagens(
	id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    texto TEXT NOT NULL,
    data_hora_criacao DATETIME DEFAULT NOW(),
    
    FOREIGN KEY(usuario_id) REFERENCES tb_usuarios(id)
);

DESCRIBE tb_postagens;

-- Criando as postagens

INSERT INTO tb_postagens(usuario_id, titulo, texto) VALUES
	(1, "A linguagem Python", "Python é bem legal"),
    (1, "A linguagem Java", "Java é complexo"),
    (1, "A linguagem Golang", "Golang é rápida");
    
SELECT * FROM tb_postagens;

-- Criando novos usuários e novos perfis
INSERT INTO tb_usuarios (email, senha, data_hora_criacao) VALUES
	("maria@email.com", "123", "2022-09-08 22:13:45"),
    ("jose@email.com", "123", NOW());
    
INSERT INTO tb_perfis(id, nome, sobrenome, data_de_nascimento, sexo) VALUES
	(2, "Maria", "das Graças", NULL, "F"),
    (3, "José", "de Arimatéia", "1976-01-29", "M");

UPDATE tb_perfis SET nome = "João" WHERE id = 3;
UPDATE tb_usuarios SET email = "joao@email.com" WHERE id = 3;

SELECT tbp.nome, tbp.sobrenome, tbu.email FROM tb_usuarios tbu
INNER JOIN tb_perfis tbp
ON tbu.id = tbp.id;

INSERT INTO tb_postagens(usuario_id, titulo, texto, data_hora_criacao) VALUES
	(2, "A importância do UX", "UX é muito importante para o sistema", "2023-08-27 11:00:00");
    
SELECT * FROM tb_postagens;

-- --------------------------------------------------------------------------------------------

/*
No processo que foi modelado, identificamos que uma postagem pode estar dentro de n categorias,
e uma categoria pode estar associada a diversas postagens

Nesse caso, temos uma relação de Muitos para Muitos (N:N). Quando isso acontece, precisamos criar
uma tabela de ligação, conhecida como tabela associativa. Nessa tabela associativa irão as
chaves estrangeiras que farão a ligação entre Post e Categoria
*/

-- Primeiro criamos a tabela de categorias
CREATE TABLE IF NOT EXISTS tb_categorias(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);

INSERT INTO tb_categorias(nome) VALUES
	("proway"),
    ("programação"),
    ("sql"),
    ("design"),
    ("carreira"),
    ("python"),
    ("java"),
    ("golang");
    
SELECT * FROM tb_categorias;

-- Criamos a tabela associativa, que irá fazer a ligação entre Post e Categoria

CREATE TABLE IF NOT EXISTS tb_postagens_categorias(
	postagem_id INT NOT NULL,
    categoria_id INT NOT NULL,
    
    PRIMARY KEY(postagem_id, categoria_id),
    
    FOREIGN KEY(postagem_id) REFERENCES tb_postagens(id),
    FOREIGN KEY(categoria_id) REFERENCES tb_categorias(id)
);

-- Associando categorias à postagem de id 1 (Python)
INSERT INTO tb_postagens_categorias(postagem_id, categoria_id) VALUES
	(1, 1),
    (1, 2),
    (1, 6);
    
-- Associando categorias à postagem de id 2 (Java)
INSERT INTO tb_postagens_categorias(postagem_id, categoria_id) VALUES
	(2, 1),
    (2, 2),
    (2, 7);
    
-- Associando categorias à postagem de id 3 (Golang)
INSERT INTO tb_postagens_categorias(postagem_id, categoria_id) VALUES
	(3, 1),
    (3, 2),
    (3, 8);
    
-- Associando categorias à postagem de id 4 (UX)
INSERT INTO tb_postagens_categorias(postagem_id, categoria_id) VALUES
	(4, 4);
    
SELECT * FROM tb_postagens_categorias;

-- Selecionando as postagens e as categorias associadas.
SELECT tbp.id, tbp.titulo, tbc.nome AS "categoria" FROM tb_postagens tbp
INNER JOIN tb_postagens_categorias tbpc
ON tbp.id = tbpc.postagem_id
INNER JOIN tb_categorias tbc
ON tbpc.categoria_id = tbc.id;

/*
Exercícios

Modelar a tabelas do sistema de registro de estudantes e turmas. Aplicar as relações
de 1:1, 1:N e N:Nz

dados de estudante
id
nome
data de nascimento

dados de matricula
id
data da matricula
observacoes

dados de turma
id
nome da turma

dados de curso
id
nome
data de inicio
data de fim

Regras
* 1 estudante possui uma matrícula, e 1 matrícula está associada a apenas 1 estudando
* 1 Curso pode ter várias turmas, mas 1 turma está associada a apenas 1 curso
* 1 Estudante pode fazer parte de várias turmas, e uma turma pode ter vários estudantes
*/