DROP DATABASE if EXISTS weddingtest;
CREATE DATABASE weddingtest;
\c weddingtest
CREATE EXTENSION pgcrypto;
CREATE TABLE users (username text NOT NULL PRIMARY KEY,
                    password text NOT NULL);

CREATE TABLE messages (username text NOT NULL references users(username),
                       message text NOT NULL default '',
                       room text NOT NULL default 'public',
                       id SERIAL NOT NULL PRIMARY KEY);

CREATE TABLE guests (first_name text NOT NULL,
                     last_name text NOT NULL,
                     rsvp VARCHAR(1) default 'F',
                     number_of_extras integer default 1,
                     address text default '',
                     city text default '',
                     state text default '',
                     zip integer,
                     username text references users(username),
                     PRIMARY KEY (first_name,last_name));

CREATE TABLE gifts (name text PRIMARY KEY NOT NULL,
                    price float8,
                    link text,
                    recieved VARCHAR(1) default 'F');

CREATE TABLE thankyous (gift text NOT NULL references gifts(name),
                        username text NOT NULL references users(username),
                        PRIMARY KEY (gift, username));

CREATE TABLE rooms (roomname text NOT NULL,
                    username text NOT NULL references users(username),
                    PRIMARY KEY (roomname,username));
                    
GRANT ALL ON users to usercontrol;
GRANT ALL ON messages to messagecontrol;
GRANT ALL ON messages_id_seq to messagecontrol;
GRANT ALL ON guests to guestcontrol;
GRANT ALL ON rooms to messagecontrol;
GRANT ALL ON guests to usercontrol;