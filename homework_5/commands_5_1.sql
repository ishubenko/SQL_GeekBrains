-- Задание 1
UPDATE users SET created_at = NOW();
-- Одной команды будет достаточно, так как updated_at автоматически заполнится при обновлении created_at

-- Задание 2
mysql> ALTER TABLE users DROP COLUMN created_at;
mysql> ALTER TABLE users DROP COLUMN updated_at;
-- Удаляем столбцы created_at и updated_at

ALTER TABLE users ADD COLUMN  created_at VARCHAR(25);
ALTER TABLE users ADD COLUMN  updated_at VARCHAR(25);
-- Добавляем столбцы created_at и updated_at с типом VARCHAR

UPDATE users SET created_at = '20.10.2017 8:10';
UPDATE users SET updated_at = '20.10.2017 8:10';
-- Заполняем данными в формате 20.10.2017 8:10

-- UPDATE users SET created_at = DATE_FORMAT(created_at, '%d.%m.%Y %H:%m');
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i' );
UPDATE users SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i' );
-- Меняем формат даты/времени

-- ALTER TABLE users SET created_at = DATETIME DEFAULT CURRENT_TIMESTAM;
ALTER TABLE users CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users CHANGE updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP; 
-- Меняем тип данных.

SELECT * FROM users;
DESC users;

-- Задание 3
SELECT * FROM storehouses_products;
DESC storehouses_products;
-- СТроки не заполнены
INSERT INTO storehouses_products(id,value) VALUES(1,0);
INSERT INTO storehouses_products(id,value) VALUES(2,2500), (3,0), (4,30), (5,500), (6,1);

-- SELECT * FROM storehouses_products GROUP BY value ;
-- SELECT value IF(value = 0, value ) FROM storehouses_products;
SELECT * FROM storehouses_products ORDER BY IF(value = 0, 1, 0), value;

-- Задание 4
-- SELECT * FROM users;
-- SELECT name, 
--  IF(
--  DATE_FORMAT(birthday_at, '%m') = 05 
--  AND 
--  DATE_FORMAT(birthday_at, '%m') = 08
--)
-- FROM users;

SELECT name, 
  CASE
    WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may' 
--    END mon
    WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august' 
    END mon
--  IF(DATE_FORMAT(birthday_at, '%m') = 08, 'august', '') mon
  FROM users WHERE 
  DATE_FORMAT(birthday_at, '%m') = 05 
  OR 
  DATE_FORMAT(birthday_at, '%m') = 08;

-- Задание 5
-- SELECT * FROM catalogs;
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2);

