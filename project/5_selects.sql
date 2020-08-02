-- Списки турниров с участниками------------------------------------------------------------------------
SELECT  
  teams.team_name AS team,
  teams_tournaments.tournament_id,
  tournaments.tournaments_name,
  tournaments.season 
FROM teams_tournaments 
  JOIN teams ON teams_tournaments.team_id = teams.id
  JOIN tournaments ON teams_tournaments.tournament_id = tournaments.id 
WHERE tournaments.id = 2; -- 1 Футбол Премьер Лига, 2 Футбол ФНЛ, 3 Баскетбол Единая Лига ВТБ 


-- Состав команды Х-------------------------------------------------------------------------
SELECT 
  players.f_l_name,
  JSON_EXTRACT(players.params, '$.position') AS amplua,
  teams.team_name,
  teams.team_city 
FROM players 
  JOIN teams ON players.team_id = teams.id 
WHERE team_id = 1 -- команда Х
ORDER BY amplua;

-- Турнирная таблица------------------------------------------------------------------------
SELECT 
  teams_tournaments.team_id,
  teams.team_name,
  teams_tournaments.total_points,
  teams_tournaments.total_scored,
  teams_tournaments.total_missed,
  teams_tournaments.total_games 
FROM teams_tournaments
JOIN teams ON teams_tournaments.team_id = teams.id
WHERE teams_tournaments.tournament_id = 1
ORDER BY teams_tournaments.total_points DESC;

-- Выод списка последних статей на главную страницу------------------------------------------
EXPLAIN SELECT theme, media_id, body, user_id, created_at FROM posts ORDER BY posts.id DESC LIMIT 5;


