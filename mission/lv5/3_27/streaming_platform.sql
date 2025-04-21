create database movie_platform;
use movie_platform;

-- 테이블 생성
create table users(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(50),
    subscription varchar(50)
);

 create table movies(
	movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    genre VARCHAR(50)
 )AUTO_INCREMENT = 101;
 
 create table watch_history(
	history_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id int,
    movie_id int,
    watched_at datetime,
    duration int, 
    
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)

 ) AUTO_INCREMENT = 1001;
 
 -- 데이터 삽입
 
 INSERT INTO users( name, subscription) VALUES
	('민수', 'vip'),
	('지현', 'premium'),
	('철수', 'free'),
	('영희', 'vip'),
	('나영', 'free');
 
 INSERT INTO movies(title, genre) VALUES
	('어벤져스', '액션'),
	('라라랜드', '로맨스'),
	('인사이드 아웃', '애니메이션'),
	('기생충', '드라마'),
	('인터스텔라', 'SF');
 
 INSERT INTO watch_history(user_id, movie_id, watched_at, duration) VALUES
	(1, 101, '2024-10-01 20:00:00', 120),
	(1 ,102, '2024-10-02 21:00:00', 110),
	(2, 103, '2024-10-03 19:30:00', 90),
    (3, 104, '2024-10-04 18:00:00', 130),
	(3, 101, '2024-10-05 17:00:00', 120),
	(4, 101, '2024-10-06 16:00:00', 115),
	(4, 105, '2024-10-07 15:00:00', 140),
	(5, 103, '2024-10-08 14:00:00', 95),
	(2, 101, '2024-10-09 13:00:00', 125),
	(1, 105, '2024-10-10 12:00:00', 130),
	(1, 101, '2024-10-11 22:00:00', 120),
	(1, 101, '2024-10-15 21:30:00', 125);
    
    
-- 영화를 한 번이라도 시청한 사용자들의 이름과 시청한 영화 제목을 모두 출력
SELECT users.name, movies.title 
FROM users 
JOIN watch_history ON users.user_id = watch_history.user_id
JOIN movies ON watch_history.movie_id = movies.movie_id;

-- 각 장르별로 시청된 총 횟수(watch_history 기준). 한 영화가 여러번 시청될 수 있음
SELECT movies.genre, COUNT(*) AS view_count
FROM watch_history
JOIN movies ON watch_history.movie_id = movies.movie_id
GROUP BY movies.genre
ORDER BY view_count DESC;

-- 사용자별로 총 시청 시간이 1000분 이상인 사용자들의 이름과 총 시청 시간 출력
SELECT users.name, SUM(watch_history.duration) as total_duration
FROM users
JOIN watch_history ON users.user_id = watch_history.user_id
GROUP BY users.user_id, users.name
HAVING total_duration >= 1000
ORDER BY total_duration DESC;

-- vip사용자 중에서 액션 장르의 영화를 시청한 사용자의 이름과 시청한 영화 제목을 출력
SELECT users.name, movies.title
FROM users
JOIN watch_history ON users.user_id = watch_history.user_id
JOIN movies ON watch_history.movie_id = movies.movie_id
WHERE movies.genre = '액션'and users.subscription = 'vip';

-- 가장 많이 시청된 영화의 제목과 시청 횟수
-- SELECT movies.title,  count(*) as view_count
-- FROM movies
-- JOIN watch_history ON watch_history.movie_id = movies.movie_id
-- GROUP BY movies.title
-- ORDER BY view_count DESC
-- LIMIT 1;

SELECT movies.title, COUNT(*) as view_count
FROM movies
JOIN watch_history ON movies.movie_id = watch_history.movie_id
GROUP BY movies.title
HAVING view_count = (
    SELECT MAX(cnt) 
    FROM (
        SELECT COUNT(*) as cnt 
        FROM watch_history 
        GROUP BY movie_id
    ) as view_counts
);

-- 각 구독 유형별로 영화를 시청한 평균 시청 시간. 단 시청 기록이 없는 구독 유형은 결과에서 제외
SELECT 
    (SELECT subscription FROM users WHERE user_id = watch_history.user_id) AS subscription, 
    AVG(duration) AS avg_duration
FROM watch_history
GROUP BY subscription;
