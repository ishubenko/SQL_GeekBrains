-- -------------------------------------ЗАДАНИЕ 3 --------------------------------------
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
-- Прошу обратить внимание, что у меня поле gender необязательно для заполнения

-- SELECT COUNT(user_id) AS women FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'f');
-- SELECT COUNT(user_id) AS men FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'm');

SELECT 
 COUNT(IF(profiles.gender = 'm' OR profiles.gender = 'f', profiles.gender, NULL)) AS likes_count, -- отсеиваю пользователей, неказавших свой пол
 gender
-- likes.user_id, IF(profiles.gender = 'm' OR profiles.gender = 'f', profiles.gender, NULL) 
FROM likes LEFT JOIN profiles ON likes.user_id = profiles.user_id
 GROUP BY gender
 ORDER BY likes_count DESC 
 LIMIT 1;


-- -------------------------------------ЗАДАНИЕ 4 --------------------------------------
-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей

DESC likes;
SELECT * FROM likes;

CREATE TABLE target_types (
  id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
--  FOREIGN KEY (id) REFERENCES likes(target_type_id)
);
INSERT INTO target_types VALUES 
(1,'messages',DEFAULT),
(2,'users',DEFAULT),
(3,'media',DEFAULT),
(4,'posts',DEFAULT);
SELECT * FROM target_types;
ALTER TABLE likes 
  ADD CONSTRAINT target_types_fk
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);

(SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10);

SELECT COUNT(likes.id) AS young_likes_sum
-- likes.target_id, likes.target_type_id, young.birthday 
FROM likes RIGHT JOIN (SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10) AS young ON likes.target_id = young.user_id 
WHERE target_type_id = 2;



-- -------------------------------------ЗАДАНИЕ 5 --------------------------------------
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- критерии активности необходимо определить самостоятельно (кол-во постов)

 SELECT * FROM posts WHERE user_id = 46;
 SELECT * FROM likes WHERE user_id = 46;
 SELECT * FROM messages WHERE from_user_id = 46;
-- SELECT * from users;


SELECT level_2.id_of_user, level_2.first_name, (numb_post + numb_likes + (COUNT(messages.from_user_id))) AS total_activity
FROM
  (SELECT level_1.id_of_user, level_1.first_name, level_1.numb_post, (COUNT(likes.id)) AS numb_likes
  FROM
    (SELECT users.id AS id_of_user, users.first_name, COUNT(posts.id) AS numb_post FROM users 
    LEFT JOIN posts ON users.id = posts.user_id
    GROUP BY users.id) 
    AS level_1
  LEFT JOIN likes ON level_1.id_of_user = likes.user_id 
  GROUP BY level_1.id_of_user) AS level_2
LEFT JOIN messages ON level_2.id_of_user = messages.from_user_id
GROUP BY level_2.id_of_user
ORDER BY total_activity 
LIMIT 10;













