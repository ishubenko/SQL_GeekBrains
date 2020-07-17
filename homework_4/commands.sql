SELECT * FROM users;
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at >updated_at; 

SELECT * FROM profiles;
UPDATE profiles SET updated_at = CURRENT_TIMESTAMP WHERE created_at >updated_at; 

SELECT FLOOR(RAND() * 100) + 1;

SELECT * FROM communities;
UPDATE communities SET updated_at = CURRENT_TIMESTAMP WHERE created_at >updated_at;

SELECT * FROM communities_users;

SELECT * FROM friendship_statuses ORDER BY id DESC;
ALTER TABLE friendship_statuses ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE friendship_statuses ADD COLUMN updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

SELECT * FROM messages;
UPDATE messages SET updated_at = CURRENT_TIMESTAMP WHERE created_at >updated_at;

DESC media;
SELECT * FROM media;
SELECT * FROM media_types ORDER BY id;
DELETE FROM media_types WHERE name = 'post';
SELECT * FROM media LIMIT 10;
UPDATE media SET user_id = FLOOR(1 + RAND() * 100);
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));
INSERT INTO extensions VALUES ('jpeg'), ('mpeg'), ('avi'), ('png'), ('gif');
SELECT * FROM extensions;
UPDATE media SET filename = CONCAT( 
  'https://dropbox.com/vk/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1));
UPDATE media SET size = FLOOR(RAND() * 10000000 + 10000) WHERE size < 1000;

UPDATE media SET metadata = CONCAT ('{"owner":"',
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE users.id = media.user_id ),
  '"}');
 SELECT * FROM media LIMIT 10;
DESC media;
UPDATE media SET media_type_id = FLOOR( 1 + RAND() * 3);

DESC friendships;
ALTER TABLE friendships DROP COLUMN requested_at;
SELECT * FROM friendships;
UPDATE friendships SET updated_at = CURRENT_TIMESTAMP()  WHERE created_at > updated_at; 
UPDATE friendships SET created_at = confirmed_at WHERE created_at > confirmed_at; 

UPDATE friendships SET status_id = FLOOR(1 + RAND() * 3);
SELECT * FROM friendship_statuses;

TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES ('requested'), ('confirmed'), ('rejected');



