DROP DATABASE if EXISTS weddingtest;
CREATE DATABASE weddingtest;
\c weddingtest
CREATE EXTENSION pgcrypto;
CREATE TABLE users (username text NOT NULL PRIMARY KEY,
                    password text NOT NULL);

INSERT INTO users (username, password) VALUES ('4th8', crypt('0328940', gen_salt('bf'))),
                                              ('Heather', crypt('hewnew', gen_salt('bf')));
                    
CREATE TABLE messages (username text NOT NULL references users(username),
                       message text NOT NULL default '',
                       id SERIAL NOT NULL PRIMARY KEY);

CREATE TABLE guests (id SERIAL PRIMARY KEY,
                     first_name text NOT NULL,
                     last_name text NOT NULL,
                     rsvp VARCHAR(1) default 'F',
                     number_of_extras integer default 1);

CREATE TABLE gifts (name text PRIMARY KEY NOT NULL,
                    price float8,
                    link text,
                    recieved VARCHAR(1) default 'F');

CREATE TABLE rooms (roomname text NOT NULL,
                    username text NOT NULL references users(username),
                    PRIMARY KEY (roomname,username));