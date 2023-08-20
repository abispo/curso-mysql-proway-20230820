/*
	Normalização de dados
    
    A normalização é um processo importante da criação das tabelas no banco de dados. é um processo que ajuda a evitar problemas comuns que ocorrem quando os dados são armazenados de maneira desorganizada. A normalização ajuda a melhorar a eficiência, reduzir a redundância de dados, melhorar a integridade e evitar problemas com inconsistência das informações.
	----------------------------------------------------------
    
    Chamamos de formas normais esses processos aplicados para normalizar os dados em um
    banco de dados. As 3 principais formas normais (que nos atendem na maioria dos casos)
	são chamadas de Primeira Forma Normal (1FN), Segunda Forma Normal (2FN) e Terceira
    Forma Normal (3FN).
    
    A Primeira Forma Normal (1FN) define que cada coluna da tabela deve conter apenas
    valores atômicos e indivisíveis, ou seja, valores únicos e não compostos. Essa forma
    normal ajuda a evitar a repetição de informações em uma mesma coluna, o que pode levar
    a redundância e inconsistência de dados. Ela também deve conter uma chave primária.
*/

CREATE TABLE IF NOT EXISTS tb_clientes(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    telefone VARCHAR(50) NOT NULL
);

INSERT INTO tb_clientes(nome, endereco, telefone) VALUES
	("João da Silva", "Rua XV de Novembro, 1000, Centro, Blumenau, SC", "47983229871"),
    ("Neide Carvalho", "Praça da Liberdade, 12, Liberdade, São Paulo, SP", "11982736452,11988822345"),
    ("Maria Souza", "Rua dos Bandeirantes, 240, Centro, Pomerode, SC", "47988897843");
    
SELECT * FROM tb_clientes;

/* Problemas identificados:
	1) A coluna endereço tem um valor composto, que pode ser quebrado em outras colunas
    2) A coluna telefone permite valores multivalorados.
*/

# 1) Modificar o nome da tabela atual para tb_clientes_pre_1fn
ALTER TABLE tb_clientes RENAME TO tb_clientes_pre_1fn;

# 2) Criar a tabela com a estrutura correta
# "Quebramos" a coluna endereço em várias outras colunas, que são indivisíveis.
CREATE TABLE IF NOT EXISTS tb_clientes(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    tipo_logradouro VARCHAR(50) NOT NULL,
    logradouro VARCHAR(200) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
	uf VARCHAR(2) NOT NULL
);
DESCRIBE tb_clientes;

# 3) Como percebemos que a coluna telefone pode ter mais de 1 valor (ou seja, cada usuário pode ter mais de 1 telefone associado), nesse caso vamos precisar criar uma outra tabela que irá depender de tb_clientes. Essa será a tb_telefones
CREATE TABLE tb_telefones(
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cliente_id INTEGER NOT NULL,
    telefone VARCHAR(30),
    
    -- A coluna cliente_id será a nossa chave primária, ou seja, o campo de ligação entre tb_telefones e tb_clientes. É a partir desse campo que vamos saber os telefones dos clientes.
    FOREIGN KEY (cliente_id) REFERENCES tb_clientes(id)
);
DESCRIBE tb_telefones;

ALTER TABLE tb_clientes ADD COLUMN nome VARCHAR(200) NOT NULL;

-- Inserindo os dados de clientes
INSERT INTO tb_clientes(nome, tipo_logradouro, logradouro, numero, bairro, cidade, uf) VALUES
	("João da Silva", "Rua", "XV de Novembro", "1000", "Centro", "Blumenau", "SC"),
    ("Neide Carvalho", "Praça", "da Liberdade", "12", "Liberdade", "São Paulo", "SP"),
    ("Maria Souza", "Rua", "dos Bandeirantes", "240", "Centro", "Pomerode", "SC");
SELECT * FROM tb_clientes;

-- Inserindo os dados de telefones. É importante salientar que, como a coluna cliente_id é uma chave estrangeira para a coluna id da tabela tb_clientes, o valor que for inserido em cliente_id deve existir na tabela pai (tb_clientes)
INSERT INTO tb_telefones(cliente_id, telefone) VALUES
	(1, "47983924568"),
    (2, "47891039832"),
    (2, "47812221451"),
    (3, "47909928123");
    
SELECT * FROM tb_telefones;

-- O comando abaixo não irá funcionar, pois não existe um usuário de id 1000 na tb_clientes. O erro que aparecerá será de violação de constraint
INSERT INTO tb_telefones(cliente_id, telefone) VALUES (1000, "11900876123");

-- A cláusula INNER JOIN permite que em uma mesma consulta, conseguimos trazer dados de tabelas diferentes. Essas tabelas devem ter algum grau de relacionamento.
SELECT a.nome, a.cidade, a.uf, b.telefone FROM tb_clientes a
INNER JOIN tb_telefones b
ON a.id = b.cliente_id;

