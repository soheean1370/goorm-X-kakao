select 'hello world';
show databases;
create database mydb; -- 생성
use mydb;
drop database mydb; -- 삭제


CREATE TABLE burgers (
id INTEGER PRIMARY KEY,
name VARCHAR(50),
price INTEGER,
gram INTEGER,
kcal INTEGER,
protein INTEGER
); 

DESC burgers;

INSERT INTO burgers (
id,
name,
price,
gram,
kcal,
protein
)

values(1, "myburger": )