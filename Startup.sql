DROP TABLE rooms;
CREATE TABLE rooms (id serial PRIMARY KEY NOT NULL,
                    roomname text NOT NULL,
                    username VARCHAR(25) NOT NULL references users(username));