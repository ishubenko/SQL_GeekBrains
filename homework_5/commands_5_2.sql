
-- Задание 1 AVG
SELECT * FROM users;
SELECT name, birthday_at, TIMESTAMPDIFF(YEAR, birthday_at, NOW()) age FROM users;
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) age FROM users;

-- Задание 2
SELECT name, birthday_at FROM users;
SELECT 
  DATE_FORMAT(
    DATE(
      CONCAT_WS(
      '-', YEAR(NOW()), MONTH (birthday_at), DAY (birthday_at)
      )
    ) ,'%W'
  ) date_in_2020, 
COUNT(*) numb
FROM users 
GROUP BY date_in_2020
ORDER BY numb DESC;



