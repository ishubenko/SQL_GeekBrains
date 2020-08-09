DELIMITER $$
CREATE TRIGGER new_game AFTER INSERT ON games
  FOR EACH ROW
    BEGIN 
	  DECLARE var_team_1 INT(50);
	  DECLARE var_team_2 INT(50);
 	  DECLARE points_team1 INT(50);
 	  DECLARE points_team2 INT(50);
 	  DECLARE score_team1 INT(50);
 	  DECLARE score_team2 INT(50);
 	  DECLARE missed_team1 INT(50);
 	  DECLARE missed_team2 INT(50);
 	  DECLARE tourn_id INT(50);
 	    
 	    SELECT games.tournament_id, games.team_1_id, games.team_2_id 
 	    INTO tourn_id, var_team_1, var_team_2 
 	    FROM games 
 	    ORDER BY games.id DESC LIMIT 1;
 	    -- ------------------------
        SELECT 
          JSON_EXTRACT(games.events, '$.points_1'),
          JSON_EXTRACT(games.events, '$.score_1'),
          JSON_EXTRACT(games.events, '$.score_2')
        INTO points_team1, score_team1, missed_team1
        FROM games 
        ORDER BY games.id DESC LIMIT 1;
       
        UPDATE teams_tournaments 
        SET 
          total_points = (total_points + points_team1),
          total_scored = (total_scored + score_team1),
          total_missed = (total_missed + missed_team1),
          total_games = (total_games + 1)
        WHERE teams_tournaments.team_id = var_team_1 AND teams_tournaments.tournament_id = tourn_id;
        -- -------------------------
        SELECT 
          JSON_EXTRACT(games.events, '$.points_2'),
          JSON_EXTRACT(games.events, '$.score_2'),
          JSON_EXTRACT(games.events, '$.score_1')
        INTO points_team2, score_team2, missed_team2
        FROM games 
        ORDER BY games.id DESC LIMIT 1;
       
        UPDATE teams_tournaments 
        SET 
          total_points = (total_points + points_team2),
          total_scored = (total_scored + score_team2),
          total_missed = (total_missed + missed_team2),
          total_games = (total_games + 1)
        WHERE teams_tournaments.team_id = var_team_2 AND teams_tournaments.tournament_id = tourn_id;
       
    END $$
DELIMITER;
