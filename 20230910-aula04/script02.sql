/*
Desafio

Trazer em uma consulta os seguintes dados
products.productCode, products.productName, productLines.textDescription
*/

SELECT products.productCode, products.productName, productLines.textDescription
FROM products
INNER JOIN productLines
USING (productLine);

-- LEFT JOIN
-- Trazer os clientes que fizeram pedidos e os clientes que não fizeram pedidos

SELECT
	customers.customerNumber,
    customers.customerName,
    orders.orderNumber
FROM customers
LEFT JOIN orders
USING (customerNumber);

-- Trazer apenas os clientes que não fizeram pedidos
SELECT
	customers.customerNumber,
    customers.customerName,
    orders.orderNumber
FROM customers
LEFT JOIN orders
USING (customerNumber)
WHERE orders.orderNumber IS NULL;