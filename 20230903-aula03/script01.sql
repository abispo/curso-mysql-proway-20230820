USE 20230903_aula03;

/*
    Base de dados de pedidos (arquivo comandos.sql)

    Operadores de comparação

    =	Igual a	
    >	Maior que	
    <	Menor que	
    >=	Maior ou igual a	
    <=	Menor ou igual a	
    <>	Não igual a (ou diferente de)

    Operadores lógicos
    OR      ou
    AND     e
    NOT     não

*/

-- Primeiro exemplo: Pegar todos os pedidos da tabela tb_orders_details onde a quantidade (coluna quantity) seja maior do que 10 e menor do que 20
SELECT * FROM tb_orders_details WHERE quantity > 10 AND quantity < 20 ORDER BY quantity DESC;
-- Podemos trocar os operadores de comparação pelo between
SELECT * FROM tb_orders_details WHERE quantity BETWEEN 11 AND 19 ORDER BY quantity DESC;

-- Segundo exemplo: Pegar todos os produtos da tabela onde o preço seja menor ou igual a 10
SELECT * FROM tb_products WHERE price <= 10 ORDER BY price DESC;

/*
Exercícios

1) Selecione todos os produtos da tabela tb_products de acordo com os seguintes filtros:
	* a category_id deve ser 3
    * O price deve ser maior do que 30
    * Na consulta gerar também a coluna desconto, que mostrará um valor com 10% de desconto
    price - (price * 0.1)
*/
SELECT *, (price - (price * 0.1)) AS discount FROM tb_products WHERE category_id = 3 AND price > 30;

/*
2) Selecione todos os clientes da tabela tb_customers, de acordo com os seguintes filtros:
	* A cidade (city) deve ser Berlin e o país (country) deve ser Germany
    * OU a cidade (city) deve ser Rio de Janeiro e o país (country) deve ser Brazil
*/
SELECT * FROM tb_customers
WHERE
	city = "Berlin" AND country = "Germany"
OR city = "Rio de Janeiro" AND country = "Brazil";

-- Operador lógico LIKE
-- Utilizamos o operador lógico LIKE quanto queremos fazer uma busca por padrões dentro de um texto. Exemplo:
-- Trazer todos os funcionários onde a letra do primeiro nome seja 'M'
SELECT * FROM tb_employees WHERE first_name LIKE("M%")

-- Operador lógico IN
-- Utilizamos o operador lógico IN quando queremos fazer uma busca levando em consideração valores dentro de uma sequência.
-- Exemplo: Trazer da tabela tb_customers todos os clientes dos seguintes países: USA, Canada e Germany
SELECT * FROM tb_customers WHERE country IN ("USA", "Canada", "Germany");

-- Exemplo 2: Trazer da tabela tb_employees todos os funcionários que nasceram em um dos seguintes anos: 1952, ou 1955, ou 1958
-- Exemplo 2: Trazer da tabela tb_employees todos os funcionários que nasceram em um dos seguintes anos: 1952, ou 1955, ou 1958
SELECT * FROM tb_employees WHERE YEAR(birth_date) IN ("1952", "1955", "1958");

-- Exercício 1
-- Trazer da tabela tb_suppliers todos os registros quando country for um dos seguintes:
-- USA, Japan, Australia. Utilize o operador IN
SELECT * FROM tb_suppliers WHERE country IN ("USA", "Japan", "Australia");

-- Operador IS NULL / IS NOT NULL
-- Verifica se o valor de uma coluna é nula / não é nula
-- Exemplo: Trazendo as linhas da tabela tb_customers quando o postal_code for nulo
SELECT * FROM tb_customers WHERE postal_code IS NULL;

-- Funções de agregação.
-- Utilizamos as funções de agregação quando queremos calcular um determinado valor dentro de um
-- conjunto específico de dados. Ou seja, quando queremos "sumarizar" de alguma forma as 
-- informações.

-- Exemplo: Utilizamos a função COUNT(*) para contar quantos registros existem em uma tabela
SELECT COUNT(*) FROM tb_customers;

-- Fora o COUNT, temos as seguintes funções de agregação:
-- MIN e MAX: Mostram o maior e o menor valor de uma coluna. Exemplo:
-- Mostrar o maior e o menor preço na tabela tb_products
SELECT MAX(price), MIN(price) FROM tb_products;

-- AVG: Retorna a média de valores de uma coluna
-- Exemplo: Retornar o preço médio dos produtos da tabela tb_products
SELECT FORMAT(AVG(price), 2) FROM tb_products;

-- SUM: Soma os valores de uma coluna e retorna o resultado
-- Exemplo: Retornar a soma de todos os valores dos produtos
SELECT SUM(price) FROM tb_products;

-- Funções de agregação são muito úteis, principalmente quando usadas em conjunto com a cláusula
-- GROUP BY.
-- A cláusula GROUP BY agrupa as informações por coluna
-- Exemplo: Retornar quantas vendas cada funcionário realizou

SELECT employee_id, COUNT(employee_id) AS qtd_vendas
FROM tb_orders
	GROUP BY(employee_id)
    ORDER BY qtd_vendas DESC;
    
-- Exemplo 2: Retornar o nome do entregador e quantos pedidos estão associados a ela
