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
    
Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
(`curso_mysql_proway_20230827_aula02`.`tb_perfis`, CONSTRAINT `tb_perfis_ibfk_1` FOREIGN KEY (`id`) 
REFERENCES `tb_usuarios` (`id`))
