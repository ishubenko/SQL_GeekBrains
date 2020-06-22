-- USE vk;

-- Создаём таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";  

-- Таблица профилей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender CHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  photo_id INT UNSIGNED COMMENT "Ссылка на основную фотографию пользователя",
  city VARCHAR(130) COMMENT "Город проживания",
  country VARCHAR(130) COMMENT "Страна проживания",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили"; 

-- Таблица сообщений

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на отправителя сообщения",
  to_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя сообщения",
  body TEXT NOT NULL COMMENT "Текст сообщения",
  is_important BOOLEAN COMMENT "Признак важности",
  is_delivered BOOLEAN COMMENT "Признак доставки",
  created_at DATETIME DEFAULT NOW() COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Сообщения";

-- Таблица дружбы
DROP TABLE IF EXISTS friendships;
CREATE TABLE friendships (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на инициатора дружеских отношений",
  friend_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя приглашения дружить",
  status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус (текущее состояние) отношений",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время отправления приглашения дружить",
  confirmed_at DATETIME COMMENT "Время подтверждения приглашения",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, friend_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";

-- Таблица статусов дружеских отношений
DROP TABLE IF EXISTS friendship_statuses;
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название статуса"
--  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
--  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Статусы дружбы";

INSERT INTO friendship_statuses (id, name) VALUES (1, "Принято");
INSERT INTO friendship_statuses (id, name) VALUES (2, "Отказ");

-- Таблица групп
DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор сроки",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"  
) COMMENT "Группы";

-- Таблица связи пользователей и групп
DROP TABLE IF EXISTS communities_users;
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "Ссылка на группу",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки", 
  PRIMARY KEY (community_id, user_id) COMMENT "Составной первичный ключ"
) COMMENT "Участники групп, связь между пользователями и группами";

-- Таблица медиафайлов
DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя, который загрузил файл",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

-- Таблица типов медиафайлов
DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа"
--  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
--  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

INSERT INTO `media_types` (`id`, `name`) VALUES (1, 'photo');
INSERT INTO `media_types` (`id`, `name`) VALUES (2, 'audio');
INSERT INTO `media_types` (`id`, `name`) VALUES (3, 'video');
INSERT INTO `media_types` (`id`, `name`) VALUES (4, 'post');


DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  like_status CHAR(1) COMMENT "1 - Like, 0 - Unlike",
  media_id INT NOT NULL COMMENT " ссылка на таблицу media_types. ID: тип контента мадиа/пост/юзер ",
--  content_type CHAR(1) UNSIGNED COMMENT "тип контента, мадиа/пост/юзер",
--  media_id INT UNSIGNED COMMENT "Ссылка на идентификатор медиафайла"
--  post_id INT UNSIGNED COMMENT "Ссылка на идентификатор поста"
--  user_id INT UNSIGNED COMMENT "Ссылка на идентификатор пользователя"
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время нажатия на лайк",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления статуса Like/Unlike"
)

-- DROP TABLE IF EXISTS Content;
-- CREATE TABLE Content (
--  content_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID контента",
--  media_id

-- Рекомендуемый стиль написания кода SQL
-- https://www.sqlstyle.guide/ru/

-- Заполняем таблицы с учётом отношений 
-- на http://filldb.info

-- Документация
-- https://dev.mysql.com/doc/refman/8.0/en/
-- http://www.rldp.ru/mysql/mysql80/index.htm


INSERT INTO communities (id, name, created_at, updated_at) VALUES (1, 'geekbrains', '1997-11-18 22:43:00', '2002-05-29 10:29:59');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (2, 'totalfloorball', '1977-04-30 23:55:26', '2006-07-03 20:14:22');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (3, 'netbynet', '2011-02-17 11:27:22', '1997-02-07 04:22:00');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (4, 'beeline', '2008-03-11 09:42:43', '2002-09-06 00:04:36');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (5, 'megafon', '1993-02-04 09:02:29', '2014-06-22 19:15:15');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (6, 'pik', '1985-08-04 18:32:04', '1995-02-18 17:53:42');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (7, 'lukoil', '1981-10-11 04:07:12', '1995-10-05 22:39:39');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (8, 'gazprom', '2018-07-22 05:32:02', '1970-07-24 08:39:20');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (9, 'rosneft', '2019-08-19 06:53:00', '1974-09-11 11:34:54');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (10, 'apple', '2007-06-17 12:52:44', '1996-08-27 17:54:28');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (11, 'magnit', '2006-08-23 22:11:49', '1970-07-13 20:52:36');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (12, 'tenetur', '2008-07-24 00:04:31', '2005-06-16 17:02:11');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (13, 'ut', '1975-02-26 07:27:42', '2020-02-25 06:10:14');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (14, 'totam', '2011-10-02 23:18:35', '1972-09-20 07:44:22');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (15, 'nihil', '2014-02-19 01:26:34', '1972-07-21 05:14:23');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (16, 'voluptatibus', '1972-09-10 17:29:21', '1975-08-31 06:02:02');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (17, 'cumque', '2000-10-30 22:30:04', '1992-11-10 14:35:09');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (18, 'ipsa', '1987-09-16 21:29:25', '1999-03-30 20:49:28');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (19, 'atque', '1988-02-23 20:33:30', '2016-04-25 14:39:12');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (20, 'praesentium', '1993-01-31 04:50:06', '1995-05-01 00:00:20');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (21, 'maiores', '1975-04-07 21:04:48', '1979-08-14 19:20:25');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (22, 'necessitatibus', '1989-03-07 03:56:34', '1982-11-03 06:02:13');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (23, 'odio', '1978-08-15 04:44:57', '1977-01-16 23:59:19');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (24, 'quis', '2013-04-22 19:55:52', '2016-10-04 01:35:21');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (25, 'accusantium', '2001-11-03 10:50:51', '1980-12-02 13:50:20');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (26, 'alias', '2004-11-30 18:12:38', '1978-10-26 16:50:28');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (27, 'voluptas', '1982-12-08 13:46:18', '2017-04-30 18:16:55');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (28, 'error', '1972-08-21 07:20:11', '1993-07-11 09:10:54');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (29, 'sequi', '2015-04-04 22:26:15', '1999-05-18 11:57:12');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (30, 'aspernatur', '1991-01-21 14:08:11', '1986-02-23 02:49:48');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (31, 'aut', '2012-03-10 07:16:25', '1971-05-22 09:04:03');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (32, 'et', '1996-03-16 10:19:21', '1977-02-05 02:07:12');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (33, 'sunt', '2016-11-17 19:10:00', '1973-05-02 12:55:45');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (34, 'laborum', '2013-01-14 15:34:52', '2013-06-27 08:51:23');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (35, 'rerum', '1994-01-08 11:27:33', '1981-01-19 12:24:52');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (36, 'ea', '1983-12-26 08:16:50', '1972-12-03 12:39:45');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (37, 'assumenda', '1988-08-21 09:52:58', '2014-01-14 12:19:34');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (38, 'quasi', '1997-11-06 20:49:41', '1996-12-08 19:48:58');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (39, 'quidem', '2014-01-11 20:00:52', '1987-12-21 06:24:18');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (40, 'labore', '1975-12-03 18:19:05', '1995-06-22 16:51:10');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (41, 'fugit', '2001-08-11 07:44:59', '1995-05-31 04:34:26');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (42, 'odit', '1974-10-16 12:55:24', '1975-06-02 12:34:36');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (43, 'nemo', '1985-02-20 00:54:15', '2015-07-01 03:57:01');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (44, 'neque', '2018-09-09 05:02:49', '1987-07-10 04:56:23');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (45, 'at', '2006-07-07 06:43:56', '2007-04-05 19:17:52');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (46, 'saepe', '1990-10-06 02:23:14', '2014-03-19 22:40:10');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (47, 'repellendus', '2006-03-05 04:37:37', '1975-10-16 19:45:04');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (48, 'facilis', '1989-10-08 22:58:03', '1990-08-21 16:21:34');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (49, 'dolor', '1985-02-02 03:08:37', '1978-09-07 20:21:46');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (50, 'doloremque', '1978-01-12 11:53:18', '1980-05-02 00:23:08');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (51, 'iure', '1974-12-24 08:25:41', '2013-02-10 18:54:57');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (52, 'quos', '1990-08-12 22:43:08', '1993-04-13 05:37:54');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (53, 'consequatur', '1986-09-05 21:58:52', '2020-04-29 22:31:48');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (54, 'debitis', '2010-10-09 11:34:35', '2004-04-09 12:44:19');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (55, 'impedit', '2012-12-24 11:03:18', '1980-09-14 11:13:47');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (56, 'dolorem', '1995-08-25 23:27:31', '2000-09-30 22:22:01');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (57, 'reiciendis', '1981-07-13 02:50:19', '1975-10-30 20:58:11');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (58, 'id', '2003-02-13 07:58:47', '1981-09-16 14:52:26');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (59, 'natus', '1984-09-19 05:41:47', '2014-03-23 06:22:17');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (60, 'ex', '1976-02-19 09:52:20', '1988-10-18 13:13:04');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (61, 'eum', '2005-04-24 18:26:55', '2013-04-06 14:15:22');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (62, 'mollitia', '2013-01-06 03:23:06', '1985-05-29 00:58:01');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (63, 'ratione', '1996-01-07 11:40:13', '1991-09-02 13:25:35');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (64, 'delectus', '1984-08-10 01:32:24', '1982-09-15 23:34:30');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (65, 'facere', '1992-03-19 04:27:02', '2006-12-08 01:59:02');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (66, 'ullam', '1993-12-08 17:57:52', '1999-05-23 08:48:33');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (67, 'velit', '2004-05-30 11:31:17', '2012-09-05 20:48:38');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (68, 'fuga', '1976-03-12 08:18:33', '1998-11-08 07:44:44');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (69, 'vero', '1984-10-30 05:38:25', '2003-09-03 04:47:53');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (70, 'unde', '1990-01-06 23:16:34', '2017-02-01 15:41:34');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (71, 'nulla', '1980-09-20 23:17:22', '1997-08-08 13:23:14');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (72, 'doloribus', '1977-04-06 13:35:43', '2004-11-17 02:29:36');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (73, 'laboriosam', '1992-11-29 01:47:04', '1989-02-12 10:04:32');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (74, 'possimus', '1997-02-16 03:23:14', '1975-06-03 08:31:51');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (75, 'sed', '1976-10-01 11:07:23', '2004-10-23 22:10:17');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (76, 'qui', '2004-03-02 17:08:12', '1986-03-31 04:59:14');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (77, 'minus', '1990-12-25 15:32:33', '2014-01-19 03:10:03');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (78, 'consectetur', '1997-02-15 18:33:19', '1972-12-16 09:25:06');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (79, 'molestias', '1973-01-05 14:41:17', '2018-06-22 03:03:21');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (80, 'quam', '2014-10-11 03:10:29', '2011-09-14 11:14:10');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (81, 'soluta', '1977-09-29 09:43:04', '2005-05-08 19:46:26');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (82, 'perspiciatis', '2000-12-20 11:27:26', '1980-07-06 15:04:28');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (83, 'dicta', '1999-08-06 23:57:06', '1994-03-25 14:19:16');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (84, 'expedita', '2012-11-11 03:49:03', '1990-11-09 17:07:49');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (85, 'quibusdam', '1985-07-19 08:53:12', '1992-12-26 20:08:51');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (86, 'ipsum', '1973-12-20 12:17:53', '1994-11-12 05:50:06');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (87, 'dignissimos', '2001-02-28 03:13:39', '1975-04-28 20:00:36');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (88, 'vitae', '2018-12-11 14:51:25', '2012-02-12 03:22:37');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (89, 'eos', '1999-02-27 09:44:11', '1985-10-01 16:48:58');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (90, 'blanditiis', '1981-05-01 15:33:02', '2010-07-24 08:59:36');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (91, 'temporibus', '2017-03-14 06:18:01', '1978-02-08 13:21:16');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (92, 'hic', '2008-07-27 17:05:28', '2001-06-22 08:27:58');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (93, 'non', '1988-10-05 19:10:11', '1979-11-02 14:05:15');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (94, 'asperiores', '1989-04-02 07:17:32', '1999-10-26 04:49:28');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (95, 'corporis', '1974-09-07 02:27:34', '1970-10-24 14:47:05');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (96, 'autem', '2000-01-12 00:39:26', '1982-11-09 12:39:53');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (97, 'eaque', '1970-10-06 10:51:54', '1998-09-12 07:35:23');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (98, 'rem', '1998-04-25 22:41:04', '2017-11-22 08:03:22');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (99, 'explicabo', '1979-11-20 07:22:40', '2006-04-17 14:34:21');
INSERT INTO `communities` (`id`, `name`, `created_at`, `updated_at`) VALUES (100, 'aliquid', '2000-10-07 22:29:47', '2015-12-02 09:28:38');


-- #
-- # TABLE STRUCTURE FOR: communities_users
-- #
--
-- DROP TABLE IF EXISTS `communities_users`;
--
-- CREATE TABLE `communities_users` (
--  `community_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на группу',
--  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя',
--  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
--  PRIMARY KEY (`community_id`,`user_id`) COMMENT 'Составной первичный ключ'
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Участники групп, связь между пользователями и группами';

INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 21, '1994-09-20 03:16:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (2, 55, '2019-09-08 01:04:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (11, 70, '1990-12-07 10:02:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (12, 54, '2011-12-10 08:54:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (12, 84, '2006-03-30 11:28:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (15, 9, '1991-03-19 12:25:53');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (15, 65, '2015-05-19 02:02:08');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (15, 86, '2002-06-27 03:55:51');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (17, 62, '1982-05-14 04:29:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (19, 55, '1982-07-20 10:58:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (19, 78, '1999-10-21 01:55:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (21, 75, '2003-06-03 18:18:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (21, 80, '2016-12-19 03:30:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (22, 19, '1999-08-13 02:52:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (24, 43, '1971-09-05 16:29:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (24, 63, '1990-03-14 13:31:09');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (24, 83, '1971-04-02 06:49:29');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (25, 15, '2009-03-20 05:30:14');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (25, 63, '2008-08-18 18:18:26');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (26, 43, '1985-03-01 19:56:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (27, 6, '1982-07-21 21:30:09');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (27, 19, '2011-05-25 19:41:25');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (30, 28, '1971-04-28 06:00:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (30, 98, '1971-03-30 02:21:26');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (31, 87, '1983-07-05 19:15:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (33, 26, '1971-01-27 13:54:39');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (33, 91, '1998-06-08 07:37:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (34, 66, '2004-07-17 07:35:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (36, 39, '2013-05-13 19:52:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (36, 80, '1987-07-31 05:47:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (39, 43, '2007-04-08 12:18:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (39, 71, '2012-09-16 05:07:53');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (39, 94, '2011-10-23 13:06:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (41, 12, '1980-07-22 01:56:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (42, 40, '2000-09-12 22:16:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (42, 57, '2000-11-11 03:33:18');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (44, 19, '2005-03-06 20:27:18');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (45, 23, '2012-07-22 03:58:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (45, 92, '2000-09-10 18:58:27');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (46, 11, '2001-05-18 11:56:34');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (46, 69, '1991-07-12 10:12:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (46, 70, '2004-02-14 13:55:38');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (47, 79, '2011-01-10 16:35:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (49, 46, '1990-07-26 13:30:46');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (52, 58, '2012-10-21 19:30:01');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (53, 11, '1989-01-31 23:27:40');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (53, 43, '2012-04-05 21:56:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (53, 79, '1989-07-31 12:48:23');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (54, 24, '1991-01-25 11:12:03');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (54, 57, '1984-06-18 06:41:50');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (55, 14, '2005-01-06 18:23:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (57, 46, '2007-10-09 04:44:41');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (57, 97, '1997-04-26 14:24:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (58, 50, '2020-06-16 23:42:04');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (58, 59, '1978-01-03 13:09:42');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (58, 68, '1974-01-27 04:50:07');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (58, 70, '1982-10-07 10:21:35');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (59, 18, '2014-10-30 21:18:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (60, 30, '2012-10-19 09:37:45');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (60, 48, '1995-05-20 19:15:44');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (62, 84, '2006-03-08 02:33:00');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (62, 94, '1995-11-04 02:09:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (63, 48, '2010-10-18 21:15:14');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (63, 98, '1972-07-13 23:59:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (64, 61, '1979-05-01 22:08:43');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (64, 100, '2018-05-03 10:57:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (65, 46, '2010-06-24 03:29:53');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (66, 82, '1971-09-30 09:16:51');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (68, 84, '1974-07-06 20:34:46');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (69, 38, '2013-02-11 18:41:38');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (70, 39, '2016-04-26 10:30:09');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (71, 13, '2010-02-27 16:46:32');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (71, 64, '1996-09-02 04:27:25');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (73, 91, '2001-09-24 08:33:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (76, 59, '1972-04-10 11:17:18');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (78, 3, '1971-12-23 18:07:10');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (79, 17, '2008-07-02 06:56:11');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (79, 51, '1981-01-03 01:55:39');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (79, 83, '2001-10-28 09:15:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (79, 90, '1993-08-21 00:45:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (82, 60, '2009-07-31 15:00:16');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (82, 84, '2010-10-10 08:57:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (85, 10, '1976-10-21 09:56:36');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (85, 33, '2017-08-13 23:57:37');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (87, 58, '1980-07-08 19:00:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (90, 63, '1981-03-12 21:34:30');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (90, 81, '2009-10-22 20:35:20');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (92, 41, '2016-03-16 08:07:59');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (92, 56, '1987-08-04 22:10:56');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (92, 69, '2017-05-11 14:01:12');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (92, 97, '2018-08-18 08:44:24');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (94, 49, '2018-05-30 21:25:55');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (95, 24, '2017-12-21 03:15:18');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (96, 88, '1970-08-25 21:15:23');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (96, 99, '1970-10-24 08:45:26');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (97, 31, '2005-06-08 17:36:02');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (97, 83, '1994-01-02 10:13:28');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (99, 84, '1995-02-05 18:54:06');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (99, 87, '1977-05-31 12:53:31');
INSERT INTO `communities_users` (`community_id`, `user_id`, `created_at`) VALUES (100, 67, '1981-01-21 22:31:45');


-- #
-- # TABLE STRUCTURE FOR: friendship_statuses
-- #

-- DROP TABLE IF EXISTS `friendship_statuses`;

-- CREATE TABLE `friendship_statuses` (
--  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
--  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Название статуса',
--  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
--  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
--  PRIMARY KEY (`id`),
--  UNIQUE KEY `name` (`name`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Статусы дружбы';

-- #
-- # TABLE STRUCTURE FOR: friendships
-- #

-- DROP TABLE IF EXISTS `friendships`;

-- CREATE TABLE `friendships` (
--  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
--  `friend_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя приглашения дружить',
--  `status_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на статус (текущее состояние) отношений',
--  `requested_at` datetime DEFAULT current_timestamp() COMMENT 'Время отправления приглашения дружить',
--  `confirmed_at` datetime DEFAULT NULL COMMENT 'Время подтверждения приглашения',
--  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
--  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
--  PRIMARY KEY (`user_id`,`friend_id`) COMMENT 'Составной первичный ключ'
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица дружбы';

INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (1, 6, 1, '1997-04-23 20:14:15', '0000-00-00 00:00:00', '1990-10-02 18:55:58', '1974-03-24 17:43:33');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (3, 36, 0, '2000-11-11 16:41:09', '0000-00-00 00:00:00', '1994-08-15 05:15:03', '1972-10-17 02:28:58');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (3, 49, 2, '1976-10-15 13:47:29', '0000-00-00 00:00:00', '1994-11-10 14:04:43', '1993-04-15 06:17:15');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (3, 77, 0, '1992-04-19 09:09:40', '1987-04-15 16:38:05', '1997-12-28 01:33:22', '1987-09-26 13:21:10');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (3, 85, 2, '2019-09-09 21:55:43', '0000-00-00 00:00:00', '2009-03-25 03:00:05', '1974-05-16 16:42:40');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (4, 52, 0, '2006-12-26 05:53:49', '0000-00-00 00:00:00', '2013-08-06 22:42:58', '2016-05-22 21:47:14');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (5, 94, 0, '1998-04-04 07:00:38', '1997-10-26 18:14:15', '2011-07-05 11:10:57', '1971-04-11 15:10:42');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (6, 64, 2, '1982-02-23 17:51:22', '2005-01-07 15:02:20', '2003-12-06 10:10:38', '1999-07-24 03:29:22');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (7, 66, 2, '1988-05-30 19:48:28', '0000-00-00 00:00:00', '2007-11-25 08:10:20', '1990-06-20 00:12:13');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (7, 67, 2, '2007-09-05 23:35:52', '0000-00-00 00:00:00', '1994-01-16 07:49:11', '1980-02-18 02:09:01');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (11, 59, 0, '1987-12-08 21:19:20', '1997-06-01 05:26:48', '1994-04-27 15:07:22', '1995-07-10 06:41:47');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (13, 19, 0, '2019-10-02 19:20:34', '0000-00-00 00:00:00', '1972-05-10 14:40:34', '1982-04-06 13:26:49');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (14, 1, 0, '1976-02-09 11:14:50', '2010-11-12 19:13:21', '1971-01-20 15:42:42', '1985-12-19 08:05:08');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (14, 18, 1, '2006-06-16 05:12:54', '0000-00-00 00:00:00', '2004-08-18 21:10:45', '2003-06-27 09:50:49');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (18, 57, 0, '2018-09-24 06:18:44', '1999-10-23 22:56:51', '2011-04-03 16:46:32', '1996-08-15 16:50:40');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (19, 44, 1, '1982-02-20 12:13:28', '2012-03-23 04:40:01', '1985-06-09 00:30:10', '1973-03-12 22:18:09');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (20, 64, 0, '2011-09-18 18:09:31', '0000-00-00 00:00:00', '2016-05-08 19:34:06', '2013-05-26 00:57:40');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (22, 51, 0, '1996-03-15 06:55:43', '2015-09-01 00:24:36', '2009-12-02 02:58:54', '2001-04-27 00:25:39');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (23, 20, 2, '1973-07-01 23:17:25', '2017-04-22 22:04:48', '2000-04-15 20:41:10', '1983-06-15 14:00:08');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (24, 19, 1, '1984-06-13 03:02:45', '1983-08-25 09:15:07', '1994-05-19 04:43:44', '1997-09-20 09:38:13');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (24, 85, 0, '2001-05-27 21:25:38', '2016-03-26 23:33:49', '2010-05-14 11:41:49', '2004-09-18 23:17:41');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (25, 9, 1, '1994-03-05 03:17:07', '1988-04-24 18:42:55', '1983-02-12 14:36:09', '2018-06-29 17:51:45');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (25, 55, 2, '2000-11-21 22:14:23', '0000-00-00 00:00:00', '1999-03-30 08:35:20', '2002-06-27 19:13:31');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (25, 93, 1, '1984-08-29 15:48:34', '1979-12-19 20:53:22', '2013-08-02 12:32:27', '2003-05-05 21:07:01');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (26, 35, 0, '1980-07-16 11:29:52', '1993-05-07 10:05:21', '2019-11-04 17:59:39', '1982-05-05 19:47:06');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (26, 53, 0, '1975-12-17 15:35:57', '1996-07-16 04:28:49', '1974-03-02 10:40:50', '1979-02-20 13:28:33');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (27, 70, 0, '1998-09-24 06:30:54', '0000-00-00 00:00:00', '2001-01-07 01:37:01', '1994-12-29 08:59:24');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (27, 100, 0, '2005-03-28 02:18:32', '0000-00-00 00:00:00', '2020-01-17 22:17:10', '1980-04-07 02:08:07');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (28, 37, 0, '2006-09-30 05:00:50', '1984-06-12 07:58:17', '1984-10-30 17:42:51', '1996-02-28 14:42:36');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (29, 46, 0, '1987-11-29 16:31:15', '0000-00-00 00:00:00', '1973-08-28 21:26:43', '2017-08-24 13:39:12');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (29, 88, 1, '1981-12-24 23:53:00', '1983-07-07 10:27:32', '1978-11-25 01:02:25', '1992-04-26 07:31:19');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (31, 27, 0, '1988-08-28 23:28:45', '0000-00-00 00:00:00', '1986-09-06 21:38:23', '1985-07-01 02:27:08');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (31, 52, 2, '1990-08-02 08:37:04', '2014-12-04 14:40:44', '1991-01-01 04:21:54', '2001-11-24 22:23:05');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (31, 93, 0, '2008-05-18 23:00:00', '0000-00-00 00:00:00', '1972-11-25 04:20:24', '2013-01-11 22:49:07');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (32, 67, 0, '2015-01-19 02:23:20', '1985-10-09 05:19:45', '2007-09-16 23:31:20', '1998-12-29 13:57:12');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (32, 81, 1, '1997-10-25 20:54:54', '0000-00-00 00:00:00', '2017-10-02 01:28:43', '2004-11-22 18:30:35');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (34, 12, 1, '1996-03-15 05:18:06', '1983-02-26 10:03:48', '1979-07-14 02:26:33', '1997-03-22 21:30:06');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (35, 22, 0, '1973-05-17 04:16:32', '2015-10-31 10:42:25', '2015-06-08 14:58:19', '2017-09-23 12:28:49');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (35, 28, 1, '1998-10-15 18:00:09', '0000-00-00 00:00:00', '2015-03-13 03:27:25', '2006-04-25 17:43:57');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (35, 44, 0, '2003-10-09 01:47:47', '0000-00-00 00:00:00', '2009-05-14 11:46:54', '1981-01-06 19:18:56');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (35, 99, 1, '1982-02-12 03:09:06', '0000-00-00 00:00:00', '2019-08-23 20:07:28', '1994-09-10 08:31:31');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (38, 55, 0, '2003-05-16 12:16:03', '1997-08-04 10:39:02', '1971-11-04 21:03:57', '1995-09-23 01:54:27');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (39, 79, 0, '1980-04-11 17:30:37', '1994-08-18 19:27:36', '2002-06-06 11:37:11', '1997-09-08 09:56:59');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (39, 90, 0, '1985-05-06 17:12:43', '1979-05-08 01:22:34', '1974-05-04 09:51:32', '1991-05-16 16:42:16');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (40, 51, 0, '2015-08-06 09:45:13', '1994-05-26 08:19:34', '1996-08-24 09:37:38', '1993-04-28 22:21:43');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (40, 96, 1, '2000-07-02 23:39:41', '0000-00-00 00:00:00', '2002-01-05 08:18:18', '1996-02-26 14:32:26');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (41, 32, 2, '2014-01-30 09:34:43', '0000-00-00 00:00:00', '1999-08-11 08:37:20', '1976-06-04 08:39:53');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (41, 61, 1, '1988-05-25 13:41:34', '2017-11-13 18:58:12', '1998-03-05 22:36:07', '2010-06-16 12:51:43');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (41, 70, 0, '2000-12-06 07:54:32', '0000-00-00 00:00:00', '1974-06-24 19:27:41', '2017-05-13 02:01:57');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (45, 4, 1, '2010-02-08 00:12:20', '1994-11-26 20:46:40', '1984-05-15 14:51:44', '1970-07-24 17:00:10');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (47, 36, 0, '1983-02-01 09:29:53', '1985-02-08 03:42:35', '1984-11-05 12:46:21', '2005-01-09 03:07:05');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (47, 44, 2, '2011-07-28 09:48:27', '1982-11-21 15:45:00', '1995-05-01 19:19:22', '1995-07-03 07:19:28');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (47, 73, 0, '2007-12-01 13:41:19', '0000-00-00 00:00:00', '2006-12-04 11:32:46', '1972-09-07 03:07:26');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (50, 99, 2, '1982-03-04 06:18:07', '1976-07-13 10:08:20', '1992-03-14 20:03:48', '2016-05-17 11:29:53');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (51, 70, 0, '1989-02-14 20:55:18', '1973-09-18 19:08:13', '2007-12-18 08:33:33', '2006-11-10 21:14:30');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (51, 77, 0, '1981-04-17 09:39:10', '1979-12-14 08:27:58', '1982-01-15 17:32:27', '1984-10-04 08:57:20');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (54, 45, 2, '1976-07-20 10:09:17', '1976-01-30 15:15:03', '2000-03-31 00:17:59', '1996-05-26 08:09:30');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (54, 67, 1, '1998-01-14 19:39:38', '2013-05-30 00:46:58', '2017-06-03 15:06:08', '2004-06-13 02:50:22');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (55, 66, 0, '1974-05-05 22:17:14', '0000-00-00 00:00:00', '1997-05-25 22:50:34', '2017-12-13 03:18:23');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (55, 87, 0, '1975-05-09 00:54:45', '0000-00-00 00:00:00', '1981-10-25 14:46:04', '1985-08-27 15:09:30');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (57, 11, 0, '1998-12-02 14:23:39', '0000-00-00 00:00:00', '2016-07-25 11:56:13', '2019-05-16 08:50:54');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (59, 93, 1, '1981-10-03 00:05:36', '1987-11-07 22:35:18', '1989-06-05 08:42:56', '2017-08-23 08:57:37');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (60, 38, 2, '1999-04-25 05:58:54', '2018-01-07 10:15:23', '2004-04-24 10:18:39', '1981-05-30 01:17:49');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (63, 14, 1, '1990-09-20 01:28:13', '1986-08-15 22:25:25', '1989-01-29 23:23:50', '1989-08-24 11:54:44');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (63, 26, 0, '2005-09-25 06:02:27', '0000-00-00 00:00:00', '1982-07-08 12:32:11', '2002-01-20 15:32:21');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (63, 54, 0, '1979-02-22 17:09:29', '0000-00-00 00:00:00', '1993-06-06 06:12:15', '1997-01-04 11:16:20');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (63, 69, 0, '1972-07-01 10:12:39', '0000-00-00 00:00:00', '1970-06-28 01:11:44', '2010-06-20 04:17:27');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (65, 64, 0, '2005-05-25 07:09:38', '1989-05-14 09:07:03', '1985-10-09 17:47:51', '2007-05-12 13:54:28');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (67, 22, 0, '2020-05-19 18:24:04', '0000-00-00 00:00:00', '1991-04-14 22:39:59', '1998-01-16 19:15:58');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (67, 83, 0, '2016-05-29 06:52:14', '1994-06-11 22:04:46', '2005-12-09 18:53:46', '2000-07-31 06:36:34');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (67, 97, 1, '1972-07-30 20:00:15', '0000-00-00 00:00:00', '2015-01-25 11:58:49', '2001-11-27 15:53:50');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (68, 13, 1, '2004-07-10 02:50:36', '2019-11-30 11:24:44', '1991-01-21 23:05:58', '2000-12-05 02:13:54');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (69, 44, 0, '1974-02-06 20:16:35', '0000-00-00 00:00:00', '2017-08-15 21:46:31', '1996-04-07 04:59:09');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (69, 53, 0, '1982-02-06 15:50:39', '1975-11-27 06:43:38', '1972-05-18 14:53:11', '2005-11-14 14:03:43');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (71, 25, 0, '2003-02-28 05:01:16', '0000-00-00 00:00:00', '1986-09-10 05:37:47', '2014-11-17 12:19:32');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (72, 40, 0, '1971-03-16 13:15:54', '2002-01-28 10:07:02', '1978-08-11 18:42:01', '2018-03-11 17:01:29');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (74, 12, 1, '1979-06-17 02:41:51', '1983-11-18 20:14:38', '1998-11-02 14:51:22', '1970-07-31 15:53:34');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (77, 6, 0, '1978-03-07 14:14:14', '0000-00-00 00:00:00', '2002-07-28 05:08:25', '1974-05-11 02:19:46');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (77, 93, 1, '2011-02-21 16:04:48', '1993-04-12 19:27:40', '2012-12-17 16:20:41', '2012-12-30 16:45:04');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (78, 47, 0, '2007-01-28 18:23:11', '1984-01-25 07:07:39', '1999-03-17 16:34:40', '1972-07-02 08:07:46');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (79, 65, 2, '2010-09-10 00:55:30', '1987-07-28 14:18:04', '1983-11-03 06:37:36', '1970-11-27 18:10:33');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (80, 7, 2, '1997-12-21 07:57:10', '0000-00-00 00:00:00', '1972-10-14 04:27:48', '1982-02-12 10:30:48');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (80, 71, 1, '2015-12-25 13:30:25', '2017-04-19 00:19:28', '1975-12-15 09:09:26', '1975-10-21 03:45:52');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (82, 1, 2, '2014-07-05 18:47:16', '1989-08-24 10:43:00', '1974-06-03 03:37:36', '1973-10-24 20:07:00');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (84, 52, 0, '1989-05-30 14:24:01', '1980-10-16 18:06:45', '2007-11-10 05:06:19', '1978-10-16 16:50:13');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (86, 23, 1, '1972-05-18 19:33:19', '2006-01-07 06:19:35', '2012-07-16 07:33:27', '2007-07-21 12:01:39');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (86, 81, 2, '1997-11-17 02:10:48', '0000-00-00 00:00:00', '1979-01-30 03:09:11', '1983-02-17 16:45:07');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (87, 12, 1, '1972-12-19 20:54:19', '1992-01-04 10:21:49', '1990-07-09 10:08:40', '2018-03-23 06:05:40');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (89, 68, 0, '1994-05-09 08:01:26', '0000-00-00 00:00:00', '2006-11-02 13:35:09', '2007-04-21 22:26:03');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (90, 2, 1, '1980-06-09 14:24:53', '1988-05-12 21:48:30', '1977-04-25 15:23:29', '2003-08-07 02:56:10');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (90, 94, 0, '1989-02-22 20:16:57', '2007-02-02 06:24:30', '2015-12-23 20:03:28', '1993-02-11 14:19:03');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (91, 22, 2, '1996-03-22 07:44:57', '0000-00-00 00:00:00', '2014-11-15 21:39:20', '1982-07-25 02:42:22');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (91, 36, 0, '1976-05-10 16:04:40', '2005-08-21 16:11:22', '1995-01-03 16:06:49', '1992-02-26 22:12:40');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (91, 49, 0, '2014-08-04 11:54:56', '2004-01-06 23:27:08', '2010-06-08 08:49:28', '2006-04-14 06:34:46');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (91, 84, 0, '2003-12-31 23:29:15', '0000-00-00 00:00:00', '1999-10-22 11:14:37', '1985-07-10 00:17:30');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (92, 8, 0, '1979-10-14 20:30:55', '2007-04-22 10:49:15', '1993-01-11 01:45:00', '1991-06-17 01:11:52');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (96, 77, 0, '1999-04-30 21:30:25', '0000-00-00 00:00:00', '1982-08-23 20:48:50', '1982-02-04 18:32:37');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (97, 3, 2, '1997-08-25 22:20:27', '0000-00-00 00:00:00', '1990-04-02 13:29:18', '1982-08-28 13:35:22');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (97, 19, 0, '2018-06-05 12:47:51', '1982-05-20 13:13:43', '2003-06-11 03:12:05', '2004-05-13 15:48:08');
INSERT INTO `friendships` (`user_id`, `friend_id`, `status_id`, `requested_at`, `confirmed_at`, `created_at`, `updated_at`) VALUES (99, 38, 2, '1974-10-15 08:48:06', '2009-02-22 04:47:06', '2005-04-04 23:54:34', '2019-06-10 11:32:37');


-- #
-- # TABLE STRUCTURE FOR: media
-- #

-- DROP TABLE IF EXISTS `media`;

-- CREATE TABLE `media` (
  -- `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  -- `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя, который загрузил файл',
  -- `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Путь к файлу',
  -- `size` int(11) NOT NULL COMMENT 'Размер файла',
  -- `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Метаданные файла' CHECK (json_valid(`metadata`)),
--  `media_type_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на тип контента',
--  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
--  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
--  PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Медиафайлы';

INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (1, 1, 'labore', 0, NULL, 2, '2002-01-09 06:58:46', '1983-08-29 09:05:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (2, 2, 'voluptatem', 22868071, NULL, 2, '2013-11-21 02:16:26', '1971-08-18 23:43:22');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (3, 3, 'quia', 3962, NULL, 1, '2013-06-12 11:13:27', '1974-01-15 13:57:22');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (4, 4, 'aut', 789159, NULL, 2, '2006-04-04 03:26:35', '2019-10-22 22:48:41');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (5, 5, 'perspiciatis', 715227, NULL, 1, '1993-03-26 21:17:02', '1982-02-17 03:16:45');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (6, 6, 'asperiores', 9636463, NULL, 2, '1973-06-27 23:53:03', '1994-02-10 08:26:38');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (7, 7, 'eum', 6511, NULL, 2, '1970-02-13 14:19:08', '1987-07-27 15:43:02');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (8, 8, 'esse', 7, NULL, 2, '1977-01-04 00:08:47', '2017-06-23 09:51:16');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (9, 9, 'aut', 27227, NULL, 2, '2000-05-04 14:13:55', '2018-06-07 10:03:05');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (10, 10, 'et', 524432, NULL, 0, '1970-11-27 00:54:34', '2009-12-11 15:44:31');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (11, 11, 'dolorem', 587, NULL, 0, '2014-09-27 04:32:58', '1993-10-28 22:46:29');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (12, 12, 'libero', 4077638, NULL, 2, '1982-07-18 04:15:58', '2005-06-10 09:46:04');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (13, 13, 'dolorem', 77, NULL, 0, '1975-08-18 03:11:19', '2006-02-04 08:52:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (14, 14, 'eveniet', 2355, NULL, 0, '1989-01-18 23:46:01', '1999-03-17 22:38:24');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (15, 15, 'ratione', 3445, NULL, 1, '1981-06-10 04:13:48', '2017-08-24 15:43:01');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (16, 16, 'totam', 54445, NULL, 0, '2003-11-15 04:15:30', '2002-05-20 13:23:28');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (17, 17, 'maxime', 85, NULL, 2, '2005-09-12 22:14:32', '1982-10-30 14:32:21');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (18, 18, 'quod', 484179052, NULL, 1, '2013-11-02 19:05:56', '2002-08-06 19:01:19');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (19, 19, 'voluptas', 809592, NULL, 1, '2017-11-20 06:57:49', '1986-08-12 23:58:38');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (20, 20, 'sunt', 32562663, NULL, 1, '1992-07-01 23:01:06', '1992-10-07 06:48:47');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (21, 21, 'nobis', 6, NULL, 2, '1975-05-08 23:28:20', '1980-10-03 14:30:17');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (22, 22, 'ea', 0, NULL, 0, '2000-06-15 07:32:41', '2010-12-16 23:10:46');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (23, 23, 'eum', 0, NULL, 0, '2016-01-26 16:44:33', '1995-06-16 18:21:48');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (24, 24, 'autem', 822850887, NULL, 0, '2005-12-29 17:05:15', '2008-09-04 23:32:57');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (25, 25, 'sunt', 6333, NULL, 0, '2019-03-05 02:06:42', '2019-02-19 19:52:19');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (26, 26, 'doloribus', 6, NULL, 2, '1985-05-01 02:19:24', '1981-01-03 07:15:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (27, 27, 'aut', 659217, NULL, 1, '2007-10-12 19:41:51', '1983-07-04 16:54:00');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (28, 28, 'dignissimos', 39613002, NULL, 2, '2000-10-04 16:57:33', '2007-11-15 06:30:45');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (29, 29, 'quia', 43625, NULL, 0, '2008-08-13 17:55:08', '2018-04-19 15:13:48');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (30, 30, 'in', 347238152, NULL, 1, '1985-05-15 15:47:10', '1997-08-24 07:27:01');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (31, 31, 'veniam', 7200, NULL, 0, '2001-11-23 03:47:51', '2001-08-01 15:51:14');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (32, 32, 'aliquam', 48465918, NULL, 1, '2007-10-24 21:17:39', '2015-01-22 12:39:19');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (33, 33, 'repellendus', 0, NULL, 2, '1971-07-19 18:39:33', '1976-01-19 20:07:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (34, 34, 'tenetur', 79742, NULL, 0, '2009-07-09 02:04:03', '1983-11-26 01:14:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (35, 35, 'iusto', 419, NULL, 0, '1990-11-10 22:59:40', '1970-01-23 07:51:43');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (36, 36, 'eum', 0, NULL, 2, '2017-10-10 08:08:33', '2000-04-23 07:05:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (37, 37, 'rem', 6484, NULL, 0, '1976-09-30 09:55:56', '1975-07-20 19:59:03');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (38, 38, 'quibusdam', 9096155, NULL, 2, '2014-07-17 08:53:38', '2017-10-13 07:30:57');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (39, 39, 'incidunt', 84465, NULL, 1, '1995-08-02 13:47:13', '1992-01-09 14:20:01');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (40, 40, 'exercitationem', 14, NULL, 0, '1977-10-03 14:40:12', '1970-04-29 20:23:16');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (41, 41, 'labore', 8801, NULL, 1, '1998-11-23 00:10:56', '1982-11-20 07:23:44');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (42, 42, 'mollitia', 219085763, NULL, 2, '2006-08-05 11:15:35', '2011-03-09 12:11:59');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (43, 43, 'corrupti', 3699, NULL, 1, '2009-03-01 01:20:37', '2010-03-24 15:34:08');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (44, 44, 'aliquam', 7, NULL, 2, '2006-10-23 15:38:36', '2012-08-03 05:39:18');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (45, 45, 'eveniet', 7536, NULL, 0, '2003-08-16 19:55:27', '1992-05-04 10:07:58');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (46, 46, 'mollitia', 12933718, NULL, 1, '1991-05-06 13:18:08', '2000-11-25 14:27:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (47, 47, 'suscipit', 787549, NULL, 2, '1989-07-04 21:05:21', '2011-03-24 17:45:22');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (48, 48, 'provident', 116910574, NULL, 2, '1980-04-13 20:22:01', '1984-03-21 02:19:01');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (49, 49, 'eveniet', 50685, NULL, 2, '2014-06-28 05:15:59', '2003-10-24 17:30:59');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (50, 50, 'debitis', 5, NULL, 2, '1977-11-16 10:44:15', '1971-05-14 01:19:29');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (51, 51, 'voluptas', 8392, NULL, 2, '2001-04-06 03:17:31', '2008-12-31 02:20:37');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (52, 52, 'quidem', 0, NULL, 2, '1981-01-06 02:06:48', '1995-07-18 19:26:00');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (53, 53, 'velit', 23, NULL, 2, '2019-10-26 15:01:31', '2006-11-28 05:20:16');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (54, 54, 'et', 7238353, NULL, 1, '1995-07-29 13:44:09', '2013-11-17 20:14:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (55, 55, 'omnis', 222871987, NULL, 1, '1986-01-01 23:52:58', '1983-09-09 03:48:58');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (56, 56, 'exercitationem', 22, NULL, 1, '1995-02-02 04:33:10', '2013-05-03 16:45:35');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (57, 57, 'qui', 604, NULL, 0, '1999-01-13 20:18:09', '1975-01-26 18:03:52');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (58, 58, 'dolorem', 925739402, NULL, 1, '1970-06-18 02:41:16', '2007-04-21 23:43:45');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (59, 59, 'dolorem', 968, NULL, 0, '1987-06-07 16:56:23', '1996-01-11 11:22:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (60, 60, 'beatae', 3096022, NULL, 1, '2002-11-20 16:14:16', '2004-11-09 06:01:00');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (61, 61, 'unde', 49149, NULL, 2, '1990-11-04 12:29:30', '2014-07-28 22:33:43');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (62, 62, 'dolorem', 8, NULL, 0, '1986-04-24 10:44:40', '2010-05-10 01:16:57');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (63, 63, 'sunt', 78, NULL, 0, '1987-04-27 17:06:22', '2000-03-14 15:44:44');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (64, 64, 'fugit', 77275, NULL, 1, '2005-08-18 01:28:23', '1973-01-28 23:16:09');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (65, 65, 'quia', 0, NULL, 2, '2008-09-19 15:30:14', '2001-02-28 03:12:59');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (66, 66, 'aut', 9, NULL, 0, '2016-12-08 21:05:58', '2019-08-27 21:15:42');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (67, 67, 'nesciunt', 0, NULL, 2, '1976-11-13 05:25:12', '1981-07-22 18:09:06');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (68, 68, 'nesciunt', 0, NULL, 0, '1988-02-01 18:02:31', '2015-08-11 08:52:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (69, 69, 'voluptatem', 564, NULL, 1, '2019-11-30 17:27:10', '1983-10-30 20:03:40');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (70, 70, 'quia', 3, NULL, 0, '2014-12-13 13:38:28', '2006-02-23 14:16:34');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (71, 71, 'ea', 1, NULL, 1, '2003-11-15 07:57:47', '2008-05-18 15:21:16');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (72, 72, 'iste', 6, NULL, 0, '2014-05-27 00:18:23', '2005-02-01 21:04:42');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (73, 73, 'qui', 594419805, NULL, 1, '2010-10-28 02:55:31', '1983-09-19 02:31:27');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (74, 74, 'iste', 44, NULL, 0, '1992-12-29 18:24:19', '1979-03-20 14:17:58');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (75, 75, 'aut', 633173, NULL, 2, '1997-01-26 23:53:37', '1984-07-02 18:43:05');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (76, 76, 'dolorem', 8546, NULL, 1, '1973-03-05 22:25:56', '1973-12-20 22:29:56');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (77, 77, 'earum', 9908740, NULL, 0, '1987-07-09 06:24:39', '1970-10-27 04:27:20');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (78, 78, 'necessitatibus', 0, NULL, 2, '1989-01-10 05:21:55', '2006-10-22 14:40:26');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (79, 79, 'maxime', 1426788, NULL, 1, '1975-03-21 11:15:16', '2003-02-26 08:05:12');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (80, 80, 'aliquid', 469256388, NULL, 2, '2016-09-05 10:30:25', '1973-11-29 04:31:33');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (81, 81, 'sint', 1, NULL, 1, '1998-03-18 10:39:15', '1983-12-09 20:51:36');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (82, 82, 'velit', 3056, NULL, 0, '2009-07-10 18:57:13', '1974-03-03 14:38:46');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (83, 83, 'perspiciatis', 0, NULL, 0, '2004-03-31 14:20:14', '1993-12-02 17:54:11');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (84, 84, 'impedit', 802283, NULL, 0, '1998-05-14 08:59:44', '1974-04-19 23:48:45');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (85, 85, 'officiis', 73167, NULL, 0, '2006-10-03 18:21:19', '1977-01-26 02:37:10');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (86, 86, 'quis', 238, NULL, 1, '2002-05-08 20:01:36', '2002-05-22 20:52:47');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (87, 87, 'inventore', 0, NULL, 0, '1985-09-30 21:26:39', '2019-10-13 23:11:15');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (88, 88, 'dolore', 5, NULL, 1, '2017-08-13 13:00:18', '1973-10-10 08:43:07');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (89, 89, 'est', 951426726, NULL, 1, '2003-04-20 05:25:36', '1993-01-20 03:47:15');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (90, 90, 'alias', 744, NULL, 0, '1985-08-08 05:27:45', '2011-05-21 22:33:02');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (91, 91, 'vero', 15661207, NULL, 0, '2007-11-26 21:39:44', '2014-02-25 23:24:08');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (92, 92, 'deleniti', 1, NULL, 2, '1998-04-11 03:08:58', '2019-08-07 05:52:08');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (93, 93, 'qui', 6655, NULL, 0, '2017-06-12 02:36:34', '1993-07-21 20:40:14');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (94, 94, 'ut', 902, NULL, 2, '1974-02-24 09:29:36', '2016-04-03 15:30:39');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (95, 95, 'veritatis', 4185180, NULL, 2, '1970-11-28 01:57:58', '2011-06-30 12:23:40');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (96, 96, 'rerum', 318, NULL, 0, '1974-11-07 09:38:15', '1995-11-07 00:10:31');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (97, 97, 'ut', 21301769, NULL, 1, '2009-08-02 21:27:39', '2000-04-03 16:10:21');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (98, 98, 'eveniet', 639, NULL, 2, '1978-12-10 18:02:18', '1994-02-07 01:30:18');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (99, 99, 'qui', 404766, NULL, 2, '2010-11-02 04:12:29', '2000-01-31 18:06:01');
INSERT INTO `media` (`id`, `user_id`, `filename`, `size`, `metadata`, `media_type_id`, `created_at`, `updated_at`) VALUES (100, 100, 'enim', 341, NULL, 1, '1990-05-02 00:09:29', '1977-03-22 08:19:51');


-- #
-- # TABLE STRUCTURE FOR: media_types
-- #

-- DROP TABLE IF EXISTS `media_types`;

-- CREATE TABLE `media_types` (
--  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
--  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Название типа',
--  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
--  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
--  PRIMARY KEY (`id`),
--  UNIQUE KEY `name` (`name`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Типы медиафайлов';

-- #
-- # TABLE STRUCTURE FOR: messages
-- #
--
-- DROP TABLE IF EXISTS `messages`;
--
-- CREATE TABLE `messages` (
--  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
--  `from_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
--  `to_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя сообщения',
--  `body` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Текст сообщения',
--  `is_important` tinyint(1) DEFAULT NULL COMMENT 'Признак важности',
--  `is_delivered` tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  -- `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  -- `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  -- PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Сообщения';

INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (1, 84, 83, 'Voluptatibus dolorem sit accusantium eaque quia aut aliquid nemo. Non nihil vel exercitationem quisquam. Vel qui neque qui. Consequatur perferendis aperiam et praesentium autem similique quo possimus. Doloribus necessitatibus provident quos dolorem aliquam rerum.', 0, 0, '1970-05-31 10:16:01', '2001-01-06 02:53:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (2, 6, 39, 'Suscipit voluptatem deserunt at et. Cupiditate repudiandae molestias reiciendis. Vel sit modi qui est. Tenetur qui illum velit. Qui ipsa eligendi voluptates at blanditiis.', 0, 1, '1971-08-18 19:26:06', '1976-05-09 03:10:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (3, 65, 73, 'Autem eaque voluptas consequatur dolorem. Sint exercitationem voluptatem odio similique. Blanditiis fugit voluptas voluptatem. Impedit commodi minima alias architecto repellat facilis sit.', 0, 0, '2013-11-07 00:00:39', '2008-08-20 05:41:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (4, 20, 91, 'Officia ad totam est nemo sunt. Hic aliquam non mollitia laboriosam cumque rerum. Sunt veritatis accusamus velit sed est qui laudantium. Assumenda et necessitatibus atque dolorum unde.', 1, 1, '1995-10-22 22:33:07', '1980-10-09 21:52:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (5, 53, 30, 'Ratione quia molestiae blanditiis cupiditate sed inventore eius. Molestiae beatae harum aliquam dolore. Consequatur quam doloribus ut officia. Nemo sed et vitae dolorem exercitationem deserunt.', 1, 0, '1970-02-12 07:21:43', '1995-03-26 02:28:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (6, 29, 97, 'Sapiente dolorum quidem tempora mollitia beatae asperiores. Modi quam recusandae et maiores et quos at rem. Libero et nihil ut dolorum rerum praesentium et. Vel consequatur fugiat est occaecati velit laudantium quasi. Omnis adipisci quisquam consectetur corrupti aperiam nobis.', 0, 0, '1978-10-29 08:24:25', '2005-04-19 03:51:14');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (7, 41, 36, 'Exercitationem est qui et eos eum. Voluptates voluptas atque eius in rem delectus autem. Numquam reprehenderit quia quaerat sapiente ut. Ab dolor tempora blanditiis accusantium tempore modi.', 0, 0, '2013-09-12 00:10:35', '1991-10-14 05:11:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (8, 30, 76, 'Dolorem delectus consequuntur nihil est rerum. Suscipit quaerat est impedit quibusdam. Dolorem culpa aliquam minus voluptatem consequatur. Qui omnis suscipit esse quia nesciunt et aspernatur delectus.', 1, 1, '1972-04-15 21:31:51', '1995-11-26 03:56:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (9, 51, 35, 'Ut illum voluptatibus qui id beatae quas. Ab omnis dolorum accusamus totam sint ut eos voluptas. Non nemo eius id et quas.', 0, 1, '2005-09-01 23:07:11', '2007-02-18 16:38:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (10, 17, 73, 'Enim quos aliquam est impedit animi ipsam voluptas rerum. Animi magni animi alias error. Sed voluptas velit ipsum voluptas velit ea libero. Omnis quam consequatur repellat aut incidunt pariatur amet voluptas.', 0, 0, '2012-02-10 03:04:17', '1997-06-04 03:29:16');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (11, 64, 15, 'Repellendus ratione omnis voluptatem natus consequuntur iste porro omnis. Repellat magnam perspiciatis placeat impedit ea maiores. Autem enim molestias exercitationem sit distinctio enim et.', 0, 1, '2006-12-11 21:27:27', '2015-12-14 05:55:41');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (12, 47, 47, 'At error soluta nesciunt. Excepturi accusantium voluptatem non. Id distinctio error accusamus eos ut.', 0, 1, '1992-09-19 05:46:24', '2002-05-03 21:26:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (13, 30, 88, 'Similique ut laboriosam quod laborum molestias pariatur. Doloremque natus vero assumenda laudantium non non. Maxime laborum eius omnis sit cumque soluta deserunt nisi. Natus enim dolores repellendus consectetur aspernatur sint odio minus.', 1, 0, '2004-03-25 23:08:45', '1985-06-20 12:23:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (14, 96, 100, 'Voluptates in tempore ipsam nam. Quibusdam quia atque esse quis et eos. Illum voluptates dolorum exercitationem et tempore. Molestias nesciunt rem unde fuga et.', 0, 1, '2014-04-17 08:02:53', '1994-09-10 11:14:46');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (15, 71, 1, 'Iste ipsa consectetur est et explicabo. Tempora minus sit deserunt deserunt et occaecati suscipit cumque. Dolor sed magnam earum earum omnis.', 1, 0, '1974-01-03 13:23:46', '2009-12-27 09:38:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (16, 99, 97, 'Ullam odit error ea. Beatae id dicta veritatis accusamus dicta. Qui aut eos cupiditate aliquid nihil. Dolores illum quas porro qui eos ducimus aut.', 0, 1, '2017-01-07 08:14:29', '1983-12-02 06:49:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (17, 58, 3, 'Laudantium modi repellat dignissimos aut ipsa. Quia dolore nostrum sint aut sed. Eum quia corporis aut maiores est. Neque qui ipsa nisi nobis.', 0, 0, '1986-05-29 21:04:00', '1970-03-11 02:08:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (18, 9, 42, 'Et qui odit libero ut. Sequi quia unde pariatur ipsum voluptas. Quam consequuntur quisquam ipsum provident fugit aut libero sed. Aut voluptate minus fugiat reprehenderit perferendis.', 0, 1, '1991-08-11 21:13:39', '2008-06-15 12:10:43');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (19, 45, 31, 'Voluptas magnam consequatur enim ut sed. Ipsa minus est libero earum. Provident quia sapiente minima. Voluptas vitae corrupti et itaque quia.', 1, 0, '1971-03-22 04:08:48', '2009-04-03 08:48:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (20, 52, 61, 'Architecto assumenda quos veritatis facilis sequi eos distinctio. Consequatur ipsum quia eius ea. A ea deserunt at et eligendi. Aperiam qui alias excepturi.', 0, 0, '1974-05-03 03:12:35', '2006-05-01 15:34:38');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (21, 70, 98, 'Est nihil nesciunt culpa voluptatem minus. Omnis delectus cum ut nihil ea. Dolores quia ullam qui est illo quae architecto aut.', 1, 1, '1983-11-02 12:33:26', '1981-01-09 02:16:20');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (22, 7, 100, 'Vel non non sit. Illum earum distinctio placeat quo vero sunt.', 1, 1, '1993-07-26 11:42:01', '2000-03-03 15:24:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (23, 78, 97, 'Voluptate ut nemo doloremque delectus aliquid illo libero. Pariatur expedita facilis quod cumque voluptatibus saepe. Praesentium dolor illo autem quidem alias officiis. Ut quidem enim id velit. Error officia laborum iure consequatur deleniti quia sed voluptatem.', 0, 0, '1972-05-18 16:06:20', '1992-07-28 12:43:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (24, 91, 69, 'Quod enim quae fugiat impedit reprehenderit. Deleniti alias qui enim. Dignissimos esse deserunt ut in eos velit placeat est. Eveniet inventore qui ea officia earum sint.', 0, 1, '2012-07-22 20:29:57', '1998-11-08 22:14:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (25, 58, 85, 'Pariatur enim aut eos earum. Dolorem doloremque autem qui mollitia. Quo doloribus quaerat aut eveniet. Laboriosam eum aliquam eligendi ducimus.', 1, 0, '1989-12-10 17:07:59', '2019-07-07 23:23:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (26, 47, 63, 'Qui occaecati hic veritatis. Quis perspiciatis sit alias repellat.', 1, 1, '2016-05-11 05:19:59', '1980-02-26 23:25:28');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (27, 99, 88, 'Repellendus ipsam beatae in inventore culpa. Et accusamus rem quia rerum facere. Exercitationem ut et aliquam praesentium veritatis. Rerum quia et illo eos voluptatem.', 0, 0, '2012-11-11 11:32:18', '1989-01-22 09:14:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (28, 17, 85, 'Et quia aut eveniet quam. Ab nemo ut id. Qui ut velit aliquam aut eos. Esse odio tenetur quae reiciendis autem nulla nesciunt.', 0, 1, '1990-12-14 22:29:51', '1977-01-28 21:18:37');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (29, 73, 17, 'Et illo aut ipsa quas temporibus accusantium quis. Fugit quis occaecati corporis delectus nemo. Et inventore porro eligendi. Possimus eum eaque hic culpa est perspiciatis provident.', 0, 0, '2001-05-14 03:58:54', '2006-03-28 20:23:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (30, 3, 29, 'Ut velit id facilis qui laborum error. Aut dolor accusantium necessitatibus nulla voluptatum perferendis. Corporis necessitatibus dolores ipsa et rerum sit quae.', 0, 0, '1998-12-12 04:09:58', '2009-03-23 10:35:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (31, 21, 71, 'Autem omnis tenetur explicabo et. Sit veritatis et voluptatem dolores. Eos exercitationem ullam velit. Accusamus nesciunt aut error.', 0, 1, '1994-01-03 17:16:45', '1988-01-22 15:42:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (32, 20, 28, 'Blanditiis recusandae libero fugiat impedit facilis magnam impedit. Ut ea consectetur veritatis dolorem praesentium sed aspernatur voluptatem. Sed cumque non nemo mollitia aspernatur est porro. Et vel labore quas vel quae.', 1, 1, '1973-07-02 05:37:40', '1997-03-04 00:57:50');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (33, 56, 90, 'Dolorum sit provident veritatis et eos est. Ut saepe omnis ex sed. Natus optio eius velit et. Quis neque eius minima eos at.', 1, 1, '1975-09-21 16:51:35', '1983-02-18 01:30:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (34, 64, 7, 'Molestiae quas suscipit vero tempora. Nam maxime voluptatem quo. Neque eum iste ex. Non voluptatibus et est voluptatem corrupti rerum repudiandae.', 1, 1, '2000-10-04 11:06:09', '1981-07-08 20:02:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (35, 31, 9, 'Qui consequatur beatae alias et. Aut animi sint a ut. Dolor id sapiente architecto odio dolorum maxime.', 1, 0, '1979-01-09 07:36:57', '2012-12-03 04:16:04');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (36, 69, 69, 'Eveniet ab omnis doloremque quo alias est. Nihil quia itaque temporibus rerum nulla in. Magnam qui illum ratione sit pariatur. Minus repellat dicta autem et autem voluptatum porro.', 0, 1, '1987-01-03 22:27:20', '1979-07-29 12:00:26');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (37, 83, 29, 'Omnis aut sunt tempora nihil culpa. Tenetur et hic consequatur distinctio iure. Eum eius esse ut soluta sequi.', 0, 1, '2001-08-31 22:50:27', '1988-04-30 03:40:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (38, 76, 16, 'Aut sit pariatur vero ullam. Est facilis est nemo. Commodi est qui placeat voluptas. Dicta eum rerum fugiat velit.', 1, 1, '2019-08-19 14:13:18', '2007-07-30 08:50:39');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (39, 43, 16, 'Voluptatem esse ipsa consectetur blanditiis magni labore fuga atque. Aut natus rerum provident. Modi ea et corporis veniam eaque. In impedit omnis in iusto.', 0, 0, '1993-05-25 03:05:42', '2001-12-08 03:41:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (40, 91, 34, 'Non rerum illum id iure dolorem. Expedita adipisci ut iste consequatur architecto. Id suscipit dolore et qui magnam. Repellat doloribus corporis amet animi dolorem id.', 1, 0, '1987-05-02 20:56:37', '1997-05-17 13:57:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (41, 9, 52, 'Dicta inventore sit occaecati iste incidunt soluta natus culpa. Quam iure quo ut nobis explicabo. Qui eos quia aut vel. Itaque delectus et deserunt possimus soluta est quos.', 1, 1, '2009-04-07 20:28:18', '2013-08-03 21:42:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (42, 100, 48, 'Deleniti placeat consequuntur natus dicta. Rerum sit et sed. Ab est esse autem ratione labore. Minus et temporibus animi velit dolore ab a.', 0, 0, '2020-04-26 08:25:53', '1975-10-07 10:24:21');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (43, 23, 33, 'Autem iure facere deleniti esse repellat distinctio. Sapiente maiores molestiae eius vel expedita qui minus. Quaerat non eveniet est et optio voluptatem.', 1, 0, '2003-06-03 01:15:19', '1992-04-23 13:56:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (44, 30, 85, 'Fugit velit veniam aut eum odit in ipsam. Quod provident mollitia quo omnis dolorum nobis atque. Porro in ut perspiciatis reiciendis esse quia. Cumque ab earum nam a et.', 1, 1, '2017-10-06 00:41:36', '1983-09-17 19:28:48');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (45, 12, 7, 'Qui quibusdam sint consequatur maiores voluptatem quas. Commodi laboriosam rerum omnis perferendis rerum nihil. Saepe et et aspernatur omnis delectus.', 0, 1, '2013-04-21 12:31:52', '1981-04-23 13:06:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (46, 44, 19, 'Quia iure et excepturi aut aut aspernatur esse. Velit ut vel reprehenderit possimus praesentium. Aliquam eius voluptatum qui corporis provident omnis.', 1, 0, '1989-12-15 04:06:19', '2005-06-10 19:40:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (47, 10, 44, 'Quia consequatur vitae laboriosam. Qui esse sed velit libero blanditiis et aperiam omnis.', 0, 1, '1988-12-21 20:07:17', '1996-07-10 06:50:24');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (48, 19, 62, 'Aspernatur aut ratione vel maiores esse laborum. Voluptas sunt sint odio fugiat inventore quia. Autem odio aut porro molestiae delectus temporibus.', 1, 0, '2009-07-29 05:26:45', '2009-05-19 13:08:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (49, 75, 83, 'Explicabo ut atque porro cum impedit asperiores et. Quis quidem non et voluptatum et ea. Cumque officia aut nam sit ab ipsum ea voluptates.', 0, 1, '2018-03-23 01:34:16', '1992-06-14 23:36:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (50, 32, 9, 'Aut ea a ut aut. Nostrum qui dicta nulla consectetur quae. Quaerat et nulla sint voluptas dignissimos iusto assumenda. Temporibus alias provident harum.', 0, 0, '1985-07-07 07:24:14', '1978-01-11 05:40:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (51, 59, 62, 'Cumque et alias animi assumenda molestiae quis. Repellat ex itaque quis. Ut cupiditate quod et sed tempore.', 0, 1, '2004-08-21 10:22:21', '1972-01-16 04:19:27');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (52, 62, 48, 'Quibusdam consequatur nihil expedita delectus reiciendis modi. Voluptatem voluptatum temporibus blanditiis et ullam dolores numquam. Nam est vel nobis nostrum sit eos dolor.', 0, 0, '1985-12-21 13:42:03', '2004-07-20 23:24:05');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (53, 25, 86, 'Est laudantium qui placeat. Architecto quam ipsa sint aut aut qui dolores quas. In voluptatem deserunt dolorem sint voluptatibus et.', 0, 0, '1989-03-15 11:32:29', '1987-08-14 09:29:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (54, 84, 90, 'Ut vel porro sequi tenetur. Expedita ex harum repudiandae omnis omnis dolores. Aut facere voluptatem qui quis quisquam cupiditate eligendi.', 1, 1, '1976-10-03 10:25:30', '1992-03-10 11:20:49');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (55, 70, 88, 'Enim libero nihil delectus repellat facilis esse. Odit sapiente dolorem perferendis facere sed facere. Ea maiores eum saepe libero sunt eius id eveniet. Necessitatibus voluptas sint at dolor fugit.', 1, 0, '2005-09-01 00:55:55', '1972-01-14 20:51:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (56, 75, 99, 'Vel assumenda animi dolore omnis. Cupiditate quis excepturi et nesciunt. Vero temporibus voluptas hic neque ex cum.', 1, 0, '1981-03-01 20:56:18', '1976-11-23 08:39:42');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (57, 37, 33, 'Dolores quia doloremque voluptas voluptatum libero similique. Fuga id qui eum qui. Culpa repellendus repellat est.', 1, 1, '2002-12-21 09:03:44', '1971-08-12 17:14:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (58, 1, 13, 'Veniam ad molestiae ut rem. Ut numquam molestiae nisi quia. Quam perferendis in aliquam repellendus exercitationem. Saepe maxime error asperiores pariatur qui.', 0, 1, '1977-05-05 08:23:53', '2011-12-09 19:40:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (59, 78, 55, 'Odit qui voluptatibus facere. Aliquam aut molestiae quia ut officiis maiores. Itaque provident officiis ducimus odit officiis eveniet quod.', 1, 0, '1999-01-04 17:57:52', '2008-08-07 17:46:38');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (60, 9, 24, 'Asperiores et doloribus explicabo voluptatem occaecati labore dolores. Veniam accusamus dolorem ut exercitationem nesciunt velit eum. Nemo sunt et dolor sed laborum minima magnam.', 0, 1, '1973-01-28 18:26:37', '1985-06-17 12:42:30');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (61, 94, 28, 'Impedit aut nostrum debitis deleniti dolorum. Voluptatem maxime voluptas necessitatibus a et rem possimus. Quis iusto sint repellendus et sapiente et. Aut dolorum ad fugiat ratione aut est id.', 1, 0, '2019-05-15 13:50:37', '1980-05-22 17:33:03');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (62, 20, 50, 'Quas nam quo et esse. Eos quis dicta placeat nihil consequatur.', 0, 1, '1978-05-08 05:15:01', '2004-09-06 22:28:30');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (63, 20, 73, 'Quia ut voluptatem earum cum illum ducimus ratione excepturi. Et qui voluptas officia architecto sed sed ex pariatur.', 1, 1, '2001-07-06 14:22:14', '1974-09-09 11:50:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (64, 65, 25, 'Et exercitationem laudantium est est deleniti aut voluptas. Quod ea placeat sunt. Ipsum ex saepe hic ab.', 1, 1, '1977-07-16 07:42:06', '1994-01-26 19:46:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (65, 1, 50, 'Aut alias perspiciatis praesentium ducimus quasi. Dolorem ducimus corporis ipsum consequatur. Provident est dolor laudantium itaque autem autem.', 1, 1, '1997-06-19 21:30:27', '1998-09-30 10:54:19');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (66, 49, 96, 'Sit quo ducimus rerum sunt natus quas beatae. Saepe harum molestias ut harum occaecati quae at quam. Molestiae eos aut et ducimus ipsa. Vel labore ut sapiente et est dolorem.', 0, 1, '1998-01-18 08:39:20', '1971-04-30 15:06:15');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (67, 93, 66, 'Aut doloribus reprehenderit distinctio nulla. Error error tenetur voluptatem enim eaque perspiciatis est. Ipsam voluptatem a facere sunt voluptate earum consequatur maxime.', 0, 0, '2012-09-01 01:03:16', '1999-07-13 22:22:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (68, 89, 19, 'Hic dolor minus ut similique. Autem voluptatem aut itaque nesciunt. Omnis vel repellat sed consequatur. Animi repellendus necessitatibus quibusdam et doloremque et.', 0, 0, '2011-08-18 18:25:18', '2020-03-29 12:22:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (69, 77, 75, 'Repudiandae mollitia et ut. Illo repudiandae aut a et enim expedita. Non alias voluptatem itaque eos eos eligendi.', 0, 1, '1988-03-22 10:28:44', '2003-01-02 06:14:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (70, 26, 57, 'Amet excepturi temporibus sequi qui. Tempora esse voluptatibus aut consectetur et dicta laudantium. Molestiae animi recusandae perferendis quidem. Nam ipsum neque nisi ut quia.', 0, 0, '2011-09-08 09:30:19', '1976-06-19 07:00:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (71, 25, 78, 'Similique quia iure dicta aut. Dolorem numquam aut sapiente atque. Et facere autem excepturi est.', 0, 1, '2006-12-08 11:30:11', '2007-05-01 20:20:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (72, 62, 36, 'Numquam ipsum libero voluptatem harum quos autem sint aut. Dolorem cupiditate harum aut repudiandae tempora amet. Blanditiis aperiam inventore nostrum commodi error sit nihil.', 0, 0, '1971-07-09 20:39:03', '2020-02-21 15:07:52');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (73, 84, 13, 'Consequuntur ea laboriosam labore quam perspiciatis. Enim earum in dolores iusto voluptatem facilis expedita. Et nostrum voluptatem et deserunt autem voluptas. Sunt ad sit inventore quia porro molestiae autem. Libero laboriosam eius vero sunt voluptate.', 1, 1, '1980-06-21 21:14:49', '2007-07-29 22:28:33');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (74, 15, 85, 'Ut incidunt amet a et. Ut ut sint eos enim. Ratione similique quisquam ad nam aliquam omnis deserunt.', 1, 1, '1985-04-14 02:36:42', '1970-11-24 16:18:01');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (75, 100, 88, 'Aperiam nulla voluptas vero magnam repudiandae laboriosam eum. Id odio aliquam error beatae ullam maxime. Laboriosam ad aliquid quibusdam adipisci est labore. Quibusdam et porro rerum ducimus. Possimus id neque repudiandae amet dolorum veniam.', 1, 0, '2011-06-22 10:19:50', '1973-12-19 09:04:18');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (76, 68, 72, 'Ut tempore sint omnis explicabo qui et sint. Provident sit magni cumque et. Aliquid mollitia tempora quaerat quam hic assumenda.', 0, 1, '1981-08-09 21:32:48', '1975-11-27 15:24:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (77, 59, 5, 'Saepe facilis soluta sapiente est aut est. Voluptates blanditiis ut aliquid aut sit et et. Ea quam earum non repellendus laboriosam autem. Illum corporis molestiae consectetur et voluptatem et.', 1, 0, '1999-10-27 08:03:54', '2013-08-07 21:42:38');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (78, 80, 55, 'Dolores minus qui sit. Officia amet sapiente voluptate maiores architecto excepturi. Ut rerum est ut molestias. Quidem voluptatem autem id veritatis et sit. Ipsa laudantium quidem inventore.', 1, 0, '2009-12-12 00:12:47', '2007-05-22 20:46:51');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (79, 78, 48, 'Error inventore est sunt iure non enim. Expedita et voluptatem animi nihil vel tempore.', 1, 1, '2016-12-17 21:14:13', '1996-05-09 08:32:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (80, 6, 25, 'Quo unde adipisci necessitatibus voluptatem reiciendis voluptatem ipsam. Dolores rem voluptas accusamus. Aut ut dolor tenetur aut nostrum vel ducimus incidunt.', 0, 0, '1973-08-19 19:07:37', '2019-06-26 12:51:25');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (81, 37, 52, 'Porro rem a repellat exercitationem aut odio. Ut ut dolores qui non omnis omnis sit iusto. Sequi repudiandae voluptate reiciendis veniam eveniet doloremque non aut. Magni at eum est velit sapiente sed.', 1, 0, '1984-03-18 16:30:34', '1977-04-07 07:08:45');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (82, 69, 10, 'At velit quo vel aut nihil illum. Aut consequatur iure est sed ratione quidem corrupti. Beatae consequatur harum consectetur quo culpa vel exercitationem. Iusto et occaecati consequuntur est ut deserunt sit.', 0, 0, '2006-09-05 09:52:25', '2014-12-04 11:51:23');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (83, 100, 23, 'Quia enim aut minima repellat consequuntur. Vel occaecati vitae est molestiae quia tenetur. Optio nemo omnis rerum quis quo hic. Enim ullam voluptatem repudiandae qui.', 0, 0, '2004-07-12 19:18:26', '2003-10-10 18:51:49');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (84, 89, 61, 'Mollitia atque mollitia omnis quaerat. Labore mollitia quas inventore provident atque. Commodi rerum saepe alias cumque voluptatibus ipsum vel non. Distinctio quo at nesciunt ea magni.', 0, 0, '1986-04-12 19:09:47', '2006-08-04 03:26:17');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (85, 96, 90, 'Iusto natus aut recusandae iure impedit consequatur asperiores. In voluptatibus dolores et sit nam qui consequatur. Cupiditate itaque eius necessitatibus eos. Iure explicabo impedit assumenda ut veniam.', 0, 1, '2003-12-02 02:36:14', '1973-06-06 04:52:10');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (86, 11, 7, 'Itaque ab et ex soluta non quasi. Repudiandae qui voluptatibus eaque explicabo labore odio. Et id quia asperiores aperiam commodi est quia dignissimos.', 1, 1, '2011-02-15 04:49:28', '1977-03-08 05:17:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (87, 81, 53, 'Nulla et qui doloremque incidunt. Rerum at autem omnis voluptatem autem quia. Et et dicta pariatur ad.', 1, 1, '2001-01-01 18:44:26', '2009-07-22 01:34:02');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (88, 81, 94, 'Aliquam nobis et sapiente quia excepturi. Quidem accusantium quis tempore modi vel voluptate quos tempore. Earum id illo labore assumenda expedita quia.', 1, 1, '1979-08-14 10:43:18', '2014-09-24 20:25:11');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (89, 91, 28, 'Nostrum praesentium itaque aut porro explicabo. Maiores ipsam quo deleniti illo corporis.', 0, 1, '1993-05-08 12:56:08', '1996-08-21 22:07:12');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (90, 92, 3, 'Et ut sunt rerum consequuntur temporibus quisquam veniam. In veniam non harum molestiae delectus ut. Quaerat ullam vitae quas possimus minima harum. Aperiam qui nihil modi quasi quasi deserunt.', 0, 1, '1973-08-04 11:26:56', '1996-07-21 15:58:32');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (91, 25, 89, 'Quaerat non incidunt et est. Nesciunt consequatur aut cum tenetur voluptatem repellat alias. Unde qui cum odio molestiae iusto.', 0, 0, '2011-07-26 17:45:39', '1996-06-29 01:33:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (92, 37, 93, 'Blanditiis voluptates ipsa praesentium facilis maxime. Odit laborum sed et pariatur tempore. A quis eaque soluta autem debitis.', 1, 1, '1972-09-04 08:02:56', '1980-03-21 10:50:57');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (93, 67, 93, 'Id explicabo iure vel eum. Esse dolore nemo quae consequuntur. Aut est vel voluptatem voluptatibus quidem dolor a aliquid. Et optio ex sit a sapiente pariatur.', 0, 0, '1994-01-08 23:14:40', '1985-09-10 15:30:29');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (94, 45, 23, 'Cupiditate sunt a nihil vel quis quos. Deserunt sunt qui maiores. Sint illo numquam expedita quaerat reiciendis in.', 1, 0, '1973-03-26 14:42:35', '1981-06-29 03:00:08');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (95, 90, 47, 'Enim sit perferendis et eum nihil. Neque qui dolorum sed nisi ut. Consequatur sunt sapiente magnam assumenda fugit perspiciatis vitae. Molestiae asperiores adipisci beatae quia.', 1, 0, '2008-10-19 13:55:24', '2004-05-16 19:20:55');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (96, 98, 51, 'Et magni consequatur architecto sit culpa. Accusamus incidunt neque rerum aliquid laborum possimus assumenda nihil. Et consequuntur aliquid rerum aspernatur. Mollitia odit exercitationem eius sapiente necessitatibus magni qui.', 1, 1, '2000-03-07 01:15:05', '1983-12-26 18:05:47');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (97, 77, 37, 'Et omnis minus vitae quasi natus. Et qui voluptate placeat nam dolores iure aut officiis. Fugit molestiae nobis numquam earum dolores debitis excepturi. Soluta quia sed suscipit.', 0, 1, '1980-12-27 11:11:57', '1979-09-05 19:08:56');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (98, 27, 6, 'Et ab praesentium cum ipsam consequatur ipsum doloremque quaerat. Et nesciunt et consequatur totam. Eum ut qui quis ut sed. In iure doloremque totam distinctio odit debitis.', 0, 0, '2003-11-20 23:27:54', '2010-07-12 18:06:07');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (99, 49, 72, 'Voluptatem et cupiditate voluptas. Eaque quis et ex. Sapiente praesentium modi cupiditate qui. Incidunt aspernatur ipsa fugit facere omnis facere.', 0, 0, '1971-12-28 07:35:20', '1989-08-31 08:10:06');
INSERT INTO `messages` (`id`, `from_user_id`, `to_user_id`, `body`, `is_important`, `is_delivered`, `created_at`, `updated_at`) VALUES (100, 88, 73, 'Similique voluptatem voluptas delectus nesciunt. Ut velit ratione corporis ullam. Consequuntur nemo quos aliquam laudantium error eaque.', 1, 0, '1990-08-20 16:31:19', '2003-03-29 20:40:40');


-- #
-- # TABLE STRUCTURE FOR: profiles
-- #

-- DROP TABLE IF EXISTS `profiles`;
--
-- CREATE TABLE `profiles` (
  -- `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  -- `gender` char(1) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Пол',
--  `birthday` date DEFAULT NULL COMMENT 'Дата рождения',
--  `photo_id` int(10) unsigned DEFAULT NULL COMMENT 'Ссылка на основную фотографию пользователя',
--  `city` varchar(130) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Город проживания',
--  `country` varchar(130) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Страна проживания',
--  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
--  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
--  PRIMARY KEY (`user_id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Профили';

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (1, '', '1984-08-30', 91715, 'West Mustafaport', 'Oman', '1970-08-28 04:14:14', '2011-07-24 06:42:29');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (2, 'f', '1992-08-28', 67318, 'Erynbury', 'Tonga', '1987-04-18 23:54:19', '1971-08-19 06:43:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (3, '', '1996-10-23', 68396, 'Caleshire', 'Pitcairn Islands', '1981-08-21 19:07:35', '1990-04-21 13:46:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (4, 'm', '1970-01-15', 26090, 'Abbottbury', 'Guadeloupe', '2008-03-02 08:32:28', '1975-12-25 21:52:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (5, '', '2016-05-31', 36990, 'Orionburgh', 'Spain', '2017-08-13 05:54:44', '2012-11-16 18:18:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (6, '', '1979-09-09', 12216, 'Zettamouth', 'Croatia', '1979-01-31 23:39:04', '2018-10-10 11:58:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (7, 'm', '1990-05-01', 50405, 'Bodefurt', 'Slovenia', '1986-11-10 14:22:07', '2007-11-30 08:39:38');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (8, '', '2020-06-01', 33897, 'Rubiefort', 'Sudan', '1983-01-06 08:07:38', '1980-02-18 20:27:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (9, '', '2003-03-02', 81972, 'South Cleoville', 'Swaziland', '1974-08-11 00:15:19', '1977-06-27 19:43:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (10, 'm', '2003-10-21', 1527, 'Flaviechester', 'Kenya', '1986-03-07 08:08:13', '2002-03-01 14:22:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (11, 'm', '2014-10-28', 46503, 'North Wandaview', 'Cyprus', '2013-03-31 04:07:40', '2018-07-04 06:47:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (12, 'f', '1974-09-04', 86161, 'North Rileymouth', 'New Zealand', '1983-03-12 03:19:02', '1989-07-14 20:46:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (13, '', '1985-02-17', 64326, 'Lake Janick', 'Swaziland', '1997-06-03 19:11:33', '2003-03-22 00:29:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (14, '', '1983-09-17', 61080, 'Port Eloise', 'Latvia', '2017-09-15 09:57:55', '1999-04-16 22:12:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (15, '', '1987-01-30', 56394, 'Hermannberg', 'France', '2005-01-06 10:30:12', '1999-03-07 19:37:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (16, 'f', '2010-09-07', 58717, 'West Isidroshire', 'Bermuda', '1989-09-11 20:20:56', '2001-08-27 11:46:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (17, '', '2006-01-04', 57894, 'North Keely', 'Venezuela', '1981-06-02 11:32:53', '2019-01-26 05:10:04');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (18, '', '1998-08-29', 5653, 'Arielhaven', 'American Samoa', '2017-11-13 03:36:43', '1980-07-04 18:39:56');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (19, 'm', '1989-06-28', 35847, 'Lake Griffinberg', 'Canada', '2016-03-18 04:43:01', '2017-06-01 00:37:40');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (20, 'f', '2007-04-04', 88720, 'North Willytown', 'Namibia', '1972-10-23 11:27:03', '2013-10-12 09:16:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (21, '', '2010-07-18', 72897, 'South Larissa', 'Martinique', '1978-01-08 08:00:29', '1999-10-28 12:47:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (22, '', '2009-05-31', 97036, 'New Kenneth', 'Falkland Islands (Malvinas)', '2001-08-03 21:47:39', '1994-02-02 01:16:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (23, '', '2019-03-25', 95897, 'Imaville', 'Taiwan', '1979-04-12 02:40:09', '2016-01-09 01:28:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (24, '', '1980-03-03', 58226, 'South Jonaston', 'Denmark', '1977-11-16 20:52:04', '1998-02-22 17:42:28');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (25, 'm', '1986-05-11', 92097, 'Katrineport', 'Denmark', '2015-06-04 18:46:01', '2000-12-26 12:31:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (26, '', '2018-09-07', 51060, 'New Tristonfurt', 'South Georgia and the South Sandwich Islands', '1998-10-19 03:15:22', '2020-01-14 12:16:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (27, '', '2008-06-25', 28814, 'South Louisaton', 'Japan', '1983-09-28 00:04:34', '1987-10-25 11:18:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (28, '', '1975-07-16', 44880, 'Lake Audreanneton', 'Denmark', '1998-07-10 20:19:21', '2018-03-07 09:57:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (29, 'f', '2007-09-04', 47604, 'Framifort', 'Guernsey', '2006-11-08 13:01:11', '1998-08-05 21:48:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (30, 'm', '2011-06-17', 16809, 'Leoneburgh', 'Mozambique', '2009-08-07 12:49:02', '2004-06-29 07:36:07');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (31, '', '2009-01-03', 41704, 'West Deven', 'Martinique', '2015-11-11 08:12:55', '1984-05-13 21:39:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (32, '', '1980-12-13', 58143, 'Josefahaven', 'Sudan', '1990-07-09 00:31:06', '1984-11-15 10:42:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (33, '', '2003-12-06', 56971, 'Madisyntown', 'Grenada', '1988-07-21 03:54:34', '1989-10-17 15:37:16');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (34, 'f', '2018-11-17', 77716, 'O\'Connermouth', 'Israel', '1999-01-27 01:19:43', '2016-03-03 19:14:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (35, '', '1981-06-30', 94182, 'East Woodrow', 'Albania', '1980-12-24 13:01:04', '2010-12-06 01:27:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (36, 'f', '1971-06-19', 13506, 'Kristianburgh', 'Rwanda', '2016-11-20 00:04:00', '2016-01-16 00:47:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (37, '', '1998-09-08', 72957, 'Kuhnmouth', 'Indonesia', '2017-11-06 01:34:00', '1987-08-14 16:11:02');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (38, '', '2007-10-14', 41422, 'Shermanchester', 'Dominican Republic', '2017-07-10 19:39:22', '1989-08-10 11:21:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (39, '', '2014-06-23', 73111, 'East Judy', 'Togo', '2001-10-03 00:53:16', '2015-06-04 21:39:23');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (40, '', '2005-03-07', 56452, 'Waterschester', 'Antigua and Barbuda', '1975-04-20 08:35:07', '2011-04-14 03:39:31');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (41, '', '1975-11-25', 37588, 'Lake Creola', 'Netherlands', '1993-12-05 10:20:34', '1982-07-31 23:23:40');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (42, 'f', '1999-01-25', 72546, 'Hoppemouth', 'Martinique', '1998-02-05 17:54:59', '1986-02-19 19:20:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (43, 'f', '1994-10-12', 13089, 'Steuberchester', 'Saint Barthelemy', '1982-11-05 20:58:57', '1992-09-25 12:04:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (44, '', '1979-09-07', 45546, 'South Audreyland', 'Afghanistan', '2006-01-21 07:51:15', '1980-04-29 13:46:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (45, '', '1975-02-15', 5718, 'Vanceville', 'Lao People\'s Democratic Republic', '1983-01-05 23:57:48', '1977-08-24 21:23:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (46, 'm', '1971-02-22', 42118, 'Christshire', 'Northern Mariana Islands', '1998-07-21 12:17:40', '2008-04-25 01:50:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (47, '', '2017-06-01', 46510, 'Sonyahaven', 'Zambia', '1998-08-21 10:41:41', '2014-04-23 00:04:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (48, 'm', '2011-01-26', 33491, 'Kassulkeland', 'Iran', '2018-10-21 18:06:37', '2016-08-21 14:41:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (49, 'f', '1981-08-03', 89784, 'Port Gunner', 'Italy', '2005-01-18 18:59:30', '1971-08-15 19:20:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (50, 'f', '2020-01-05', 61451, 'South Juneborough', 'Zimbabwe', '2011-05-23 01:16:37', '1987-12-06 00:58:07');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (51, 'f', '2005-05-17', 13718, 'East Khalilchester', 'Turkmenistan', '1982-01-08 08:02:01', '1998-10-21 10:00:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (52, '', '2006-11-22', 31591, 'East Devan', 'United Arab Emirates', '2016-06-03 18:01:39', '1991-07-31 12:34:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (53, 'm', '2014-05-31', 80079, 'New Eugeneburgh', 'Tajikistan', '1973-08-16 08:04:02', '2005-05-01 04:52:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (54, '', '1990-06-02', 78121, 'Elianeland', 'Turkey', '1983-01-27 09:55:58', '1971-04-30 03:10:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (55, '', '1991-01-31', 85742, 'Margeview', 'Denmark', '2016-11-14 06:45:04', '1983-02-07 21:36:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (56, 'm', '2010-01-06', 1120, 'Dietrichberg', 'Guadeloupe', '1970-03-02 19:38:19', '1976-05-24 22:56:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (57, '', '1993-08-10', 92456, 'Keelingshire', 'Lebanon', '2011-08-06 08:31:42', '1973-09-29 12:19:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (58, 'f', '1997-04-29', 72087, 'Port Mafaldaville', 'Brunei Darussalam', '2006-02-28 02:25:50', '2011-02-16 04:30:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (59, 'm', '1998-03-25', 11782, 'Purdystad', 'Cocos (Keeling) Islands', '1975-08-31 00:16:08', '1983-09-15 00:20:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (60, '', '1977-07-13', 36850, 'South Valliehaven', 'Montenegro', '1972-03-23 14:08:48', '2008-10-12 18:04:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (61, 'm', '2016-11-18', 75988, 'Bartellland', 'Madagascar', '2012-09-05 09:59:30', '2013-11-16 16:07:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (62, 'f', '2015-11-19', 72206, 'South Waldoland', 'Burkina Faso', '2016-05-14 00:19:14', '2017-04-18 03:33:21');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (63, '', '2004-05-24', 31552, 'Gertrudeberg', 'Russian Federation', '2009-05-19 10:07:52', '1996-02-26 03:40:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (64, 'f', '2016-10-04', 18550, 'South Deonside', 'Bouvet Island (Bouvetoya)', '1997-09-21 10:19:29', '2011-12-28 09:47:19');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (65, 'm', '2001-10-12', 53328, 'West Andreannemouth', 'Monaco', '2013-10-26 21:46:05', '1994-04-18 10:42:56');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (66, '', '1983-01-19', 82639, 'Harveystad', 'Zambia', '1987-12-28 20:14:42', '2015-11-08 17:27:25');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (67, 'm', '1983-07-19', 19208, 'Prosaccofort', 'Zambia', '1997-03-03 18:57:23', '1983-08-14 17:56:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (68, '', '2007-04-07', 53261, 'West Margret', 'Serbia', '1994-11-02 20:47:43', '1999-07-05 01:47:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (69, 'f', '1980-09-24', 87077, 'Elinorestad', 'Angola', '1981-06-27 13:03:01', '1996-04-11 04:48:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (70, '', '2009-12-30', 95952, 'Schowalterborough', 'Montenegro', '1990-11-29 08:20:11', '1971-06-08 19:10:40');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (71, 'm', '1979-04-28', 98560, 'Jacobsburgh', 'Papua New Guinea', '1973-11-10 14:29:22', '1979-06-25 22:59:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (72, '', '2005-12-30', 56463, 'North Keenan', 'Mayotte', '1987-11-04 13:31:02', '1975-08-09 05:38:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (73, 'f', '2014-01-12', 94337, 'Marleyhaven', 'Bolivia', '2016-04-13 18:33:46', '1980-07-29 05:23:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (74, 'f', '2010-01-22', 64226, 'Rennerborough', 'Sudan', '1980-04-04 14:00:03', '1991-04-28 07:10:40');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (75, '', '1991-02-21', 43452, 'Edenport', 'Paraguay', '2014-02-23 22:59:54', '2008-09-13 00:46:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (76, '', '2002-08-14', 96847, 'Ondrickastad', 'Italy', '2010-04-17 09:16:39', '1981-03-19 07:50:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (77, 'f', '1981-05-19', 8770, 'West Antoniettaberg', 'Martinique', '2008-08-13 09:36:26', '2000-11-04 03:46:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (78, 'm', '2007-01-30', 59353, 'Ornhaven', 'San Marino', '1989-01-19 16:50:08', '1994-11-24 18:10:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (79, 'f', '2012-01-14', 12775, 'Lake Wilberbury', 'Mauritius', '2005-09-26 15:20:20', '2008-08-30 12:50:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (80, '', '2019-10-28', 92445, 'Lonnyfurt', 'Nigeria', '1974-04-10 23:45:27', '2016-12-17 19:48:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (81, 'm', '2003-05-11', 37893, 'Haventown', 'Costa Rica', '2010-09-24 12:06:05', '2000-08-05 17:05:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (82, 'f', '2015-04-02', 40989, 'Port Anyaburgh', 'Macao', '1984-04-10 09:05:49', '2012-10-28 01:23:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (83, '', '1975-03-16', 24212, 'Lake Alec', 'Guyana', '1995-09-23 19:27:35', '2010-08-06 00:10:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (84, 'm', '1978-01-21', 93906, 'West Grace', 'Armenia', '1987-11-12 21:18:16', '2002-11-24 23:36:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (85, '', '1975-06-23', 55281, 'Jermeymouth', 'Martinique', '2009-11-28 00:05:33', '1979-06-11 08:52:13');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (86, '', '1977-08-29', 39859, 'South Audreanneside', 'Sierra Leone', '2019-08-17 21:32:59', '1971-06-27 18:54:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (87, 'm', '1971-09-20', 56855, 'Port Raul', 'Croatia', '2010-09-17 10:06:58', '1977-04-09 09:54:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (88, '', '1998-03-06', 43432, 'South Virgie', 'Macao', '2006-03-26 01:13:40', '1997-11-09 14:54:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (89, '', '1990-02-12', 35867, 'West Anaisburgh', 'Mauritania', '2004-12-08 07:01:42', '1996-05-08 20:56:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (90, '', '1988-10-02', 44367, 'North Lyricfurt', 'Holy See (Vatican City State)', '1989-01-11 09:37:30', '1990-05-06 11:45:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (91, 'f', '1978-11-12', 97005, 'Lake Erica', 'Faroe Islands', '1991-02-21 02:31:30', '1992-03-02 01:54:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (92, 'f', '1979-07-01', 18029, 'New Leonora', 'Israel', '1989-05-01 06:54:57', '1998-02-28 04:41:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (93, 'f', '1983-02-01', 49305, 'Calebbury', 'Bangladesh', '2003-08-18 09:28:05', '1971-09-10 00:32:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (94, 'f', '2019-09-29', 48169, 'West Angelinehaven', 'Morocco', '1989-11-07 23:10:20', '1999-03-29 00:52:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (95, '', '2010-07-28', 3967, 'New Harold', 'Gambia', '2018-07-25 00:49:42', '1988-10-27 14:13:16');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (96, 'm', '1984-05-20', 23850, 'New Aliyah', 'Egypt', '1972-02-06 10:08:37', '1975-02-12 18:53:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (97, '', '2011-10-11', 17708, 'North Gwendolyn', 'Saint Kitts and Nevis', '1992-04-18 02:53:21', '1972-12-21 17:39:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (98, 'f', '1998-09-06', 71165, 'Lake Frankie', 'Guam', '2013-09-15 20:44:06', '2012-02-10 13:37:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (99, '', '1991-03-08', 97909, 'Lavonmouth', 'Mauritania', '2002-10-10 10:19:29', '1997-05-28 02:49:57');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `city`, `country`, `created_at`, `updated_at`) VALUES (100, '', '1998-09-28', 48723, 'South Anika', 'Moldova', '2013-08-03 06:58:16', '1983-09-29 01:55:19');


-- #
-- # TABLE STRUCTURE FOR: users
-- #

-- DROP TABLE IF EXISTS `users`;

-- CREATE TABLE `users` (
  -- `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  -- `first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Имя пользователя',
  -- `last_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Фамилия пользователя',
  -- `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Почта',
--  `phone` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Телефон',
  -- `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  -- `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  -- PRIMARY KEY (`id`),
--  UNIQUE KEY `email` (`email`),
--  UNIQUE KEY `phone` (`phone`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Пользователи';

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Fabian', 'Bruen', 'gpadberg@example.org', '79962967453', '2006-11-04 04:17:31', '1980-11-30 19:55:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'German', 'Grady', 'buddy.kovacek@example.org', '79184340571', '1979-09-10 01:17:34', '1992-02-23 14:19:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (3, 'Araceli', 'Gottlieb', 'schultz.mary@example.net', '79031350957', '2015-01-11 00:06:25', '1970-01-30 19:28:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'Tyrese', 'Grant', 'cullen51@example.net', '79519744806', '1990-09-20 20:21:52', '2013-06-30 14:59:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'Sandrine', 'Greenholt', 'trinity15@example.com', '79797676604', '1998-09-03 06:23:56', '2000-12-22 14:22:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'Marquise', 'Lockman', 'orion.renner@example.net', '79971548868', '1975-02-03 19:45:20', '1980-01-03 14:41:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'Benedict', 'Rau', 'jamey.lehner@example.com', '79893121378', '2008-05-28 19:26:36', '2017-08-07 20:50:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'Serena', 'Kuvalis', 'naomi.torp@example.net', '79173767956', '2002-06-06 18:24:00', '1974-06-28 09:20:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'Josie', 'Hickle', 'sauer.yesenia@example.org', '79698820664', '1995-12-24 09:11:00', '1990-10-27 16:36:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'Laverna', 'Flatley', 'hal27@example.com', '79820117482', '2018-06-17 10:09:47', '1978-10-11 13:46:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'Leopoldo', 'Cummings', 'lhintz@example.com', '79684222104', '2009-11-05 15:14:31', '1975-11-17 03:37:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'Braxton', 'Sanford', 'unader@example.net', '79255821676', '1975-08-16 01:23:39', '2016-12-23 13:09:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'Kallie', 'Dicki', 'bertrand.senger@example.com', '79409176538', '1998-06-15 02:27:51', '2010-10-19 11:07:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'Elza', 'Glover', 'joshuah.lang@example.net', '79634515067', '2014-06-01 16:01:55', '2004-07-16 16:59:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'Monserrate', 'Flatley', 'bernadette.jakubowski@example.org', '79109877904', '1992-03-30 02:20:24', '2000-02-13 03:44:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'Cordie', 'Greenholt', 'clovis64@example.com', '79694368597', '1977-04-23 17:51:14', '1996-05-03 14:42:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'Osborne', 'Kreiger', 'nswaniawski@example.org', '79466477138', '2009-08-17 23:28:23', '1972-12-04 13:52:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'Libbie', 'Swift', 'vhowell@example.org', '79631403623', '2002-07-21 00:16:32', '1996-12-09 12:52:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'Estella', 'Murray', 'chesley80@example.net', '79149628914', '1973-07-20 08:18:17', '1995-02-04 21:48:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'Jules', 'Mayert', 'shaylee.pacocha@example.net', '79768301258', '1981-11-13 19:00:05', '1992-10-18 02:00:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'Alvera', 'Boyle', 'fritsch.leslie@example.org', '79031581547', '1978-07-09 12:20:40', '1982-01-20 10:50:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'Jordy', 'Johnston', 'ggutmann@example.org', '79628337375', '1993-02-15 22:18:44', '1995-01-20 00:30:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'Delphine', 'Tromp', 'jturner@example.org', '79773189352', '1979-04-03 20:22:33', '2014-06-13 05:53:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'Wilmer', 'Gottlieb', 'schulist.markus@example.net', '79784962314', '1985-02-28 06:05:25', '2011-02-07 06:36:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'River', 'Koss', 'napoleon.fay@example.org', '79255804800', '1998-09-02 20:43:50', '2007-08-15 10:08:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'Russell', 'Dooley', 'jmohr@example.net', '79506986410', '1998-01-11 22:21:02', '1995-12-19 16:38:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'Lydia', 'Lubowitz', 'charles78@example.net', '79189946626', '1974-11-08 00:32:13', '2007-02-05 01:03:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'Reynold', 'Ritchie', 'vrodriguez@example.org', '79156903005', '2002-08-12 22:45:52', '1992-09-16 23:58:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'Maeve', 'Moore', 'constance86@example.org', '79586273566', '2011-12-29 04:35:37', '1976-02-06 09:30:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'Unique', 'Cummings', 'xhills@example.org', '79258312531', '1980-12-13 15:13:53', '2016-12-31 08:11:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'Paige', 'Mayert', 'vicky.christiansen@example.org', '79560821092', '2013-02-01 11:49:41', '2020-04-15 22:12:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'Dallin', 'Skiles', 'murray.sterling@example.net', '79792082167', '1971-08-22 03:11:35', '1985-05-27 16:35:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'Zackery', 'Dickens', 'qanderson@example.net', '79825653557', '1978-02-15 01:33:59', '2012-12-27 00:09:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'Felipe', 'Ward', 'ikris@example.org', '79034898321', '1974-08-01 21:27:30', '1981-09-21 23:42:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'Bernita', 'Wisozk', 'mack.yundt@example.com', '79867645500', '1999-03-29 13:53:26', '2013-08-01 19:13:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'Kara', 'Sawayn', 'murray.enos@example.org', '79744892529', '1976-10-16 08:20:24', '2002-08-09 04:49:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'Rhea', 'Schultz', 'yasmeen18@example.org', '79969079592', '1986-12-26 00:15:08', '1972-02-06 20:01:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'Deanna', 'Heathcote', 'rosalind56@example.org', '79231190016', '1979-04-26 16:33:40', '2011-10-19 08:35:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'Quinton', 'Jacobi', 'dawn.cassin@example.net', '79780473026', '1995-11-19 01:38:23', '2003-11-08 11:10:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'Adela', 'Dooley', 'agleichner@example.org', '79772978063', '2005-08-06 15:05:28', '2009-08-13 05:09:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'Herta', 'Pouros', 'tlindgren@example.org', '79764465740', '1979-02-24 18:12:23', '2002-04-25 01:37:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'Dewitt', 'Erdman', 'henriette.smitham@example.com', '79041915084', '2011-05-04 12:23:13', '1984-12-27 09:59:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'Keegan', 'Morar', 'weimann.lurline@example.net', '79181751704', '1992-06-03 13:47:14', '2014-03-20 19:58:50');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'Mona', 'Lubowitz', 'audreanne.fay@example.org', '79570170601', '1981-08-10 02:51:31', '1999-11-04 06:43:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'Monique', 'Bernhard', 'zemlak.rosalind@example.org', '79091823919', '2014-06-15 22:06:09', '2012-04-27 18:09:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'Cordie', 'Schmitt', 'kilback.evelyn@example.org', '79640073059', '1981-12-22 11:58:03', '2003-04-28 23:02:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'Zane', 'West', 'kolby53@example.net', '79928218419', '1975-04-05 06:37:44', '1989-05-14 08:25:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'Keenan', 'Auer', 'reyes52@example.com', '79188720507', '1996-07-16 00:17:59', '2016-08-21 16:50:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'Delia', 'Lang', 'breanna.schimmel@example.net', '79545738048', '1986-10-09 01:31:24', '2005-06-21 13:52:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'Shania', 'Orn', 'kirk17@example.net', '79779092679', '1981-05-13 14:36:26', '1978-12-13 06:44:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'Brandt', 'O\'Kon', 'lamar.padberg@example.com', '79273002615', '2007-02-04 12:14:36', '2002-03-24 14:55:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'Annabell', 'Krajcik', 'xgrady@example.com', '79613781045', '2020-05-31 16:35:41', '1982-06-13 10:50:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'Richmond', 'Torphy', 'lindsay.kuvalis@example.com', '79948372375', '2019-11-28 21:35:35', '1990-09-14 12:33:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'Hosea', 'Reinger', 'cummings.archibald@example.com', '79728660145', '1977-04-29 16:27:34', '1998-04-07 14:00:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'Boyd', 'Hagenes', 'cmarvin@example.net', '79201694723', '1985-12-03 01:26:35', '1998-08-05 06:16:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'Adell', 'Ankunding', 'davis.eddie@example.com', '79933372541', '2012-01-18 12:45:04', '2006-01-08 09:40:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'Hilda', 'Kovacek', 'yrunolfsson@example.net', '79081738781', '1974-01-26 21:52:44', '1997-05-21 07:15:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'Rylan', 'Rowe', 'mheidenreich@example.com', '79179494223', '1981-06-22 08:34:08', '1997-08-26 20:59:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'Salvador', 'Hodkiewicz', 'rbechtelar@example.net', '79373193417', '2001-04-19 18:27:37', '1984-10-06 21:51:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'Antwon', 'Zemlak', 'daugherty.mafalda@example.org', '79786368141', '2010-10-15 23:56:49', '1976-07-09 18:29:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'Gunnar', 'Franecki', 'arthur24@example.com', '79024918127', '1993-02-27 21:36:52', '2018-12-01 05:32:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'Alda', 'Marvin', 'guillermo.walter@example.com', '79253518117', '1973-07-11 17:30:54', '1984-05-11 01:26:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'Cesar', 'Stamm', 'meda.feeney@example.org', '79605798583', '2009-01-26 10:26:03', '1985-09-17 23:55:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'Mable', 'Reynolds', 'fausto.brakus@example.net', '79090358693', '1998-05-05 22:08:15', '1993-09-26 07:08:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'Geovanni', 'Blanda', 'cierra.marks@example.org', '79053449607', '1982-06-03 19:19:18', '2009-05-17 10:54:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'Della', 'Weissnat', 'amani16@example.com', '79387642766', '1977-05-09 10:09:00', '2006-06-12 03:30:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'Rose', 'Ryan', 'ruthie16@example.org', '79619999382', '1974-12-13 00:00:27', '1977-03-10 22:54:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'Wilma', 'Kuhic', 'bernice67@example.org', '79878213627', '1972-12-11 10:23:09', '1986-04-28 10:06:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'Rowland', 'Conroy', 'mconn@example.net', '79831329127', '1983-05-05 02:42:02', '1988-06-08 13:05:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'Godfrey', 'Harris', 'ktrantow@example.com', '79260660451', '1983-08-02 23:26:16', '2002-10-26 13:30:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'Ceasar', 'Abernathy', 'reilly.dayna@example.com', '79971839368', '2008-01-18 21:02:11', '1975-09-01 18:51:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'Melyssa', 'Jaskolski', 'lrosenbaum@example.net', '79201965400', '1983-02-06 05:21:30', '1975-08-24 03:29:24');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'Ulices', 'Bailey', 'lschamberger@example.org', '79537668199', '2007-11-22 10:30:44', '2018-01-14 10:11:50');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'Michael', 'Watsica', 'johnathan99@example.net', '79452038908', '1981-03-16 01:26:04', '1991-03-11 19:28:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'Misty', 'Grady', 'spinka.magali@example.com', '79550530974', '1989-09-08 18:42:44', '1983-06-23 03:23:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'Johann', 'Johnson', 'ubashirian@example.com', '79579793964', '1994-09-02 16:52:59', '1973-08-24 03:32:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'Kennedi', 'Wyman', 'vince19@example.net', '79466538088', '2002-03-04 10:50:37', '1989-10-10 13:49:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'Viviane', 'Wilderman', 'fdickinson@example.net', '79700289459', '1981-12-31 20:46:45', '1999-08-01 04:00:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'Chaya', 'Hermiston', 'lucas82@example.org', '79632562620', '1979-11-20 11:14:46', '1974-07-15 00:38:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'Houston', 'Tremblay', 'jayde.marks@example.org', '79113894720', '1993-08-09 10:40:41', '1981-01-01 11:19:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'Dorian', 'Bernier', 'othompson@example.org', '79074423730', '2009-07-03 19:56:51', '1977-09-13 03:41:00');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'Dustin', 'Bechtelar', 'lilliana.hills@example.net', '79120011008', '1977-11-23 21:09:43', '2001-07-23 07:48:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'Adolfo', 'Buckridge', 'hobart.runolfsdottir@example.net', '79443330114', '1994-01-18 08:24:38', '2002-06-23 09:22:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'Brigitte', 'Bechtelar', 'jonas11@example.org', '79080752476', '2002-07-26 16:50:35', '1987-01-02 03:51:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'Melvina', 'Bechtelar', 'ulices75@example.com', '79589340204', '1985-01-23 21:22:16', '2019-10-18 02:11:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'Doris', 'Smitham', 'dach.cristal@example.net', '79665356526', '1986-08-22 03:59:18', '1974-04-25 16:42:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'Jarred', 'Windler', 'rau.kathlyn@example.com', '79899122069', '2011-03-15 11:06:39', '1976-01-27 23:42:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'Candice', 'Mante', 'marcel.cruickshank@example.org', '79120196867', '2009-04-14 00:18:04', '1999-01-14 15:27:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'Dax', 'Adams', 'claudine.collier@example.net', '79776152345', '1975-06-24 22:57:16', '2004-08-15 18:10:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'Trisha', 'Kuvalis', 'bwitting@example.org', '79436709864', '2010-08-22 22:45:45', '2019-12-26 11:09:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'Sabrina', 'Macejkovic', 'ezekiel48@example.org', '79792925808', '1999-07-30 00:13:50', '1987-09-06 19:00:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'Marc', 'Hegmann', 'jacinthe18@example.com', '79069405192', '2016-08-03 17:44:13', '2008-11-06 11:19:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'Brenden', 'Pagac', 'omclaughlin@example.net', '79547206288', '1977-10-04 12:06:10', '1980-12-29 06:34:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'Claudia', 'Mayer', 'meaghan.bartoletti@example.org', '79671982873', '1983-03-14 19:24:56', '1982-10-14 22:08:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'Trenton', 'Towne', 'mhagenes@example.org', '79732215282', '2001-04-10 12:46:35', '1990-10-21 14:20:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'Burley', 'Considine', 'hortense.bradtke@example.org', '79462428975', '2007-10-14 02:17:04', '1977-05-09 19:37:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'Laurence', 'Friesen', 'vwolf@example.org', '79090956310', '1999-04-03 06:05:45', '2008-07-24 04:24:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'Kurt', 'Morar', 'icie.howe@example.com', '79766325733', '1985-06-26 02:26:30', '1973-09-13 16:38:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'Dina', 'Hilll', 'anna.langworth@example.com', '79227626032', '1980-04-05 10:41:51', '1993-02-21 16:43:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Paris', 'Jacobi', 'grayce.ebert@example.net', '79925171556', '1977-12-27 02:27:41', '1971-01-04 05:26:34');



 

