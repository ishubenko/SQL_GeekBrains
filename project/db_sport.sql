DROP TABLE IF EXISTS `players`;
CREATE TABLE `communities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор спортсмена',
  'team_id' int unsigned NOT NULL,
  `f_l_name` varchar(150) NOT NULL COMMENT 'Фамилия Имя',
  `birthday_at` date DEFAULT NULL,
  'params' JSON COMMENT 'Данные игррока: позиция(нападающий/защитник), рост, вес',

  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  FOREIGN KEY (team_id) REFERENCES teams (id),
) COMMENT='Спортсмены';

INSERT INTO players VALUES(1,1,'Иванов Петр','1985-04-24','{\"position\": \"defender\",\"height\": \"178\",\"weight\": \"75\"}');
INSERT INTO players VALUES(2,1,'Сидоров Николай','1987-06-18','{\"position\": \"goalkeeper\",\"height\": \"183\",\"weight\": \"80\"}');




-- -----------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams` (
  `id` int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор команды',
  `f_l_name` varchar(150) NOT NULL COMMENT 'название команды',

  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
) COMMENT = 'команды';


-- -----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `tournaments`;
CREATE TABLE `tournaments` (
  'id' int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор турнира',
  'type_of_sport' varchar(150) NOT NULL COMMENT 'вид спорта',
  'tournaments_name' varchar(150) NOT NULL COMMENT 'название турнира',
  'season' varchar(150) NOT NULL COMMENT 'год проведения турнира',

  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);


-- -----------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  'id' int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор события/матча',
  'events_date_time' DATETIME NOT NULL COMMENT 'время матча/события',
  'place' VARCHAR(100) COMMENT 'место(город или стадион) проведения матча',
  'tournament_id' int unsigned NOT NULL REFERENCES FOREIGN KEY,
  'team_1_id' int unsigned NOT NULL REFERENCES FOREIGN KEY,
  'team_2_id' int unsigned NOT NULL REFERENCES FOREIGN KEY,
  'score_1' int unsigned NOT NULL,
  'score_2' int unsigned NOT NULL,
  'points_1' int unsigned NOT NULL,
  'points_2' int unsigned NOT NULL,
  'goals' JSON COMMENT 'очки/голы внутри матча',

  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

);

-- -----------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `transfers`;
CREATE TABLE `transfers` (
  'id' int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор трансфера',
  'player_id' INT NOT NULL,
  'team_from_id' INT NOT NULL,
  'team_to_id' INT NOT NULL,
  'trnf_date' DATE NOT NULL,

  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);


-- -----------------------------------------------------------------------------------------------------------------
-- 'news_posts'




-- -----------------------------------------------------------------------------------------------------------------





















