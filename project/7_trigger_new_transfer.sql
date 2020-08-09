DELIMITER $$
CREATE TRIGGER new_transfer AFTER INSERT ON transfers
  FOR EACH ROW
    BEGIN 
	  DECLARE transfered_player INT(50);  
	  DECLARE new_team_of_player INT(50);
	    SELECT team_to_id, player_id INTO new_team_of_player, transfered_player FROM transfers ORDER BY transfers.id DESC LIMIT 1;
	    UPDATE players SET players.team_id = new_team_of_player WHERE transfered_player = players.id; 
    END $$
DELIMITER;
