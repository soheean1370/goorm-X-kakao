CREATE DATABASE restaurant;
USE restaurant; 

-- 햄버거 테이블 생성
CREATE TABLE burgers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    price INT,
    gram INT,
    kcal INT,
    protein INT
);

-- 햄버거 데이터 입력
INSERT INTO burgers(
    name,
    price,
    gram,
    kcal,
    protein
)
VALUES 
('Mac Spicy Burger', 5500, 450, 720, 34),
('Classic Burger', 4000, 300, 620, 26),
('Jalapeno Burger', 5100, 410, 690, 31),
('Fish Burger', 4700, 340, 520, 24);

select * from burgers

-- 고객 정보 테이블 생성
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    favorite_burger VARCHAR(50),
    visit_count INT,
    member_since DATE,
    phone VARCHAR(20)
);

-- 고객 데이터 입력
INSERT INTO customers(
    name,
    age,
    favorite_burger,
    visit_count,
    member_since,
    phone
)
VALUES
('안소희', 23, 'Mac Spicy Burger', 12, '2023-06-15', '010-1234-5678'),
('김민준', 28, 'Classic Burger', 8, '2023-08-22', '010-2345-6789'),
('박지영', 31, 'Jalapeno Burger', 15, '2022-11-05', '010-3456-7890'),
('이준호', 25, 'Classic Burger', 5, '2024-01-18', '010-4567-8901'),
('정다은', 19, 'Mac Spicy Burger', 3, '2024-02-10', '010-5678-9012');

select * from customers

-- 음료 테이블 생성
CREATE TABLE drinks(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    price INT,
    ml INT,
    kcal INT,
    sugar INT
);

-- 음료 데이터 입력
INSERT INTO drinks(
    name,
    price,
    ml,
    kcal,
    sugar
)
VALUES
('Orange Juice', 2000, 250, 120, 25),
('Cola', 1800, 330, 139, 35),
('Iced Americano', 2500, 400, 10, 0),
('Chocolate Shake', 3500, 500, 450, 52),
('Strawberry Smoothie', 3800, 450, 320, 40);

select * from drinks

-- 프로모션 테이블 생성
CREATE TABLE promotions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    discount_rate INT,
    start_date DATE,
    end_date DATE,
    description TEXT
);

-- 프로모션 데이터 입력
INSERT INTO promotions(
    name,
    discount_rate,
    start_date,
    end_date,
    description
)
VALUES
('봄맞이 세트 할인', 20, '2025-03-25', '2025-03-29', '버거와 음료 세트 주문 시 20% 할인'),
('신규 고객 특별 할인', 15, '2025-04-01', '2025-04-15', '첫 방문 고객 모든 메뉴 15% 할인'),
('Happy Hour', 10, '2025-03-20', '2025-05-31', '평일 오후 2-5시 음료 10% 할인'),
('주말 가족 세트', 25, '2025-04-05', '2025-05-30', '패밀리 세트 주문시 25% 할인, 주말만 적용');

select * from promotions