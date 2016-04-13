DROP DATABASE if EXISTS weddingtest;
CREATE DATABASE weddingtest;
\c weddingtest
CREATE EXTENSION pgcrypto;
CREATE TABLE users (username text NOT NULL PRIMARY KEY,
                    password text NOT NULL);

INSERT INTO users (username, password) VALUES ('administrator', crypt('password', gen_salt('bf')));

CREATE TABLE messages (username text NOT NULL references users(username) CONSTRAINT notblank CHECK (LENGTH(username) > 0),
                       message text NOT NULL default '',
                       room text NOT NULL default 'public',
                       id SERIAL NOT NULL PRIMARY KEY);

CREATE TABLE guests (first_name text NOT NULL CONSTRAINT notblank CHECK (LENGTH(first_name) > 0),
                     last_name text NOT NULL CONSTRAINT notblan CHECK (LENGTH(last_name) > 0),
                     rsvp VARCHAR(1) default 'F',
                     number_of_extras integer default 1,
                     address text default '',
                     city text default '',
                     state text default '',
                     zip integer,
                     username text references users(username),
                     PRIMARY KEY (first_name,last_name));

CREATE TABLE gifts (name text PRIMARY KEY NOT NULL CONSTRAINT notblank CHECK (LENGTH(name) > 0),
                    price float8,
                    link text,
                    picture text,
                    recieved VARCHAR(1) default 'F');

CREATE TABLE thankyous (gift text NOT NULL references gifts(name),
                        username text NOT NULL references users(username),
                        PRIMARY KEY (gift, username));

CREATE TABLE rooms (roomname text NOT NULL,
                    username text NOT NULL references users(username),
                    PRIMARY KEY (roomname,username));


CREATE INDEX mess on messages(message);
GRANT ALL ON users to usercontrol;
GRANT ALL ON messages to messagecontrol;
GRANT ALL ON messages_id_seq to messagecontrol;
GRANT ALL ON guests to guestcontrol;
GRANT ALL ON gifts to guestcontrol;
GRANT ALL ON rooms to messagecontrol;
GRANT ALL ON guests to usercontrol;
GRANT ALL on thankyous to guestcontrol;
\i Addresses.sql