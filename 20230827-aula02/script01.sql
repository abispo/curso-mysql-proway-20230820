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

Nesse caso, vamos precisar criar as relações entre as tabelas

*/

-- 1º Passo: Criar a tabela tb_estudantes
CREATE TABLE IF NOT EXISTS tb_estudantes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    documento VARCHAR(11) NOT NULL
);

-- 2º Passo: Criar a tabela tb_cursos
CREATE TABLE IF NOT EXISTS tb_cursos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    data_inicio DATE NOT NULL
);

-- 3º Passo: Criar a tabela de inscrições. Ela terá referências a alunos e cursos
CREATE TABLE IF NOT EXISTS tb_inscricoes(
	id INT AUTO_INCREMENT,
    estudante_id INT NOT NULL,
    curso_id INT NOT NULL,
    data_da_inscricao DATETIME NOT NULL,
    
    PRIMARY KEY(id, estudante_id, curso_id),
    
    FOREIGN KEY (estudante_id) REFERENCES tb_estudantes(id),
    FOREIGN KEY (curso_id) REFERENCES tb_cursos(id)
);

-- ----------------------------------------------------------------

/*
Terceira Forma Normal (3FN)

A Terceira Forma Normal (3FN) exige que:

* A tabela esteja na Segunda Forma Normal
* Todos os campos não chave da tabela dependam exclusivamente da chave primária.

*/

CREATE TABLE IF NOT EXISTS tb_artilharia(
	artilheiro_id INT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    quantidade_partidas INT NOT NULL,
    quantidade_gols INT NOT NULL,
    media_por_partida FLOAT NOT NULL
);

INSERT INTO tb_artilharia(
	artilheiro_id, nome, quantidade_partidas, quantidade_gols, media_por_partida
) VALUES
	(1, "Lionel Messi", 40, 36, 0.9),
    (2, "Cristiano Ronaldo", 40, 28, 0.7),
    (3, "Ronaldinho Gaúcho", 40, 31, 0.775),
    (4, "Kaká", 40, 22, 0.55),
    (5, "Harry Kane", 40, 19, 0.475);
    
SELECT * FROM tb_artilharia ORDER BY quantidade_gols DESC;

/*
No caso acima, a 3FN não está sendo atingida pois a coluna media_por_partida depende
das colunas quantidade_partidas e quantidade_gols, que não são chave primária da tabela.
Nesse caso, devemos remover a coluna media_por_partida da tabela e gerá-la
dinamicamente em uma cláusula SELECT.
*/

-- Removendo a coluna media_por_partida
ALTER TABLE tb_artilharia DROP COLUMN media_por_partida;

DESCRIBE tb_artilharia;

-- Podemos usar a cláusula AS para gerar colunas em tempo de execução.
-- Atenção! Essas colunas não são criadas fisicamente, elas só existem durante a
-- execução do comando

SELECT
	nome,
    quantidade_partidas,
    quantidade_gols,
    FORMAT(quantidade_gols / quantidade_partidas, 2) AS "Média de gols por partida"
FROM tb_artilharia
ORDER BY quantidade_gols DESC;

/*
Exercício

Aplique a terceira forma normal na tabela a seguir

tb_pedidos
	* pedido_id		INT NOT NULL
    * item_id		INT NOT NULL
	* valor_unitario FLOAT NOT NULL
    * quantidade	INT NOT NULL
    * subtotal		FLOAT NOT NULL
    
    Crie 5 registros para ilustrar melhor o comportamento antes e depois da aplicação
    da 3FN
*/
