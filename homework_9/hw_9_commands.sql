-- Практическое задание по теме “Транзакции, переменные, представления”
-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

SHOW TABLES;
SHOW DATABASES;
CREATE DATABASE sample;
USE sample;
USE shop;
DESC users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
DESC users;
SELECT * FROM users;

-- START TRANSACTION;
-- SELECT @var_name:= name, @var_bday:=birthday_at FROM users WHERE id = 1;
-- DELETE FROM users WHERE id = 1;
-- USE sample;
-- SELECT @var, @var_bday;
-- INSERT INTO users VALUES (1, @var_name, @var_bday, DEFAULT, DEFAULT );
-- SELECT * FROM users;
-- COMMIT;

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;


-- Задание 2.
-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
USE shop;
SELECT * FROM products p ;
SELECT * FROM catalogs c ;
-- SELECT products.name, catalogs.name FROM products JOIN catalogs ON products.catalog_id = catalogs.id;
CREATE OR REPLACE VIEW prd AS 
  SELECT products.name AS prod, catalogs.name AS catal 
  FROM products JOIN catalogs 
  ON products.catalog_id = catalogs.id;
 
SELECT * FROM prd;
SHOW TABLES;



-- Задание 3. (по желанию) 
-- Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года 
-- '2018-08-01', '2016-08-04', '2018-08-16' и --  2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
-- если дата присутствует в исходном таблице и 0, если -- она отсутствует.
CREATE TABLE IF NOT EXISTS posts(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);
INSERT INTO posts VALUES
  (NULL, 'первая запись','2018-08-01'),
  (NULL, 'вторая запись','2018-08-04'),
  (NULL, 'третья запись','2018-08-16'),
  (NULL, 'четвертая запись','2018-08-17');
 SELECT * FROM posts;
 
CREATE TEMPORARY TABLE last_days (day INT);
INSERT INTO last_days VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),
  (10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
  (21),(22),(23),(24),(25),(26),(27),(28),(29),(30);

SELECT 
   DATE(DATE('2018-08-01') - INTERVAL l.day DAY) AS day,
   NOT ISNULL(p.name) AS order_exist 
FROM last_days AS l
  LEFT JOIN posts AS p
  ON DATE(DATE('2018-08-01') - INTERVAL l.day DAY) = p.created_at
ORDER BY day;

  
-- Задание 4. (по желанию) 
-- Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, 
-- оставляя только 5 самых свежих записей.


-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)
-- Задание 1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
-- второму пользователю shop — любые операции в пределах базы данных shop.
SELECT host, user FROM mysql.`user` u ;
SELECT USER();
CREATE USER director IDENTIFIED WITH sha256_password BY 'pass';
CREATE USER administrator IDENTIFIED WITH sha256_password BY 'pass';
DROP USER director;
DROP USER administrator;
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'shop';
CREATE USER shop IDENTIFIED WITH sha256_password BY 'shop';
GRANT SELECT ON shop.* TO shop_read;
GRANT ALL ON shop.* TO shop;
-- SHOW GRANTS;


-- Задание 2. (по желанию) 
-- Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, 
-- имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.




-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- Задание 1.
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;

DELIMITER $$
CREATE FUNCTION hello() 
RETURNS TINYTEXT NO SQL
BEGIN
  DECLARE hour INT;
  SET hour = HOUR(NOW);
  CASE 
    WHEN  hour BETWEEN 6 AND 11
	THEN RETURN "Доброе утро";
	WHEN  hour BETWEEN 12 AND 17
	THEN RETURN "Добрый день";
	WHEN  hour BETWEEN 18 AND 23
	THEN RETURN "Добрый вечер";
    WHEN  hour  BETWEEN 0 AND 5
    THEN RETURN "Доброй ночи";
  END CASE;
END $$
DELIMITER ;


-- Задание 2.
-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

SELECT * FROM products;
DESC products;

INSERT INTO products VALUES ('9','text','text2','123','2',DEFAULT,DEFAULT);
DELETE FROM products WHERE id = 9;

DROP TRIGGER IF EXISTS wrong_insert;

-- DELIMITER $$
-- CREATE TRIGGER wrong_insert BEFORE INSERT on products
--  FOR EACH ROW
--  BEGIN 
-- 	  DECLARE var_a VARCHAR(100);
-- 	  DECLARE var_b VARCHAR(100);
-- 	  SELECT name INTO var_a FROM products;
-- 	  SELECT description INTO var_b FROM products;
-- 	  IF var_a IS NULL AND var_b IS NULL THEN
-- 	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'insert canceled';
-- 	  END IF;
--  END $$
--  DELIMITER ;
DELIMITER $$
CREATE TRIGGER wrong_insert BEFORE INSERT on products
  FOR EACH ROW
  BEGIN 
    IF NEW.name IS NULL AND NEW.description IS NULL THEN
 	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'insert canceled';
	END IF;
  END $$
CREATE TRIGGER wrong_update BEFORE UPDATE on products
  FOR EACH ROW
  BEGIN 
    IF NEW.name IS NULL AND NEW.description IS NULL THEN
 	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'insert canceled';
	END IF;
  END $$
DELIMITER;




