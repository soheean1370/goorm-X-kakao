DROP DATABASE IF EXISTS platform;
CREATE DATABASE platform;
USE platform;

-- 테이블 생성
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    age INT,
    join_date DATE
);

CREATE TABLE posts (
    id INT PRIMARY KEY,
    user_id INT,
    content TEXT,
    view_count INT,
    ad_revenue DECIMAL(10,2),
    is_public BOOLEAN,
    created_at DATETIME,
    
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 데이터 삽입
INSERT INTO users (username, age, join_date) VALUES
    ('alice', 25, '2024-01-10'),
    ('bob', 35, '2024-01-15'),
    ('charlie', 41, '2024-02-01');

INSERT INTO posts (id, user_id, content, view_count, ad_revenue, is_public, created_at) VALUES
    (101, 1, 'Hello world!', 120, 15.50, TRUE, '2025-03-20 09:00'),
    (102, 2, 'Good morning', 300, 42.75, TRUE, '2025-03-20 10:30'),
    (103, 3, 'SQL is fun!', 80, 0.00, FALSE, '2025-03-21 14:00'),
    (104, 1, '광고 테스트', 50, 5.00, TRUE, '2025-03-22 11:00');
    
-- 집계 함수와 실수형 연산
-- 게시글 전체 수, 총 조회 수, 총 광고 수익을 출력
SELECT COUNT(*) FROM posts;
SELECT SUM(view_count) FROM posts;
SELECT SUM(ad_revenue) FROM posts;

-- 광고 수익이 0원이 아닌 게시글들의 평균 광고 수익을 소수 둘째 자리까지 출력
SELECT ROUND(AVG(ad_revenue), 2) FROM posts WHERE ad_revenue > 0;

-- 각 사용자 ID별 총 광고 수익을 출력
SELECT user_id, SUM(ad_revenue) FROM posts GROUP BY user_id;

-- 광고 수익이 가장 높은 게시글의 ID, 광고 수익을 출력
SELECT id, ad_revenue FROM posts WHERE ad_revenue = (SELECT MAX(ad_revenue) FROM posts);

-- 광고 수익이 있는 게시글 중 조회 수 대비 수익 비율이 가장 높은 게시글의 ID, 조회 수, 광고 수익, 1회 조회당 수익(소수점 4자리)을 출력
SELECT 
    id, 
    view_count, 
    ad_revenue, 
    ROUND(ad_revenue/view_count, 4) AS revenue_per_view 
FROM posts 
WHERE ad_revenue > 0 
ORDER BY revenue_per_view DESC 
LIMIT 1;

-- 공개된 게시글의 평균 조회 수와 평균 광고 수익을 소수점 둘째 자리로 출력
SELECT 
    ROUND(AVG(view_count), 2) AS avg_view_count,
    ROUND(AVG(ad_revenue), 2) AS avg_ad_revenue
FROM posts
WHERE is_public = TRUE;