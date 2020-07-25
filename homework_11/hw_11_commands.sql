-- Практическое задание по теме “Оптимизация запросов”
-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
SELECT * FROM users;
SELECT * FROM catalogs;
SELECT * FROM products;
SELECT * FROM logs;

DROP TABLE logs;
CREATE TABLE logs (
  created_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  table_name VARCHAR(255),
  foreign_id INT(30),
  foreign_name VARCHAR(255)
)ENGINE = Archive;

DROP TRIGGER add_log_users;
DROP TRIGGER add_log_catalogs;
DROP TRIGGER add_log_products;

DELIMITER $$
CREATE TRIGGER add_log_users AFTER INSERT ON users
-- , catalogs, products
  FOR EACH ROW
    BEGIN 
	    DECLARE usr_fg_id INT(30);
	    DECLARE usr_fg_name VARCHAR(255);
	    SELECT id, name INTO usr_fg_id, usr_fg_name FROM users ORDER BY users.id DESC LIMIT 1;
	    INSERT INTO logs VALUES (DEFAULT, 'users', usr_fg_id, usr_fg_name);
    END $$
CREATE TRIGGER add_log_catalogs AFTER INSERT ON catalogs
  FOR EACH ROW
    BEGIN 
	    DECLARE cat_fg_id INT(30);
	    DECLARE cat_fg_name VARCHAR(255);
	    SELECT id, name INTO cat_fg_id, cat_fg_name FROM catalogs ORDER BY catalogs.id DESC LIMIT 1;
	    INSERT INTO logs VALUES (DEFAULT, 'catalogs', cat_fg_id, cat_fg_name);
    END $$
CREATE TRIGGER add_log_products AFTER INSERT ON products
  FOR EACH ROW
    BEGIN 
	    DECLARE prd_fg_id INT(30);
	    DECLARE prd_fg_name VARCHAR(255);
	    SELECT id, name INTO prd_fg_id, prd_fg_name FROM products ORDER BY products.id DESC LIMIT 1;
	    INSERT INTO logs VALUES (DEFAULT, 'products', prd_fg_id, prd_fg_name);
    END $$
DELIMITER;

INSERT INTO users VALUES (NULL, 'Костя', '1985-04-24', DEFAULT, DEFAULT);
INSERT INTO catalogs VALUES (NULL, 'CD-Roms');

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- DELIMITER $$
-- CREATE PROCEDURE million
--   BEGIN
	  
--   END
-- DELIMITER;



-- Практическое задание по теме “NoSQL”
-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
127.0.0.1:6379> SADD ipadresses 192.168.0.1 10.39.39.10 176.85.46.3 89.20.155.12
(integer) 4
127.0.0.1:6379> SMEMBERS ipadresses
1) "176.85.46.3"
2) "89.20.155.12"
3) "10.39.39.10"
4) "192.168.0.1"
127.0.0.1:6379> 


-- Предполагаю, что для подсчета нам потребуется HASH, где значение пары будет счетчик
127.0.0.1:6379> HSET uniq_ip 192.168.0.1 '0' 10.39.39.10 '0' 176.85.46.3 '0' 89.20.155.12 '0'
(integer) 4
127.0.0.1:6379> 
127.0.0.1:6379> HVALS uniq_ip
1) "0"
2) "0"
3) "0"
4) "0"
127.0.0.1:6379> HGET uniq_ip 192.168.0.1
"0"
127.0.0.1:6379> HGET uniq_ip 10.39.39.10
"0"
127.0.0.1:6379> 


-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
-- поиск электронного адреса пользователя по его имени.
127.0.0.1:6379> TYPE ipadresses
set
127.0.0.1:6379> SADD alex alx90@gmail.com
(integer) 1
127.0.0.1:6379> SADD petr ptr87@yandex.ru
(integer) 1
127.0.0.1:6379> SADD vladimir vld@yahoo.com
(integer) 1
127.0.0.1:6379> 
127.0.0.1:6379> 
127.0.0.1:6379> 
127.0.0.1:6379> SADD alx90@gmail.com alex
(integer) 1
127.0.0.1:6379> SADD ptr87@yandex.ru petr
(integer) 1
127.0.0.1:6379> SADD vld@yahoo.com vladimir
(integer) 1
127.0.0.1:6379> SINTER alex
1) "alx90@gmail.com"
127.0.0.1:6379> SINTER alx90@gmail.com
1) "alex"
127.0.0.1:6379> 


-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
SELECT * FROM catalogs;
SELECT * FROM products;

> db.shop.find()
{ "_id" : ObjectId("5f1bf2f31009daa91174bc39"), 
  "name" : "Процессоры", 
  "id_1" : { "name" : "Intel Core i3-8100", "price":"7890","description":"Процессор для настольных персональных компьютеров, основанных на платформе Intel." }, 
  "id_2" : { "name" : "Intel Core i5-7400", "price" : "12700", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе Intel." }, 
  "id_3" : { "name" : "AMD FX-8320E", "price" : "4780", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD." }, 
  "id_4" : { "name" : "AMD FX-8320", "price" : "7120", "description" : "Процессор для настольных персональных компьютеров, основанных на платформе AMD." } 
}
{ "_id" : ObjectId("5f1bfadb1009daa91174bc3a"), 
  "name" : "Материнские платы", 
  "id_5" : { "name" : "ASUS ROG MAXIMUS X HERO", "price" : "19310", "description" : "Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX" }, 
  "id_6" : { "name" : "Gigabyte H310M S2H", "price" : "4790", "description" : "Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX" }, 
  "id_7" : { "name" : "MSI B250M GAMING PRO", "price" : "5060", "description" : "Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX" } 
}
> 





