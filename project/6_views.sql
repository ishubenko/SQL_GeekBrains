-- Представления для запросов из приложения по отображению матча-------------------------
CREATE OR REPLACE VIEW team_home AS 
  SELECT 
    teams.name AS team_home_name,
    JSON_EXTRACT(games.events, '$.score_1') AS score_1
  FROM games
  JOIN teams ON team_1_id = teams.id 
  WHERE games.id = 3; -- Уникальный ID матча
CREATE OR REPLACE VIEW team_away AS 
  SELECT 
    JSON_EXTRACT(games.events, '$.score_2') AS score_2,
    teams.name AS team_away_name
  FROM games
  JOIN teams ON team_2_id = teams.id 
  WHERE games.id = 3; -- Уникальный ID матча
 
SELECT team_home_name, score_1, score_2, team_away_name FROM team_home JOIN team_away;
