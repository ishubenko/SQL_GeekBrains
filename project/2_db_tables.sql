-- 1---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  filename  VARCHAR(255),
-- size
-- type  
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 2-----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
  id int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 'Идентификатор команды',
  team_name varchar(150) NOT NULL, -- 'название команды',
  team_city varchar(150) NOT NULL, -- 'город команды',
  team_logo INT UNSIGNED NOT NULL, -- 'ссылка на фото значка/эмблемы команды',
  created_at datetime DEFAULT CURRENT_TIMESTAMP, -- 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 'Время обновления строки',
  FOREIGN KEY (team_logo) REFERENCES media(id)
);
CREATE INDEX team_name_city_idx ON teams(team_name, team_city);

-- 3-----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS players;
CREATE TABLE players (
  id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Идентификатор спортсмена
  team_id int unsigned NOT NULL, -- team
  f_l_name varchar(150) NOT NULL, -- Фамилия Имя
  birthday_at date DEFAULT NULL,
  params JSON, -- Данные игррока: позиция(нападающий/защитник), рост, вес
  created_at datetime DEFAULT CURRENT_TIMESTAMP, 
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (team_id) REFERENCES teams (id)
);
CREATE INDEX players_name_idx ON players(f_l_name);

-- 4-----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS tournaments;
CREATE TABLE tournaments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 'Идентификатор турнира',
  type_of_sport varchar(150) NOT NULL, -- 'вид спорта',
  tournaments_name varchar(150) NOT NULL, -- 'название турнира',
  season varchar(150) NOT NULL, -- 'год проведения турнира',
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE INDEX tournaments_name_season_idx ON tournaments(tournaments_name, season);

-- 5-----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS games;
CREATE TABLE games (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- Идентификатор события/матча
  games_date_time DATETIME NOT NULL, -- время матча/события
  place VARCHAR(100), -- место(город или стадион) проведения матча
  tournament_id INT UNSIGNED NOT NULL,
  team_1_id int unsigned NOT NULL,
  team_2_id int unsigned NOT NULL,
--  score_1 int unsigned NOT NULL,
--  score_2 int unsigned NOT NULL,
--  points_1 ENUM('0','1','3'),
--  points_2 ENUM('0','1','3'),
  events JSON, -- события внутри матча/протокол матча
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (tournament_id) REFERENCES tournaments(id),
  FOREIGN KEY (team_1_id) REFERENCES teams(id),
  FOREIGN KEY (team_2_id) REFERENCES teams(id)
);

-- 6-transfers----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS transfers;
CREATE TABLE transfers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 'Идентификатор трансфера',
  player_id INT UNSIGNED NOT NULL,
  team_from_id INT UNSIGNED NOT NULL,
  team_to_id INT UNSIGNED NOT NULL,
  trnf_date DATE NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (player_id) REFERENCES players(id),
  FOREIGN KEY (team_from_id) REFERENCES teams(id),
  FOREIGN KEY (team_to_id) REFERENCES teams(id)
);

-- 7-users----------------------------------------------------------------------------------------------------------------
-- редакторы контента, администраторы сайта, возможно, пользователи сайта.
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  level ENUM('admin','editor','user'),
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE INDEX user_name_idx ON users(name);

-- 8-posts----------------------------------------------------------------------------------------------------------------
-- Новости, статьти, лента на главной странице
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL, -- автор статьи
  theme VARCHAR(100) NOT NULL, -- Заголовок статьи
  media_id INT UNSIGNED, -- фотография(возможно видео, но на реальных примерах я находил только фото. Видео обычно по ссылке) к посту/статье
  body TEXT, -- текст статьи
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id), -- внешний ключ на автора статьи
  FOREIGN KEY (media_id) REFERENCES media(id) -- внешний ключ на таблицу медиа
);

-- 9-teams_tournaments------------------------------------------------------------------------------------------------------
-- Данная таблица будет соединять команды с турнирами, в которых они принимют участие
DROP TABLE IF EXISTS teams_tournaments;
CREATE TABLE teams_tournaments (
  team_id INT UNSIGNED NOT NULL,
  tournament_id INT UNSIGNED NOT NULL,
  total_points INT UNSIGNED NOT NULL DEFAULT 0,
  total_scored INT UNSIGNED NOT NULL DEFAULT 0,
  total_missed INT UNSIGNED NOT NULL DEFAULT 0,
  total_games INT UNSIGNED NOT NULL DEFAULT 0,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (team_id) REFERENCES teams(id),
  FOREIGN KEY (tournament_id) REFERENCES tournaments(id)
);
CREATE INDEX teams_totals_idx ON teams_tournaments(total_points,total_scored,total_missed,total_games);

-- 10-comments------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  post_id INT UNSIGNED NOT NULL,
  comment_text TEXT,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES posts(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 11----------------------------------------------------------------------------------------------------------------


















