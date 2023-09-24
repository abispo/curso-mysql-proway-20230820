# Desafios

## MySQL Triggers

### AFTER UPDATE

1) Criar as seguintes tabelas:

`tb_atletas`

* id INT chave primária auto incremento
* nome VARCHAR(200) NOT NULL

Inserir os registros:
* `João da Silva`
* `Maria das Dores`
* `Paulo Souza`

`tb_pontuacao`
* id, INT, chave primária, auto_incremento
* atleta_id, INT NOT NULL CHAVE ESTRANGEIRA (`tb_atletas`)
* pontuacao_atual INT NOT NULL

Inserir os registros:
* `1, 23`
* `2, 11`
* `3, 19`

Criar uma trigger chamada sp_pos_atualizacao_pontuacao, que irá inserir na tabela `tb_historico_pontuacao` após o comando UPDATE ser aplicado na tabela tb_pontuacao. Os dados serão os seguintes dados

* id do atleta que a pontuação foi atualizada
* a pontuacao antiga
* a nova pontuacao

Detalhe: Esse registro só será inserido caso a pontuação antiga seja menor do que a pontuação nova (consultar o operador de comparação `diferente` (`<>`))


### BEFORE DELETE

1) Criar a tabela `tb_salarios`, com as seguintes colunas:
* id INT CHAVE PRIMÁRIA AUTO INCREMENTO
* funcionario_id INT NOT NULL
* valor FLOAT NOT NULL DEFAULT 0

2) Inserir os seguintes dados na tabela `tb_salarios`:
* (1, 1600)
* (2, 1850)
* (3, 1454)
* (4, 2160)
* (5, 2920)

3) Criar a tabela tb_historico_salarios, com as seguintes colunas:
* id INT PRIMARY KEY AUTO INCREMENTO
* funcionario_id INT NOT NULL
* valor FLOAT NOT NULL
* removido_em TIMESTAMP DEFAULT NOW()

4) Criar o trigger tg_pre_remocao_salario que vai salvar os dados na tabela tb_historico salario quando for aplicado um comando `DELETE` na tabela tb_salarios. Deve ser uma triggerm `BEFORE DELETE`

5) Remover alguns registros da tabela `tb_salarios` para verificar o funcionamento do trigger.
