CREATE TABLE messages (
  username text NOT NULL,
  message text NOT NULL default '',
  ID serial NOT NULL,
  PRIMARY KEY  (ID)
) ;