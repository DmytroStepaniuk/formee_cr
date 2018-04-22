-- +micrate Up

CREATE EXTENSION citext;

CREATE TABLE users (
  id BIGSERIAL NOT NULL PRIMARY KEY,

  username VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  encrypted_password VARCHAR(255) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  infix VARCHAR(50),
  admin BOOLEAN DEFAULT FALSE NOT NULL,

  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,

  CONSTRAINT first_name_not_too_short CHECK (char_length(first_name) >= 2),
  CONSTRAINT last_name_not_too_short CHECK (char_length(last_name) >= 2),
  CONSTRAINT username_not_too_short CHECK (char_length(username) >= 2),
  CONSTRAINT email_valid CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
);

CREATE UNIQUE INDEX unique_index_users_on_email ON users USING btree (lower(email));
CREATE UNIQUE INDEX unique_index_users_on_username ON users USING btree (lower(username));

-- +micrate Down
DROP TABLE IF EXISTS users;
