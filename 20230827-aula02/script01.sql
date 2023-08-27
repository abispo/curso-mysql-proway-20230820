CREATE DATABASE IF NOT EXISTS curso_mysql_proway_20230827_aula02;
USE curso_mysql_proway_20230827_aula02;

/*
2FN - Segunda Forma Normal.

A Segunda Forma Normal exige que:
* A tabela esteja na Primeira Forma Normal (1FN)
* Toda coluna não chave deve depender inteiramente (de todas as partes) da chave primária. Chamamos isso
de dependência funcional total.
*/

CREATE TABLE IF NOT EXISTS tb_livros(
	id INT AUTO_INCREMENT,
    autor_id INT NOT NULL,
    nome_livro VARCHAR(200) NOT NULL,
    nome_autor VARCHAR(200) NOT NULL,
    email_autor VARCHAR(200) NOT NULL,
    
    PRIMARY KEY(id, autor_id)
);

/*
A tabela tb_livros não está na 2FN, pois a coluna nome_livro existe em função da coluna
id, e as colunas nome_autor e email_autor existem em função da coluna autor_id.
A solucão, é separar esses dados em tabelas diferentes, onde todas as colunas existirão
em função da chave primária.
*/

-- Renomear a tabela tb_livros para tb_livros_pre_2fn
ALTER TABLE tb_livros RENAME TO tb_livros_pre_2fn;

-- Criar a tabela de livros
CREATE TABLE IF NOT EXISTS tb_livros(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL
);

-- Criar a tabela de autores
CREATE TABLE IF NOT EXISTS tb_autores(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL
);

/*
Exercício

Considere a seguinte estrutura de tabela

tb_inscricoes
	* id INT PRIMARY KEY AUTO_INCREMENT
    * estudante_id INT PRIMARY KEY
    * curso_id INT PRIMARY KEY
    * nome_estudante
    * rg_estudante
    * nome_curso
    * data_inicio_curso
    * data_da_inscricao
    
Aplique a Segunda Forma Normal 2FN na tabela acima.

*/