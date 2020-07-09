ALTER TABLE profiles 
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
ALTER TABLE profiles 
  ADD FOREIGN KEY (photo_id) REFERENCES media(id);

      
SELECT * FROM profiles;
DESC profiles;
DESC media ;
SELECT * FROM media;
SELECT FLOOR(RAND() * 100) + 1;
UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 100);

ALTER TABLE communities_users 
  ADD CONSTRAINT communities_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
     ALTER TABLE communities_users 
  ADD CONSTRAINT communities_users_communities_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE NO ACTION;

     
ALTER TABLE media 
  ADD CONSTRAINT media_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE NO ACTION;
     
ALTER TABLE messages 
  ADD CONSTRAINT messages_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id);
   
ALTER TABLE friendships 
  ADD CONSTRAINT friendships_status_fk
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
   
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED,
  community_id INT UNSIGNED,
  head varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  body text COLLATE utf8_unicode_ci NOT NULL,
  media_id int(10) unsigned DEFAULT NULL,
  is_public tinyint(1) DEFAULT 1,
  is_archived tinyint(1) DEFAULT 0,
  views_counter int(10) unsigned DEFAULT 0,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (community_id) REFERENCES communities(id),
  FOREIGN KEY (media_id) REFERENCES media(id)
);

CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DESC posts ;
DESC likes;
ALTER  TABLE posts MODIFY id INT UNSIGNED NOT NULL AUTO_INCREMENT ;



INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (1, 48, 84, 2, '1979-12-28 23:32:10');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (2, 9, 16, 2, '1983-02-05 23:41:51');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (3, 42, 52, 2, '1983-06-25 16:07:55');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (4, 75, 83, 1, '1976-11-30 07:36:57');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (5, 87, 70, 1, '1999-06-11 15:41:53');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (6, 98, 91, 1, '2006-10-03 10:17:35');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (7, 21, 60, 2, '1989-12-10 01:21:18');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (8, 84, 33, 1, '2015-10-22 13:40:11');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (9, 65, 19, 2, '1985-03-29 20:20:35');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (10, 39, 49, 1, '2000-02-23 04:26:04');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (11, 4, 69, 3, '2009-01-23 13:55:03');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (12, 57, 10, 3, '1973-02-13 22:52:03');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (13, 64, 43, 1, '2008-04-29 02:45:18');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (14, 48, 17, 3, '2017-02-04 00:49:17');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (15, 97, 78, 3, '1998-02-02 22:45:10');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (16, 33, 17, 3, '1971-04-19 04:10:19');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (17, 28, 84, 3, '1990-07-16 07:31:28');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (18, 27, 28, 3, '1999-03-01 12:10:41');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (19, 40, 83, 3, '1971-10-29 22:06:00');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (20, 41, 16, 1, '1975-04-17 08:23:41');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (21, 6, 89, 3, '1984-09-28 16:50:31');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (22, 92, 11, 1, '2010-12-30 19:12:46');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (23, 93, 8, 2, '2015-11-01 14:47:32');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (24, 39, 20, 3, '2002-10-12 19:00:35');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (25, 48, 53, 2, '1999-02-22 07:07:55');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (26, 16, 65, 1, '1976-12-20 11:49:24');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (27, 75, 68, 3, '1995-02-22 20:18:15');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (28, 17, 60, 1, '2008-04-08 20:11:45');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (29, 1, 64, 3, '2018-05-16 23:43:27');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (30, 20, 5, 3, '1973-04-27 11:23:51');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (31, 33, 39, 3, '2008-02-01 03:42:24');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (32, 56, 44, 1, '1992-03-24 12:37:27');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (33, 76, 78, 1, '1988-09-28 20:28:49');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (34, 93, 25, 3, '2006-01-17 02:25:40');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (35, 27, 92, 1, '2018-05-22 08:51:36');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (36, 1, 87, 2, '1989-08-17 16:43:09');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (37, 3, 10, 1, '2000-10-30 03:06:06');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (38, 5, 4, 1, '2008-11-23 16:16:28');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (39, 57, 28, 2, '1979-12-31 01:43:44');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (40, 84, 52, 2, '1990-10-01 07:53:49');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (41, 68, 34, 2, '1991-02-18 21:21:13');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (42, 75, 32, 2, '1973-03-26 21:14:55');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (43, 29, 21, 2, '2000-02-02 13:41:54');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (44, 38, 8, 3, '1975-04-08 20:20:22');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (45, 17, 20, 3, '1983-09-25 20:08:27');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (46, 49, 88, 3, '1998-08-14 09:38:37');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (47, 1, 88, 3, '2002-01-10 03:01:03');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (48, 68, 33, 2, '2003-05-03 04:50:55');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (49, 61, 45, 3, '2012-03-29 21:05:20');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (50, 98, 22, 1, '1984-03-16 19:55:00');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (51, 16, 73, 3, '2004-03-12 12:24:23');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (52, 24, 78, 2, '2017-12-22 17:13:50');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (53, 80, 6, 1, '1996-10-11 18:52:48');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (54, 1, 2, 1, '2007-03-31 21:54:44');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (55, 61, 54, 1, '1992-07-28 05:58:05');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (56, 63, 100, 1, '2000-12-10 16:12:30');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (57, 69, 92, 1, '1994-06-21 01:25:41');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (58, 61, 93, 2, '2006-10-02 22:55:10');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (59, 8, 10, 2, '1996-05-26 03:05:17');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (60, 84, 18, 2, '1987-10-28 03:20:13');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (61, 23, 20, 3, '1988-03-24 12:18:52');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (62, 98, 89, 1, '1975-05-13 04:32:40');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (63, 5, 14, 2, '2017-05-15 12:27:39');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (64, 85, 32, 1, '1977-09-27 11:26:44');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (65, 15, 43, 1, '1985-01-28 20:15:07');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (66, 24, 27, 1, '1979-12-07 03:22:27');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (67, 24, 74, 3, '1998-07-08 13:18:50');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (68, 18, 41, 1, '1988-04-01 23:44:08');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (69, 57, 69, 3, '1983-10-18 00:16:00');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (70, 57, 4, 1, '1985-12-17 22:18:29');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (71, 76, 82, 1, '2000-02-24 12:00:31');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (72, 58, 52, 3, '2018-11-03 17:38:06');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (73, 9, 80, 2, '1996-03-25 15:15:04');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (74, 63, 57, 1, '1998-02-05 12:38:42');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (75, 71, 83, 1, '2014-05-26 10:00:25');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (76, 62, 61, 3, '1980-11-27 06:44:30');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (77, 41, 83, 3, '2012-02-07 13:52:59');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (78, 40, 8, 2, '2001-07-27 13:52:30');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (79, 72, 92, 3, '1984-12-21 01:10:14');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (80, 100, 8, 1, '1973-02-18 08:32:51');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (81, 68, 55, 3, '1985-09-14 15:19:07');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (82, 42, 42, 2, '1993-10-14 13:26:28');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (83, 57, 35, 1, '1974-05-03 23:55:36');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (84, 96, 27, 2, '1990-06-10 18:44:09');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (85, 99, 4, 2, '1982-01-11 20:56:55');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (86, 55, 88, 2, '1997-05-13 20:31:01');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (87, 71, 73, 3, '1979-04-20 21:56:46');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (88, 23, 89, 1, '1971-10-07 09:11:09');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (89, 42, 67, 2, '2010-07-17 05:07:48');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (90, 24, 53, 3, '1981-10-13 22:24:22');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (91, 50, 9, 2, '2008-09-05 21:38:36');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (92, 74, 9, 2, '1981-04-06 07:42:43');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (93, 52, 46, 1, '1970-03-26 03:31:39');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (94, 38, 19, 1, '1974-10-30 12:05:52');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (95, 22, 50, 2, '1995-01-02 00:55:13');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (96, 44, 33, 1, '1973-10-05 22:08:30');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (97, 89, 14, 1, '1989-04-12 23:56:45');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (98, 49, 75, 3, '1980-08-05 18:14:38');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (99, 99, 82, 2, '2006-06-10 01:43:27');
INSERT INTO `likes` (`id`, `user_id`, `target_id`, `target_type_id`, `created_at`) VALUES (100, 47, 65, 1, '1998-04-06 01:16:01');

INSERT INTO `posts` VALUES 
('1','96','54','Possimus consequuntur officiis est omnis exercitationem id.','Alice replied very politely, feeling quite pleased to find her way out. \'I shall do nothing of the Queen\'s voice in the pool a little way out of breath, and till the eyes appeared, and then turned.','78','1','0','38','2006-07-14 06:22:12','1982-02-20 12:51:57'),
('2','13','58','Nobis asperiores qui autem libero ut eum laudantium.','So they went on \'And how did you do either!\' And the moral of THAT is--\"Take care of the miserable Mock Turtle. \'Certainly not!\' said Alice as she could. \'The Dormouse is asleep again,\' said the.','55','1','0','379','2006-03-11 22:21:57','2002-11-17 09:08:40'),
('3','21','72','Debitis exercitationem est libero corrupti iusto et.','Alice, \'it\'s very easy to take out of a procession,\' thought she, \'what would become of you? I gave her one, they gave him two, You gave us three or more; They all made of solid glass; there was.','86','1','0','251','1997-06-29 01:37:38','2011-02-18 05:34:08'),
('4','49','34','Officiis nesciunt laudantium eligendi quo.','The Knave did so, very carefully, remarking, \'I really must be what he did with the next witness.\' And he added looking angrily at the other was sitting between them, fast asleep, and the little.','85','0','0','105','2013-10-20 11:45:02','2002-10-01 08:15:35'),
('5','50','85','Vero aut quae dolores et aut.','And certainly there was a long hookah, and taking not the smallest idea how confusing it is almost certain to disagree with you, sooner or later. However, this bottle does. I do so like that curious.','84','0','0','214','1994-02-26 11:27:33','1973-10-12 10:18:56'),
('6','57','84','Mollitia quaerat aut debitis.','HE taught us Drawling, Stretching, and Fainting in Coils.\' \'What was that?\' inquired Alice. \'Reeling and Writhing, of course, I meant,\' the King was the cat.) \'I hope they\'ll remember her saucer of.','100','1','0','316','2014-06-22 02:14:04','1994-12-07 16:24:55'),
('7','55','31','Sit optio rerum non sit est accusantium.','Alice whispered, \'that it\'s done by everybody minding their own business,\' the Duchess said to herself that perhaps it was written to nobody, which isn\'t usual, you know.\' \'And what an ignorant.','40','1','0','142','1988-06-01 20:36:11','2013-04-24 14:50:01'),
('8','45','38','Omnis sunt ea corrupti ab molestiae est.','Alice. \'I don\'t believe it,\' said Alice, (she had grown so large a house, that she knew that were of the table, half hoping she might as well wait, as she could. \'The Dormouse is asleep again,\' said.','23','1','1','114','2013-11-14 04:04:30','2006-09-11 23:41:57'),
('9','43','41','Quis dolor odit non voluptas minima.','Mouse, who seemed ready to make it stop. \'Well, I\'d hardly finished the guinea-pigs!\' thought Alice. One of the table, half hoping that they had at the mushroom for a little nervous about this; \'for.','2','1','1','182','1977-06-13 16:13:40','1982-09-29 09:13:05'),
('10','86','38','Tempore quo tenetur qui voluptatem odit.','However, the Multiplication Table doesn\'t signify: let\'s try Geography. London is the reason so many different sizes in a great hurry, muttering to himself in an encouraging opening for a minute or.','97','0','0','250','1998-04-29 04:00:22','1995-09-15 02:26:26'),
('11','25','38','Incidunt et ad iste et deleniti qui dicta.','Gryphon, and the happy summer days. THE.','1','1','0','134','1996-01-16 21:09:41','1992-10-26 01:04:54'),
('12','84','56','Rerum minus dolorum vitae animi ullam ipsa sint.','Lory. Alice replied eagerly, for she felt that it made Alice quite hungry to look through into the open air. \'IF I don\'t like it, yer honour, at all, as the Rabbit, and had just succeeded in curving.','89','1','0','261','1972-01-02 19:24:07','1982-04-10 06:44:21'),
('13','68','65','Vitae iusto corrupti unde eos.','I to get out again. That\'s all.\' \'Thank you,\' said the Mock Turtle. \'Hold your tongue!\' added the Dormouse, after thinking a minute or two, and the three were all shaped like the three gardeners who.','72','1','1','65','2000-11-04 20:23:49','1995-12-31 14:17:29'),
('14','75','98','In facere dolorem vel quas.','I think you\'d better ask HER about it.\' \'She\'s in prison,\' the Queen of Hearts, who only bowed and smiled in reply. \'Please come back in their mouths--and they\'re all over with diamonds, and walked.','29','1','0','9','2009-04-18 11:46:03','1984-12-07 21:45:48'),
('15','62','3','Blanditiis praesentium ut modi nihil nemo in.','I used--and I don\'t remember where.\' \'Well, it must be really offended. \'We won\'t talk about trouble!\' said the Hatter. \'Nor I,\' said the Dormouse; \'VERY ill.\' Alice tried to say when I got up very.','1','0','1','134','1995-01-07 18:06:00','1989-04-14 15:37:11'),
('16','65','40','Inventore non molestias et rerum.','I think.\' And she began again. \'I should have croqueted the Queen\'s ears--\' the Rabbit in a shrill, passionate voice. \'Would YOU like cats if you don\'t know the meaning of it appeared. \'I don\'t.','66','1','1','343','2001-09-16 22:29:15','1994-05-14 04:47:49'),
('17','88','48','Atque dolores et ipsam veritatis.','Don\'t let me hear the name \'Alice!\' CHAPTER XII. Alice\'s Evidence \'Here!\' cried Alice, quite forgetting that she was now more than Alice could think of any good reason, and as it was in the.','52','1','0','301','1991-05-07 08:30:17','2002-08-08 11:34:35'),
('18','93','67','Consequatur voluptatem error laudantium sed.','MYSELF, I\'m afraid, sir\' said Alice, a little sharp bark just over her head made her draw back in a very respectful tone, but frowning and making quite a large rabbit-hole under the hedge. In.','12','0','1','156','2002-01-29 18:19:13','2017-02-04 02:52:19'),
('19','66','43','Distinctio dolor non tempora.','I can\'t get out of its little eyes, but it makes me grow larger, I can reach the key; and if it had fallen into a large arm-chair at one end of the ground.\' So she began: \'O Mouse, do you know about.','22','1','1','333','2011-04-04 06:20:19','1989-08-20 08:47:15'),
('20','93','90','Rerum voluptatem maxime maxime.','Alice dear!\' said her sister; \'Why, what are YOUR shoes done with?\' said the Hatter. \'He won\'t stand beating. Now, if you hold it too long; and that if you could draw treacle out of the lefthand bit.','10','0','0','12','2013-11-09 08:31:28','2019-10-20 15:53:46'),
('21','84','94','Omnis aut dicta quasi consectetur rerum et.','As she said these words her foot slipped, and in his turn; and both the hedgehogs were out of sight. Alice remained looking thoughtfully at the stick, running a very humble tone, going down on the.','99','1','1','53','2002-08-02 00:00:38','1994-11-10 21:39:53'),
('22','29','99','Qui est non earum ab velit.','They were just beginning to think about it, so she set to work at once in a moment to think that will be the use of repeating all that stuff,\' the Mock Turtle\'s Story \'You can\'t think how glad I am.','15','0','0','116','1990-11-19 19:18:33','2004-09-24 22:03:11'),
('23','17','95','Sint nostrum autem ut atque nemo nisi nesciunt omnis.','William\'s conduct at first she would have called him Tortoise because he was going to remark myself.\' \'Have you guessed the riddle yet?\' the Hatter continued, \'in this way:-- \"Up above the world she.','61','0','0','140','2013-02-12 00:50:26','1974-09-10 05:15:18'),
('24','79','10','Magni qui perspiciatis sapiente.','ME,\' but nevertheless she uncorked it and put it into his plate. Alice did not at all for any lesson-books!\' And so it was the Cat in a louder tone. \'ARE you to set about it; and while she.','34','1','1','212','1982-04-22 05:33:55','1972-11-22 11:29:50'),
('25','95','60','Minima optio necessitatibus beatae maiores quae unde.','MINE.\' The Queen smiled and passed on. \'Who ARE you talking to?\' said one of the sort. Next came the guests, mostly Kings and Queens, and among them Alice recognised the White Rabbit was no more of.','76','0','0','50','2003-03-21 09:51:04','2008-02-18 00:00:15'),
('26','2','45','Rerum labore et alias ducimus amet aut.','I\'m pleased, and wag my tail when I\'m angry. Therefore I\'m mad.\' \'I call it purring, not growling,\' said Alice. \'What sort of knot, and then keep tight hold of it; and while she was going to say,\'.','69','1','1','362','1990-09-27 06:04:24','2000-02-15 01:29:00'),
('27','87','75','Est tempore quam veritatis illum quasi.','Alice as it turned round and look up in a tone of great dismay, and began whistling. \'Oh, there\'s no use in saying anything more till the eyes appeared, and then she looked down, was an immense.','34','1','1','315','2011-06-05 03:30:47','1991-01-30 16:11:49'),
('28','37','62','Non et veritatis illum quam.','As soon as it didn\'t much matter which way it was in the air, I\'m afraid, sir\' said Alice, in a melancholy way, being quite unable to move. She soon got it out to sea. So they got thrown out to be.','28','1','1','185','2013-04-19 05:20:03','1981-10-31 12:21:30'),
('29','72','10','Saepe dolore et ratione dolorem.','Half-past one, time for dinner!\' (\'I only wish people knew that: then they wouldn\'t be so easily offended, you know!\' The Mouse did not quite like the look of things at all, at all!\' \'Do as I tell.','66','0','0','262','2014-01-08 02:37:32','2019-09-18 01:33:07'),
('30','11','28','Aliquid dicta omnis nostrum sunt.','Alice caught the flamingo and brought it back, the fight was over, and both the hedgehogs were out of the gloves, and she told her sister, as well go back, and see that she was looking down with.','28','1','1','238','1978-08-27 09:23:37','2011-11-13 09:46:25'),
('31','5','96','Aut dolorum omnis magnam et.','Alice was more than nine feet high, and her eyes to see you any more!\' And here poor Alice began to repeat it, but her voice sounded hoarse and strange, and the Dormouse began in a natural way. \'I.','58','1','0','91','1972-03-07 09:45:46','2007-04-15 15:56:41'),
('32','87','72','Nesciunt est velit nisi corporis eum et.','Alice caught the baby at her for a conversation. Alice felt a little way out of it, and behind it, it occurred to her head, and she put her hand on the look-out for serpents night and day! Why, I do.','54','0','0','131','2009-03-17 01:31:51','2014-10-21 00:52:43'),
('33','44','34','Delectus nesciunt eum et in sapiente reprehenderit.','Majesty!\' the Duchess to play with, and oh! ever so many different sizes in a loud, indignant voice, but she remembered that she knew she had a large pigeon had flown into her face, and large eyes.','19','1','0','35','1997-01-22 09:05:13','2008-05-26 01:42:12'),
('34','28','85','Cupiditate quas est sequi similique omnis.','CHAPTER X. The Lobster Quadrille is!\' \'No, indeed,\' said Alice. \'Nothing WHATEVER?\' persisted the King. \'It began with the next witness!\' said the March Hare: she thought it must be the right.','24','1','1','13','2017-05-02 01:02:04','2010-05-10 14:38:56'),
('35','28','52','Necessitatibus in magnam optio similique dolor.','Mercia and Northumbria, declared for him: and even Stigand, the patriotic archbishop of Canterbury, found it so VERY tired of swimming about here, O Mouse!\' (Alice thought this a good way off,.','35','0','0','124','2004-01-21 02:50:34','1994-01-05 00:54:22'),
('36','91','90','Laudantium dolorem voluptatem consequatur corporis veritatis temporibus.','Queen was close behind us, and he\'s treading on my tail. See how eagerly the lobsters to the three gardeners, but she felt certain it must make me larger, it must be a lesson to you to get out.','68','1','1','183','1975-08-17 01:02:03','1984-07-11 13:49:05'),
('37','57','86','Provident ut rem commodi ducimus illo.','I\'m mad?\' said Alice. \'Why, you don\'t explain it is almost certain to disagree with you, sooner or later. However, this bottle does. I do hope it\'ll make me grow large again, for this curious child.','17','0','1','38','1973-08-20 17:10:26','1988-10-08 18:56:18'),
('38','61','20','Quia doloremque a ut officiis odit.','Why, there\'s hardly room for her. \'I can see you\'re trying to fix on one, the cook was leaning over the jury-box with the strange creatures of her head down to them, and just as I tell you!\' But she.','25','1','0','55','1992-03-28 13:46:29','2016-04-03 03:52:02'),
('39','65','31','Iste enim est dolorum est ut quia atque culpa.','It quite makes my forehead ache!\' Alice watched the White Rabbit as he found it so yet,\' said the last concert!\' on which the words did not quite know what to do, and perhaps as this is May it won\'t.','40','0','0','365','1985-05-14 21:32:18','1997-11-05 18:34:14'),
('40','68','36','Voluptatem est veritatis laborum.','I WAS when I got up and down looking for the end of trials, \"There was some attempts at applause, which was full of tears, until there was mouth enough for it was impossible to say it any longer.','54','0','0','218','2019-11-23 19:07:26','2002-07-03 11:00:30'),
('41','28','98','Nulla repudiandae accusantium adipisci omnis laboriosam labore.','I give you fair warning,\' shouted the Queen. \'Can you play croquet?\' The soldiers were silent, and looked along the sea-shore--\' \'Two lines!\' cried the Mock Turtle, capering wildly about. \'Change.','100','1','0','162','1973-03-10 02:24:36','1982-10-20 18:35:09'),
('42','4','76','Placeat quia non animi sed repellat.','Conqueror, whose cause was favoured by the English, who wanted leaders, and had just begun to repeat it, when a cry of \'The trial\'s beginning!\' was heard in the distance would take the roof.','34','0','0','230','2016-04-18 16:30:44','1979-08-05 02:50:08'),
('43','78','54','Ut sit voluptatibus veritatis quae blanditiis ut et.','King, and he went on, \'if you only walk long enough.\' Alice felt that this could not answer without a moment\'s pause. The only things in the distance, sitting sad and lonely on a summer day: The.','22','1','0','62','1990-05-19 06:51:34','2017-04-26 07:23:27'),
('44','90','40','Accusamus voluptates voluptatem laboriosam quia explicabo ab libero.','No, it\'ll never do to come upon them THIS size: why, I should be free of them say, \'Look out now, Five! Don\'t go splashing paint over me like that!\' But she did not much larger than a real nose;.','52','0','0','121','1985-11-15 14:53:02','1988-06-18 10:27:48'),
('45','79','33','Exercitationem facere voluptates vel quia officia corrupti rerum.','Yet you turned a corner, \'Oh my ears and whiskers, how late it\'s getting!\' She was looking up into a small passage, not much like keeping so close to her: first, because the Duchess said in an.','27','1','1','89','1977-01-01 18:08:57','2009-12-05 20:40:25'),
('46','53','4','Molestiae dolor esse vero ipsa quia.','Alice, that she had but to get to,\' said the Duchess, who seemed ready to talk about her repeating \'YOU ARE OLD, FATHER WILLIAM,\' to the voice of thunder, and people began running about in the last.','8','1','0','312','1989-04-07 08:53:42','1985-06-29 05:06:44'),
('47','14','65','Est ea quam qui in qui est.','The Gryphon sat up and straightening itself out again, so violently, that she looked up and down looking for eggs, I know THAT well enough; and what does it matter to me whether you\'re nervous or.','38','1','0','192','1980-08-30 13:51:47','1996-06-18 10:42:17'),
('48','87','28','Neque saepe vel officia.','I should understand that better,\' Alice said very humbly; \'I won\'t indeed!\' said the Duchess, \'and that\'s why. Pig!\' She said the Cat. \'Do you mean that you have to beat time when I grow up, I\'ll.','16','0','0','60','2015-07-24 19:20:51','1979-01-16 02:35:20'),
('49','76','60','Libero corporis aperiam odio est.','Alice quite jumped; but she knew that were of the tail, and ending with the day and night! You see the Mock Turtle recovered his voice, and, with tears running down his face, as long as it could go,.','12','0','0','319','1975-02-27 21:46:13','2004-02-20 18:38:47'),
('50','19','74','Similique est recusandae quos perferendis non.','Mock Turtle. Alice was not a bit hurt, and she felt certain it must be a lesson to you never had fits, my dear, YOU must cross-examine THIS witness.\' \'Well, if I fell off the mushroom, and raised.','96','1','1','316','1972-02-17 15:36:12','1978-03-12 20:45:22'),
('51','67','16','Quis rerum eum quaerat.','Some of the March Hare said in a sulky tone, as it can\'t possibly make me smaller, I can reach the key; and if it please your Majesty,\' he began. \'You\'re a very curious to know what a long tail,.','69','0','1','250','1982-07-07 23:58:46','1985-03-04 06:44:47'),
('52','32','74','Nostrum aut excepturi doloribus sint est error eum voluptatem.','Come on!\' So they began moving about again, and made another rush at Alice the moment they saw the Mock Turtle to the game, the Queen added to one of the Shark, But, when the White Rabbit. She was.','60','0','1','344','1985-10-24 08:17:35','1998-10-27 22:45:35'),
('53','25','50','Voluptatem quasi repellendus dolore consequuntur.','Alice looked at poor Alice, \'it would have this cat removed!\' The Queen had only one way up as the jury had a wink of sleep these three weeks!\' \'I\'m very sorry you\'ve been annoyed,\' said Alice, in a.','41','0','1','249','1999-12-19 20:29:16','2004-03-26 03:20:11'),
('54','49','13','Et natus et officiis voluptas.','Mock Turtle would be the use of this was not easy to take out of sight; and an Eaglet, and several other curious creatures. Alice led the way, was the first minute or two to think that proved it at.','78','1','0','127','2018-05-17 10:53:19','2011-07-12 01:55:02'),
('55','26','65','Architecto voluptas odit impedit recusandae et quam deleniti possimus.','The Queen turned angrily away from him, and very neatly and simply arranged; the only one who got any advantage from the time they had a head could be NO mistake about it: it was a body to cut it.','11','1','0','212','1993-11-24 09:42:27','1978-08-20 16:15:07'),
('56','82','71','Quia voluptatum deserunt itaque.','Very soon the Rabbit coming to look at the mushroom (she had kept a piece of it altogether; but after a few yards off. The Cat seemed to Alice to herself. At this the whole party at once set to work.','5','1','1','51','1972-09-18 16:38:24','1998-06-03 00:38:54'),
('57','15','32','Aut eveniet rerum molestiae cupiditate delectus et dolor.','Puss,\' she began, rather timidly, as she had read about them in books, and she could remember about ravens and writing-desks, which wasn\'t much. The Hatter was the BEST butter, you know.\' \'Who is it.','24','0','1','319','2000-03-18 17:31:51','1997-06-12 00:04:59'),
('58','21','67','Est dignissimos nobis perferendis magnam perspiciatis atque ut.','I never heard it before,\' said Alice,) and round goes the clock in a whisper.) \'That would be offended again. \'Mine is a long hookah, and taking not the same, the next verse.\' \'But about his toes?\'.','39','1','0','286','2007-04-25 13:21:37','1994-08-31 08:06:27'),
('59','36','59','Voluptates voluptatum consequuntur nemo quidem quae.','March Hare. \'Sixteenth,\' added the Hatter, \'when the Queen had ordered. They very soon had to do it! Oh dear! I wish I hadn\'t begun my tea--not above a week or so--and what with the lobsters to the.','24','1','0','218','2010-06-27 04:36:23','2019-04-19 06:35:46'),
('60','25','29','Eos facilis unde dolorum veritatis ut.','New Zealand or Australia?\' (and she tried her best to climb up one of the Lobster Quadrille?\' the Gryphon only answered \'Come on!\' and ran the faster, while more and more sounds of broken glass..','3','1','1','12','2004-12-31 21:33:35','2013-02-13 09:53:54'),
('61','57','94','Corporis expedita beatae at iste.','Queen: so she went on, \'if you don\'t even know what to say it over) \'--yes, that\'s about the whiting!\' \'Oh, as to bring tears into her face, and large eyes full of soup. \'There\'s certainly too much.','94','0','1','266','2015-06-23 04:55:57','2010-11-29 21:51:04'),
('62','65','8','Sit dolor tempore sit molestiae et et.','But they HAVE their tails in their paws. \'And how many hours a day did you begin?\' The Hatter was out of breath, and said \'No, never\') \'--so you can find out the proper way of settling all.','90','0','0','164','2005-12-25 21:33:06','2007-01-01 08:19:42'),
('63','93','45','Odit consectetur qui magni est maxime et quasi.','Dodo replied very gravely. \'What else had you to offer it,\' said the White Rabbit, jumping up in her hands, wondering if anything would EVER happen in a ring, and begged the Mouse was bristling all.','81','0','1','290','1975-04-20 03:49:00','1978-10-26 17:25:34'),
('64','91','84','Quia amet aliquid sed mollitia et.','Magpie began wrapping itself up very carefully, with one eye; but to her very much confused, \'I don\'t believe it,\' said Alice, in a melancholy way, being quite unable to move. She soon got it out to.','79','0','1','94','1970-08-04 19:42:44','2009-08-12 22:39:43'),
('65','30','72','Magni qui velit voluptatem.','Alice angrily. \'It wasn\'t very civil of you to leave it behind?\' She said the Mock Turtle in a low voice. \'Not at first, the two creatures, who had got so close to them, and it\'ll sit up and leave.','84','1','0','286','1993-09-09 19:50:05','2009-10-11 12:20:29'),
('66','99','19','Dolorum necessitatibus rerum amet eveniet qui.','Alice \'without pictures or conversations?\' So she began: \'O Mouse, do you know I\'m mad?\' said Alice. \'Anything you like,\' said the Dormouse: \'not in that case I can listen all day about it!\' and he.','20','1','1','357','2016-03-10 13:55:06','2002-01-17 04:25:24'),
('67','24','24','Aut ab ex dolorem voluptatum nostrum.','However, this bottle was NOT marked \'poison,\' it is right?\' \'In my youth,\' said his father, \'I took to the jury, of course--\"I GAVE HER ONE, THEY GAVE HIM TWO--\" why, that must be really offended..','13','0','1','238','2015-04-14 23:23:23','2014-09-13 17:14:46'),
('68','23','78','Voluptatem doloremque molestiae debitis natus rerum.','Majesty means, of course,\' the Mock Turtle persisted. \'How COULD he turn them out of a good many little girls eat eggs quite as safe to stay in here any longer!\' She waited for some way of settling.','53','1','0','119','1994-11-29 19:36:18','1982-01-22 05:18:50'),
('69','60','44','Ea et amet ducimus et nulla ducimus tempore quae.','Queen. \'Sentence first--verdict afterwards.\' \'Stuff and nonsense!\' said Alice hastily; \'but I\'m not the smallest idea how to spell \'stupid,\' and that in some alarm. This time there could be.','82','0','0','300','1980-09-16 11:21:17','2001-10-25 11:52:17'),
('70','8','9','Sint ad sequi quas culpa.','Queen till she got up, and began to say \'Drink me,\' but the Hatter said, tossing his head sadly. \'Do I look like it?\' he said, turning to Alice. \'What sort of present!\' thought Alice. \'I don\'t know.','18','1','0','50','1989-09-08 02:06:07','2009-07-03 18:08:01'),
('71','17','38','Architecto alias ea vel eum dolorum atque.','Mock Turtle is.\' \'It\'s the oldest rule in the same thing, you know.\' \'Not at all,\' said Alice: \'allow me to him: She gave me a good deal: this fireplace is narrow, to be no sort of way, \'Do cats eat.','79','0','0','99','2012-08-21 05:39:40','2007-11-18 14:14:10'),
('72','94','64','Aut eveniet ab dignissimos in.','ALL RETURNED FROM HIM TO YOU,\"\' said Alice. \'Well, I shan\'t go, at any rate,\' said Alice: \'three inches is such a hurry that she wanted to send the hedgehog to, and, as they were filled with tears.','2','0','0','172','2004-09-05 00:02:36','2014-07-11 01:14:53'),
('73','44','94','Qui rerum quis consequuntur dolorem voluptatem aliquid neque.','THAT. Then again--\"BEFORE SHE HAD THIS FIT--\" you never even spoke to Time!\' \'Perhaps not,\' Alice replied in a louder tone. \'ARE you to death.\"\' \'You are old, Father William,\' the young man said,.','73','0','0','286','1994-03-30 15:48:03','1998-09-15 04:34:55'),
('74','70','80','Necessitatibus voluptatem labore quis.','Hatter hurriedly left the court, by the fire, licking her paws and washing her face--and she is of mine, the less there is of finding morals in things!\' Alice thought to herself. (Alice had been.','46','0','0','63','2009-02-03 16:46:37','1977-06-17 11:00:14'),
('75','76','15','Ex natus labore expedita.','She generally gave herself very good height indeed!\' said the King in a pleased tone. \'Pray don\'t trouble yourself to say it out to her usual height. It was so much already, that it was quite pale.','5','0','0','345','1971-01-26 16:10:10','1998-05-12 18:37:50'),
('76','67','36','Sit quaerat adipisci nobis cum amet explicabo praesentium quia.','The further off from England the nearer is to do such a subject! Our family always HATED cats: nasty, low, vulgar things! Don\'t let me hear the words:-- \'I speak severely to my boy, I beat him when.','76','0','0','36','1980-05-21 17:50:43','2020-06-19 20:31:03'),
('77','40','34','Earum voluptas totam cumque consequatur sit voluptatibus.','Hatter. He had been found and handed back to the Gryphon. \'Of course,\' the Mock Turtle had just begun to dream that she knew the right house, because the chimneys were shaped like the Mock Turtle;.','54','0','0','224','2013-04-13 14:33:09','2016-12-14 05:18:07'),
('78','1','94','Cum perferendis molestias quis in.','Magpie began wrapping itself up and went to school in the direction it pointed to, without trying to invent something!\' \'I--I\'m a little three-legged table, all made of solid glass; there was.','89','0','0','83','2010-10-05 10:55:59','1982-10-07 09:17:45'),
('79','71','54','Corrupti enim omnis aut assumenda similique.','Gryphon added \'Come, let\'s try the thing yourself, some winter day, I will just explain to you never had to leave off being arches to do next, when suddenly a White Rabbit read out, at the Lizard as.','75','0','0','4','1971-03-10 01:08:11','1970-11-16 23:02:07'),
('80','62','7','Facilis veniam officiis qui aut earum eveniet eum deserunt.','Gryphon. \'We can do without lobsters, you know. But do cats eat bats? Do cats eat bats? Do cats eat bats?\' and sometimes, \'Do bats eat cats?\' for, you see, Alice had not the smallest notice of her.','66','0','1','96','2006-09-26 07:33:56','2014-04-28 16:56:12'),
('81','40','22','Ab nihil voluptates sed eligendi maxime.','Alice did not like to see the Queen. \'You make me giddy.\' And then, turning to Alice an excellent opportunity for showing off a little bit of stick, and made believe to worry it; then Alice,.','47','0','0','276','1994-05-31 15:24:56','1974-11-17 09:58:32'),
('82','37','3','Ut eveniet architecto qui autem omnis.','YOU.--Come, I\'ll take no denial; We must have imitated somebody else\'s hand,\' said the Cat; and this was of very little use without my shoulders. Oh, how I wish you wouldn\'t mind,\' said Alice:.','3','1','0','169','1986-12-11 05:21:38','2006-07-09 18:48:36'),
('83','69','2','Dolor perspiciatis sit non velit fugiat non qui.','Mock Turtle in a soothing tone: \'don\'t be angry about it. And yet I don\'t want to go down the hall. After a while, finding that nothing more to come, so she tried another question. \'What sort of.','60','0','0','157','1983-07-03 03:51:15','2017-06-20 09:59:21'),
('84','81','25','Fugit et quis qui hic et aliquam dolor.','March Hare was said to herself, \'Now, what am I to get her head impatiently; and, turning to Alice, they all crowded round her once more, while the rest were quite dry again, the Dodo replied very.','3','1','1','265','1986-01-01 18:26:41','2001-10-26 22:37:45'),
('85','7','19','Excepturi suscipit tenetur veniam neque repellat et qui quam.','CHAPTER VIII. The Queen\'s Croquet-Ground A large rose-tree stood near the entrance of the legs of the tail, and ending with the words came very queer indeed:-- \'\'Tis the voice of thunder, and people.','22','1','0','270','1990-02-03 09:15:49','1990-06-16 03:35:25'),
('86','42','1','Aperiam delectus qui delectus velit ab.','Alice. The poor little thing was to get rather sleepy, and went on \'And how do you know I\'m mad?\' said Alice. \'Then you should say \"With what porpoise?\"\' \'Don\'t you mean \"purpose\"?\' said Alice..','24','1','0','365','2007-08-22 22:48:53','2001-09-24 17:39:57'),
('87','7','8','Rerum debitis minima omnis placeat maxime accusantium.','I begin, please your Majesty,\' he began, \'for bringing these in: but I grow at a reasonable pace,\' said the March Hare will be When they take us up and bawled out, \"He\'s murdering the time! Off with.','6','1','0','306','1998-10-17 16:53:57','2004-03-03 14:09:07'),
('88','40','31','Ut est veritatis consequatur.','Alice heard the Queen to-day?\' \'I should think very likely it can be,\' said the Mouse, in a whisper.) \'That would be of very little use without my shoulders. Oh, how I wish I hadn\'t gone down that.','35','1','1','123','1999-07-07 03:30:25','2004-03-23 17:01:42'),
('89','1','34','Dolorem omnis enim tempora neque voluptas.','I shall think nothing of the Lobster Quadrille?\' the Gryphon remarked: \'because they lessen from day to such stuff? Be off, or I\'ll kick you down stairs!\' \'That is not said right,\' said the Duchess..','1','0','1','365','1974-01-31 06:49:42','1990-04-16 15:21:22'),
('90','61','61','Enim provident officia qui eos dolorem enim quos.','Alice. \'And be quick about it,\' added the Queen. \'I haven\'t opened it yet,\' said the Caterpillar, just as she tucked it away under her arm, that it was indeed: she was dozing off, and Alice rather.','55','0','1','232','1982-05-31 18:42:19','1970-07-11 05:43:46'),
('91','65','36','Totam porro blanditiis rerum blanditiis vero.','Duchess?\' \'Hush! Hush!\' said the Mock Turtle angrily: \'really you are painting those roses?\' Five and Seven said nothing, but looked at her own child-life, and the great puzzle!\' And she thought it.','97','0','1','281','1985-07-14 13:17:57','1972-06-06 22:48:07'),
('92','68','69','Rerum eos quia quod sint nisi dolorem.','Mock Turtle replied in a very hopeful tone though), \'I won\'t interrupt again. I dare say you never even spoke to Time!\' \'Perhaps not,\' Alice replied very solemnly. Alice was beginning to feel very.','15','1','1','331','1982-08-17 15:43:50','1980-07-17 15:44:06'),
('93','45','50','Sunt aut quia illo commodi eveniet accusamus.','Alice went on at last, they must be collected at once set to work at once took up the fan and gloves. \'How queer it seems,\' Alice said with a sigh: \'it\'s always tea-time, and we\'ve no time to wash.','86','0','0','82','1987-08-27 12:12:26','1970-09-06 18:36:22'),
('94','24','85','Dolore nihil tempore voluptas expedita ut autem dolor ex.','Never heard of \"Uglification,\"\' Alice ventured to ask. \'Suppose we change the subject. \'Ten hours the first question, you know.\' He was an uncomfortably sharp chin. However, she got up in great fear.','20','0','0','301','1985-09-12 03:48:43','1981-09-02 00:04:43'),
('95','64','91','Delectus et enim omnis et.','While the Owl and the Queen\'s voice in the window, and on both sides at once. \'Give your evidence,\' said the Mock Turtle at last, and they went on in the lock, and to wonder what Latitude was, or.','3','1','0','260','2008-05-23 05:16:15','2016-08-06 22:16:37'),
('96','84','58','Quia adipisci explicabo nam necessitatibus.','Majesty,\' said Alice sharply, for she had quite forgotten the words.\' So they went up to Alice, very much at this, she was about a whiting to a day-school, too,\' said Alice; \'living at the stick,.','52','0','1','100','1982-11-08 11:40:48','1996-03-27 08:59:11'),
('97','20','30','At alias labore quaerat voluptas impedit molestias similique.','Dormouse\'s place, and Alice looked all round the thistle again; then the Mock Turtle said: \'no wise fish would go through,\' thought poor Alice, \'it would be very likely true.) Down, down, down..','15','1','0','382','2019-09-22 14:56:36','1982-09-25 04:37:33'),
('98','49','49','Consectetur sed quis architecto voluptas ipsum beatae.','Cat. \'I\'d nearly forgotten to ask.\' \'It turned into a line along the passage into the air. \'--as far out to the Queen, who had been anything near the door, she ran out of sight; and an old.','4','0','1','291','1978-06-21 00:23:30','1995-12-27 16:44:20'),
('99','60','17','Nostrum cupiditate quo id id.','Dormouse shall!\' they both bowed low, and their slates and pencils had been looking over their shoulders, that all the time she saw in my life!\' Just as she was always ready to agree to everything.','20','1','1','106','1980-01-18 19:45:25','2005-09-30 18:08:46'),
('100','61','23','Maiores est aut ut ullam.','She generally gave herself very good advice, (though she very seldom followed it), and sometimes shorter, until she had not got into the earth. Let me see: four times five is twelve, and four times.','65','0','1','300','2011-06-18 13:16:19','1978-06-06 22:32:24'); 


-- -------------------------------------ЗАДАНИЕ 3 --------------------------------------
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
-- Прошу обратить внимание, что у меня поле gender необязательно для заполнения
SELECT * FROM posts p LIMIT 10 ;
SELECT user_id, gender FROM profiles WHERE gender = 'f';

SELECT IF(
(SELECT COUNT(user_id) AS women 
FROM likes
WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'f'))
>
(SELECT COUNT(user_id) AS men 
FROM likes
WHERE user_id IN (SELECT user_id FROM profiles WHERE gender = 'm')),
"women more then men", "men more then women") AS answer;
-- Прошу прощения, на вариант с равенством уже времени не зватило.

-- -------------------------------------ЗАДАНИЕ 4 --------------------------------------
-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей
SELECT * FROM likes;
DESC likes ;
ALTER TABLE likes ADD FOREIGN KEY (target_id) REFERENCES users(id);

SELECT 
user_id, 
birthday,
(SELECT COUNT(id) FROM likes WHERE target_id = profiles.user_id ) AS likes 
FROM profiles 
ORDER BY birthday DESC LIMIT 10;

-- SELECT * FROM likes WHERE user_id = 61;

SELECT SUM(likes) FROM
(SELECT 
-- user_id, 
-- birthday,
(SELECT COUNT(id) FROM likes WHERE target_id = profiles.user_id ) AS likes 
FROM profiles 
ORDER BY birthday DESC LIMIT 10) AS total;

-- -------------------------------------ЗАДАНИЕ 5 --------------------------------------
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- критерии активности необходимо определить самостоятельно (кол-во постов)
SELECT * FROM posts;
-- SELECT COUNT(id) FROM posts WHERE user_id = profiles.user_id AS posts;
-- SELECT * FROM posts WHERE user_id = 65;
SELECT 
COUNT(user_id) AS post_per_user,
user_id,
(SELECT first_name FROM users WHERE user_id = users.id) AS name_of_user
FROM posts 
GROUP BY user_id ORDER BY post_per_user DESC
LIMIT 10;
-- Нашел наибольшую активность (посты). Потом понял, что надо искать наименьшую
-- SELECT * FROM posts WHERE user_id = 65;

SELECT 
id, 
first_name,
(SELECT COUNT(id) FROM posts WHERE user_id = users.id) AS post_per_user
FROM users
ORDER BY post_per_user LIMIT 37;
-- С 0 постов (то есть без постов) оказалось 37 человек





