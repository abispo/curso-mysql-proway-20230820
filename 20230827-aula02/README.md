# Exercícios

## Exercícios para aplicação da 2FN

Aplique a segunda forma normal nas seguintes tabelas:

* Tabela `tb_pedidos`

    | *id | *cliente_id | nome_cliente  | id_produto | nome_produto | quantidade |
    |-----|-------------|---------------|------------|--------------|------------|
    | 1   | 1           | José da Silva | 2          | Mouse Gamer  | 3          |
    | 2   | 2           | Maria Santos  | 1          | Teclado      | 2          |
    | 3   | 1           | José da Silva | 3          | Monitor 24'' | 1          |
    | 4   | 3           | João Souza    | 4          | Headset      | 1          |
    | 5   | 2           | Maria Santos  | 2          | Mouse Gamer  | 1          |

* Tabela `tb_estudantes`
    | *estudante_id | nome         | *disciplina_id | nome_disciplina | nota |
    |---------------|--------------|----------------|-----------------|------|
    | 1             | Ana Silva    | 101            | Matemática      | 85   |
    | 2             | Pedro Santos | 102            | História        | 70   |
    | 3             | Maria Costa  | 103            | Física          | 92   |
    | 4             | João Oliveira| 101            | Matemática      | 78   |
    | 5             | Sofia Almeida| 104            | Química         | 88   |
    | 1             | Ana Silva    | 102            | História        | 93   |
    | 3             | Maria Costa  | 105            | Biologia        | 80   |
    | 4             | João Oliveira| 103            | Física          | 65   |
    | 2             | Pedro Santos | 104            | Química         | 75   |
    | 5             | Sofia Almeida| 101            | Matemática      | 87   |

* Tabela: `tb_blog_posts`

    | *autor_id | nome_autor   | *post_id | titulo_post            | conteudo_post                                    |
    |-----------|--------------|----------|------------------------|--------------------------------------------------|
    | 1         | Maria_Silva  | 101      | Dicas de Programação  | Aqui estão algumas dicas para programadores...  |
    | 2         | Carlos_Pereira| 102      | Novidades Tecnológicas | Confira as últimas novidades no mundo da...      |
    | 3         | Ana_Garcia   | 103      | Viagem ao Exterior     | Compartilhando minha experiência em minha...    |
    | 1         | Maria_Silva  | 104      | Aprendendo a Cozinhar  | Descobri minha paixão pela culinária e...        |
    | 2         | Carlos_Pereira| 105      | Dicas de Produtividade| Aumente sua produtividade com essas dicas...     |
    | 3         | Ana_Garcia   | 106      | Explorando a Natureza  | Minha jornada ao explorar as belezas naturais...|

* Tabela: `tb_estoque`

    | *produto_id | nome_produto | *fornecedor_id | nome_fornecedor | *entrega_id | quantidade_entregue |
    |-------------|--------------|----------------|-----------------|-------------|---------------------|
    | 1           | Teclado      | 101            | Tech Corp       | 201         | 100                 |
    | 2           | Mouse        | 102            | Gadget Co.      | 202         | 150                 |
    | 3           | Monitor      | 103            | Display Tech    | 203         | 50                  |
    | 4           | Headset      | 104            | AudioSys        | 204         | 80                  |
    | 5           | Impressora   | 105            | Print Supplies  | 205         | 30                  |
    | 1           | Teclado      | 101            | Tech Corp       | 206         | 50                  |
    | 2           | Mouse        | 102            | Gadget Co.      | 207         | 70                  |
    | 3           | Monitor      | 103            | Display Tech    | 208         | 40                  |
    | 4           | Headset      | 104            | AudioSys        | 209         | 60                  |
    | 5           | Impressora   | 105            | Print Supplies  | 210         | 20                  |

    * Tabela: `tb_funcionarios`

    | *funcionario_id | nome_funcionario | *departamento_id | nome_departamento | *projeto_id | nome_projeto    |
    |-----------------|------------------|------------------|-------------------|------------|-----------------|
    | 1               | João Silva       | 101              | TI                | 201        | Desenvolvimento |
    | 2               | Maria Santos     | 102              | Marketing         | 202        | Campanha Redes  |
    | 3               | Carlos Pereira   | 101              | TI                | 203        | Site Atualização|
    | 4               | Ana Costa        | 103              | Recursos Humanos  | 204        | Treinamento RH  |
    | 5               | Pedro Oliveira   | 101              | TI                | 205        | Projeto Cloud   |
    | 1               | João Silva       | 103              | Recursos Humanos  | 206        | Contratações    |
    | 3               | Carlos Pereira   | 102              | Marketing         | 207        | Pesquisa de Mercado|
    | 4               | Ana Costa        | 101              | TI                | 208        | Migração de Dados|
    | 2               | Maria Santos     | 101              | TI                | 209        | Atualização ERP |
    | 5               | Pedro Oliveira   | 103              | Recursos Humanos  | 210        | Avaliação Desempenho |



## Exercícios para aplicação da 3FN

Aplique a terceira forma normal para as seguintes tabelas

* Tabela: `tb_avaliacoes`

    | *id | *id_aluno | *id_turma | nota1 | nota2 | nota3 | nota4 | nota5 | media_notas |
    |----|----------|----------|-------|-------|-------|-------|-------|-------------|
    | 1  | 101      | 201      | 8.5   | 7.5   | 9.0   | 7.0   | 8.0   | 8.0         |
    | 2  | 102      | 202      | 7.0   | 8.5   | 7.5   | 8.0   | 9.0   | 8.0         |
    | 3  | 103      | 201      | 9.0   | 8.5   | 7.5   | 8.5   | 9.5   | 8.8         |
    | 4  | 104      | 203      | 7.5   | 9.0   | 8.5   | 9.0   | 7.5   | 8.5         |
    | 5  | 105      | 202      | 8.8   | 7.0   | 9.5   | 7.8   | 8.2   | 8.3         |
    | 6  | 106      | 203      | 6.0   | 8.0   | 7.0   | 9.0   | 8.5   | 7.7         |
    | 7  | 107      | 201      | 9.5   | 7.5   | 6.5   | 8.5   | 8.0   | 8.0         |
    | 8  | 108      | 202      | 7.0   | 9.0   | 7.0   | 9.5   | 8.5   | 8.4         |
    | 9  | 109      | 201      | 8.5   | 7.0   | 9.0   | 7.5   | 9.0   | 8.2         |
    | 10 | 110      | 202      | 6.5   | 8.5   | 7.5   | 8.0   | 9.0   | 7.9         |


* Tabela: `tb_produtos`

    | *id | nome                    | preco_de_compra | preco_de_venda | margem_de_lucro |
    |----|-------------------------|-----------------|----------------|-----------------|
    | 1  | Smartphone Samsung       | 250.00          | 350.00         | 40.00%          |
    | 2  | Notebook Dell           | 850.00          | 1200.00        | 41.67%          |
    | 3  | Tênis Nike              | 60.00           | 90.00          | 50.00%          |
    | 4  | Camiseta Adidas         | 30.00           | 45.00          | 50.00%          |
    | 5  | Relógio Casio           | 50.00           | 80.00          | 37.50%          |
    | 6  | Fones de Ouvido Sony    | 20.00           | 40.00          | 50.00%          |
    | 7  | Televisão LG            | 500.00          | 700.00         | 40.00%          |
    | 8  | Perfume Chanel          | 100.00          | 150.00         | 33.33%          |
    | 9  | Câmera Canon            | 300.00          | 450.00         | 33.33%          |
    | 10 | Bicicleta Trek          | 400.00          | 600.00         | 33.33%          |

* Tabela: `tb_livros`

    | *id | genero_id | genero_tipo   | preco  |
    |----|------------|---------------|--------|
    | 1  | 101        | Ficção        | 25.00  |
    | 2  | 102        | Mistério      | 20.00  |
    | 3  | 103        | Romance       | 15.00  |
    | 4  | 104        | Não Ficção    | 18.00  |
    | 5  | 105        | Fantasia      | 30.00  |
    | 6  | 106        | História      | 22.00  |
    | 7  | 107        | Biografia     | 28.00  |
    | 8  | 108        | Suspense      | 21.00  |
    | 9  | 109        | Autoajuda     | 17.00  |
    | 10 | 110        | Poesia        | 12.00  |



## Exercícios de cardinalidade
