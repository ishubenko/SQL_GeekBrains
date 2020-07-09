-- ЗАДАНИЕ 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM orders;
DESC orders;
DESC users;
INSERT INTO orders VALUES (1,2,NULL,NULL);
INSERT INTO orders VALUES (NULL,4,NULL,NULL);
INSERT INTO orders VALUES (NULL,4,DEFAULT,DEFAULT);
UPDATE orders SET created_at = DEFAULT, updated_at = DEFAULT WHERE id = 1;
UPDATE orders SET created_at = DEFAULT, updated_at = DEFAULT WHERE id = 2;
INSERT INTO orders VALUES (NULL,5,DEFAULT,DEFAULT);
INSERT INTO orders VALUES (NULL,6,DEFAULT,DEFAULT);
INSERT INTO orders VALUES (NULL,5,DEFAULT,DEFAULT);

SELECT * FROM users WHERE id = ANY(SELECT user_id FROM orders );


-- ЗАДАНИЕ 2 Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT * FROM products;
SELECT * FROM catalogs;

SELECT prod.name, prod.catalog_id, catal.name 
FROM products AS prod JOIN catalogs AS catal
ON prod.catalog_id = catal.id ;

-- ЗАДАНИЕ 3 (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и 
-- таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, 
-- поле name — русское. Выведите список рейсов flights с русскими названиями городов.

-- TRUNCATE TABLE flights ;
-- DROP TABLE flights;

CREATE TABLE flights (
  id INT(10) PRIMARY KEY AUTO_INCREMENT,
  from_city VARCHAR(30),
  to_city VARCHAR(30)
);

INSERT INTO flights VALUES
(NULL,'moscow','omsk'),
(NULL,'novgorod','kazan'),
(NULL,'irkutsk','moscow'),
(NULL,'omsk','irkutsk'),
(NULL,'moscow','kazan');


CREATE TABLE cities (
  label VARCHAR(30) PRIMARY KEY,
  name VARCHAR(30)
);
INSERT INTO cities VALUES
('moscow','Москва'),
('irkutsk','Иркутск'),
('novgorod','Новгород'),
('kazan','Казань'),
('omsk','Омск');

SELECT * FROM flights;
SELECT * FROM cities;

(SELECT id, to_city, name FROM flights AS fl JOIN cities AS ct ON to_city = label);
SELECT name FROM flights AS fl JOIN cities AS ct ON to_city = label;
SELECT name FROM flights AS fl JOIN cities AS ct ON from_city = label;
SELECT name, label FROM flights AS fl JOIN cities AS ct ON from_city = label;

SELECT 
DISTINCT flights.id,
otkuda.name AS fr_ct,
kuda.name AS to_ct
FROM 
flights JOIN (SELECT name, label FROM flights AS fl JOIN cities AS ct ON from_city = label) AS otkuda
ON flights.from_city = otkuda.label
JOIN (SELECT name, label FROM flights AS fl JOIN cities AS ct ON to_city = label) AS kuda
ON flights.to_city = kuda.label
ORDER BY flights.id;



-- (SELECT id, name, name FROM flights AS fl JOIN cities AS ct ON to_city = label, from_city = label);
-- SELECT id, 
--  'откуда', 
-- (SELECT name FROM flights AS fl JOIN cities AS ct ON to_city = label) AS kuda 
-- FROM flights;



