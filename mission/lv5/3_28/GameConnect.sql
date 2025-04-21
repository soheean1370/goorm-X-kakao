DROP DATABASE IF EXISTS gameConnect;
CREATE DATABASE gameConnect;
USE gameConnect;

CREATE TABLE User (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    join_date DATE
);

CREATE TABLE Game (
    game_id INT PRIMARY KEY,
    title VARCHAR(50),
    genre VARCHAR(50),
    platform VARCHAR(50)
);

CREATE TABLE PlayLog (
    user_id INT,
    game_id INT,
    play_date DATE,
    play_time_minutes INT,
    
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

CREATE TABLE Friendship (
    user_id1 INT,
    user_id2 INT,
    since_date DATE,
    
    FOREIGN KEY (user_id1) REFERENCES User(user_id),
    FOREIGN KEY (user_id2) REFERENCES User(user_id)
);

CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    user_id INT,
    game_id INT,
    rating INT,
    comment VARCHAR(50),
    
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

CREATE TABLE GameRecommendation (
    from_user INT,
    to_user INT,
    game_id INT,
    rec_date DATE,
    
    FOREIGN KEY (from_user) REFERENCES User(user_id),
    FOREIGN KEY (to_user) REFERENCES User(user_id),
    FOREIGN KEY (game_id) REFERENCES Game(game_id)
);

-- 데이터 삽입
INSERT INTO User (user_id, username, join_date) VALUES
(1, 'alice', '2023-01-10'),
(2, 'bob', '2023-02-15'),
(3, 'charlie', '2023-03-01'),
(4, 'diana', '2023-03-10'),
(5, 'eric', '2023-04-05');
INSERT INTO Game (game_id, title, genre, platform) VALUES
(101, 'Apex Legends', 'FPS', 'PC'),
(102, 'Zelda: Breath of the Wild', 'Adventure', 'Switch'),
(103, 'Stardew Valley', 'Simulation', 'PC'),
(104, 'Overwatch 2', 'FPS', 'PC'),
(105, 'Hollow Knight', 'Metroidvania', 'PC');
INSERT INTO PlayLog (user_id, game_id, play_date, play_time_minutes) VALUES
(1, 101, '2023-05-01', 120),
(2, 101, '2023-05-02', 200),
(3, 101, '2023-05-03', 180),
(1, 102, '2023-05-04', 90),
(4, 103, '2023-05-05', 240),
(5, 104, '2023-05-06', 60),
(3, 105, '2023-05-07', 150),
(3, 103, '2023-05-08', 100);
INSERT INTO Friendship (user_id1, user_id2, since_date) VALUES
(1, 2, '2023-04-01'),
(1, 3, '2023-04-02'),
(2, 4, '2023-04-03'),
(2, 5, '2023-04-04'),
(3, 4, '2023-04-05');
INSERT INTO Review (review_id, user_id, game_id, rating, comment) VALUES
(201, 1, 101, 5, 'Awesome game'),
(202, 2, 101, 4, 'Fast paced'),
(203, 3, 101, 5, 'Very competitive'),
(204, 1, 102, 4, 'Beautiful world'),
(205, 3, 103, 5, 'Very relaxing'),
(206, 4, 103, 4, 'Charming'),
(207, 3, 105, 4, 'Challenging'),
(208, 2, 105, 3, 'Too hard');
INSERT INTO GameRecommendation (from_user, to_user, game_id, rec_date) VALUES
(1, 3, 101, '2023-06-01'),
(2, 3, 105, '2023-06-02'),
(4, 3, 103, '2023-06-03'),
(3, 1, 105, '2023-06-04');

-- 사용자 목록 출력. 사용자의 username과 가입일 출력
SELECT username, join_date FROM User;

-- 각 사용자가 플레이한 게임의 제목과 플레이 시간을 출력
SELECT User.username, Game.title, PlayLog.play_time_minutes
FROM User
JOIN PlayLog ON User.user_id = PlayLog.user_id
JOIN Game ON PlayLog.game_id = Game.game_id;

-- 모든 게임 리뷰 중에서 평점이 5점인 리뷰의 사용자 이름과 게임 제목을 출력하세요.
SELECT User.username, Game.title, Review.rating
FROM User
JOIN Review ON User.user_id = Review.user_id
JOIN Game ON Review.game_id = Game.game_id
WHERE Review.rating = 5;

-- 각 게임 장르(genre)별로 몇 개의 게임이 등록되어 있는지 구하세요.
SELECT Game.genre, COUNT(*) as game_count
FROM Game
GROUP BY genre;

-- 각 사용자가 몇 명의 친구를 맺고 있는지 구하세요
WITH Friends AS (
    SELECT user_id1 AS user_id FROM Friendship
    UNION ALL
    SELECT user_id2 FROM Friendship
)
SELECT User.username, COUNT(*) AS friend_count
FROM User
JOIN Friends ON User.user_id = Friends.user_id
GROUP BY User.username
ORDER BY friend_count DESC;
