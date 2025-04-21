DROP DATABASE IF EXISTS marketing;
CREATE DATABASE marketing;
USE marketing;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, '홍길동', 'hong@example.com', 28, '남', '서울'),
(2, '김영희', NULL, NULL, '여', '부산'),
(3, '이철수', 'lee@example.com', 35, NULL, '대구'),
(4, NULL, 'choi@example.com', 42, '남', NULL),
(5, '박민수', NULL, NULL, NULL, '서울');

--  고객의 이름이 NULL인 경우, '이름없음' 으로 대체하여 조회
SELECT 
	CASE 
		WHEN name IS NULL THEN '이름없음' 
        ELSE name
	END AS name
FROM customers;

-- 나이 정보 전처리나이(age)가 NULL인 경우 평균 나이로 대체하여 표시 (소수점 첫째 자리까지 반올림)
SELECT 
	CASE 
		WHEN age IS NULL THEN (SELECT ROUND(AVG(age), 1) FROM customers)
        ELSE age
	END AS age
FROM customers;

-- 이메일이 없는 고객 수 구하기이메일이 NULL인 고객 수를 계산
SELECT COUNT(*) AS customers_no_email
FROM customers
WHERE email IS NULL;

-- 서울에 거주하는 고객 중 성별(gender)이 NULL인 사람의 customer_id를 조회
SELECT customer_id
FROM customers
WHERE gender IS NULL and city = '서울';

-- NULL 값이 하나라도 있는 고객 행 조회해서 출력
SELECT * 
FROM customers 
WHERE customer_id IS NULL
   OR name IS NULL
   OR email IS NULL
   OR age IS NULL
   OR gender IS NULL
   OR city IS NULL
;