-- +1. Составить общее текстовое описание БД и решаемых ею задач;
--  2. минимальное количество таблиц - 10; скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
-- +3. создать ERDiagram для БД;
--  4. скрипты наполнения БД данными;
--  5. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
--  6. представления (минимум 2);
--  7. хранимые процедуры / триггеры;

-- EXPLAIN SELECT id, season FROM tournaments ;

-- триггер на добавление матча----------------------------------------
DROP TRIGGER new_game;
SELECT * FROM games;
-- триггер на переход игрока из одной команды в другую----------------------------------------


-- test--------------------------------------------------------------------------------------

SELECT DISTINCT
  teams.team_name, 
  SUM(JSON_EXTRACT(games.events, '$.points_1')) OVER first_points AS po_1
FROM games
JOIN teams ON games.team_1_id = teams.id
  WINDOW
    first_points AS (PARTITION BY teams.id);

   
SELECT DISTINCT
  teams.team_name, 
  SUM(JSON_EXTRACT(games.events, '$.points_1')) OVER first_points AS po_1,
  SUM(JSON_EXTRACT(games.events, '$.points_2')) OVER second_points AS po_2
FROM teams
LEFT JOIN games ON games.team_1_id = teams.id
WHERE games.tournament_id = 1
  WINDOW
    first_points AS (PARTITION BY games.team_1_id),
    second_points AS (PARTITION BY games.team_2_id);


SELECT DISTINCT
  teams.team_name, 
  SUM(JSON_EXTRACT(games.events, '$.points_1')) AS po_1
FROM games
JOIN teams ON games.team_1_id = teams.id
JOIN (SELECT DISTINCT
  teams.team_name, 
  SUM(JSON_EXTRACT(games.events, '$.points_2')) AS po_2
FROM games
JOIN teams ON games.team_2_id = teams.id
WHERE games.tournament_id = 1) AS vtoroy
WHERE games.tournament_id = 1
GROUP BY teams.id; 
   
SELECT DISTINCT
  teams.team_name, 
  SUM(JSON_EXTRACT(games.events, '$.points_2')) AS po_2
FROM games
JOIN teams ON games.team_2_id = teams.id
WHERE games.tournament_id = 1
GROUP BY teams.id;


