DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

CREATE TABLE customers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(50),
	age INT,
    city VARCHAR(50)
);

CREATE TABLE products(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    price INT,
    stock INT
);

CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- insert 문제
INSERT INTO customers( name, email, age, city) VALUES 
('김철수', 'kim@example.com', 28, 'Seoul'),
('안소희', 'an@example.com', 23, 'Busan'),
('이유민', 'lee@example.com', 22, 'Yangsan'),
('김태란', 'kimT@example.com', 32, 'Ulsan'),
('정의찬', 'jung@example.com', 30, 'Busan');


INSERT INTO products (name, price, stock) VALUES 
('AirPods Pro', 329000, 20),
('MacBook Pro', 2390000, 5),
('Galaxy S24', 1100000, 25),
('Bluetooth 스피커', 129000, 50),
('AirPods case', 20000, 0);



INSERT INTO orders(customer_id, product_id, quantity, order_date) VALUES
(1, 1, 2, '2025-03-24'),
(2, 2, 1, '2024-03-10'),
(3, 3, 2, '2023-03-30'),
(4, 1, 1, '2022-03-29'),
(1, 4, 3, '2021-03-22'),
(5, 5, 2, '2025-03-21');


-- select,where 문제
SELECT age,name FROM customers WHERE age >= 30; 
SELECT * FROM products WHERE price >= 100000 AND stock  <= 10;
SELECT email FROM customers WHERE city = 'Seoul';
SELECT * FROM orders WHERE YEAR(order_date) >= '2024';

-- update 문제
UPDATE customers SET email = 'kimcs@example.com' WHERE name = '김철수';
UPDATE products SET stock = 25 WHERE name = 'AirPods Pro';

-- delete 문제
DELETE FROM customers WHERE city = 'Busan';
DELETE FROM products WHERE stock = 0;


