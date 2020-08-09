-- Задания на БД vk:

-- 1. Проанализировать какие запросы могут выполняться наиболее
-- часто в процессе работы приложения и добавить необходимые индексы.

SHOW INDEX FROM users;
SHOW INDEX FROM messages;
SHOW INDEX FROM profiles;
SHOW INDEX FROM posts;

CREATE INDEX messages_from_user_id_to_user_id_idx ON messages(from_user_id, to_user_id); -- из вэбинара, сообщения от пользователя
CREATE INDEX profiles_photo_id_idx ON profiles(photo_id); -- Открытие фото профиля 
CREATE INDEX likes_target_id_idx ON likes(target_id); -- лайки цели
CREATE INDEX posts_media_id_idx ON posts(media_id); -- фото поста в ленте новостей

-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- + имя группы
-- среднее количество пользователей в группах
-- + самый молодой пользователь в группе
-- + самый старший пользователь в группе
-- + общее количество пользователей в группе
-- + всего пользователей в системе
-- + отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
-- SELECT * FROM communities_users;
-- DESC communities_users;
-- SELECT * FROM profiles p2 WHERE user_id IN (21,55);
 

SELECT DISTINCT 
--  communities.id,
  communities.name AS community,
   COUNT(communities_users.user_id) OVER w AS users_per_group,
   COUNT(communities_users.user_id) OVER () / COUNT(communities_users.community_id) OVER() AS average,
   MIN(profiles.birthday) OVER w AS oldest,
   MAX(profiles.birthday) OVER w AS young,
   COUNT(communities_users.user_id ) OVER() AS numb_of_users,
   (COUNT(communities_users.user_id) OVER w / COUNT(communities_users.community_id) OVER())*100 AS '%percent'
--  communities_users.community_id,
--  communities_users.user_id 
  FROM communities  
  LEFT JOIN communities_users ON communities_users.community_id = communities.id
  LEFT JOIN profiles ON communities_users.user_id = profiles.user_id
    WINDOW 
      w AS (PARTITION BY communities_users.community_id);
--      w2 AS (PARTITION BY profiles.);



-- 3. (по желанию) Задание на денормализацию
-- Разобраться как построен и работает следующий запрос:
-- Найти 10 пользователей, которые проявляют наименьшую активность
-- в использовании социальной сети.

SELECT users.id,
COUNT(DISTINCT messages.id) +
COUNT(DISTINCT likes.id) +
COUNT(DISTINCT media.id) AS activity
FROM users
LEFT JOIN messages
ON users.id = messages.from_user_id
LEFT JOIN likes
ON users.id = likes.user_id
LEFT JOIN media
ON users.id = media.user_id
GROUP BY users.id
ORDER BY activity
LIMIT 10;

-- Правильно-ли он построен?
-- Какие изменения, включая денормализацию, можно внести в структуру БД
-- чтобы существенно повысить скорость работы этого запроса?
SELECT * FROM messages m ;
SELECT * FROm profiles p2 ;
-- Вероятно производительность можно увеличить с помощью добавления счетчиков - дополнительных полей в профиле и трмггеров AFTER которые будут изменять счетчик
-- Например счетчик сообщения, инициированных пользователем
ALTER TABLE profiles ADD COLUMN count_messages INT(50);
UPDATE profiles SET count_messages = 0;
SELECT * FROM profiles;

DROP TRIGGER new_message;
DESC messages ;

INSERT INTO messages VALUES (NULL,1,25,'body',1,1,DEFAULT,DEFAULT);
SELECT * FROM messages;
SELECT * FROM profiles p ;




DELIMITER $$
CREATE TRIGGER new_message AFTER INSERT ON messages
  FOR EACH ROW
    BEGIN 
 	    DECLARE mes_fr_id INT(50);
-- 	    SELECT count_messages INTO @ FROM profiles;
--        SELECT count_messages FROM profiles;
        SELECT from_user_id INTO mes_fr_id FROM messages ORDER BY messages.id DESC LIMIT 1;
        UPDATE profiles SET count_messages = (count_messages +1) WHERE profiles.user_id = mes_fr_id ;
--        SELECT count_messages INTO ct_mes FROM profiles;
--        SET NEW.count_messages = (ct_mes + 1);
    END $$
DELIMITER;





