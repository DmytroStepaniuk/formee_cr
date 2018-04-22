-- +micrate Up
CREATE TABLE emails (
  id BIGSERIAL NOT NULL PRIMARY KEY,

  from_email VARCHAR(50) NOT NULL,
  from_name VARCHAR(50) NOT NULL,
  sent_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
  title VARCHAR(50) NOT NULL,
  body TEXT NOT NULL,

  user_id BIGINT NOT NULL,

  CONSTRAINT from_name CHECK (char_length(from_name) >= 5),
  CONSTRAINT title CHECK (char_length(title) >= 3),
  CONSTRAINT body CHECK (char_length(body) <= 10000),
  CONSTRAINT from_email_valid CHECK (from_email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),

  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX index_emails_on_user_id ON emails USING btree (user_id);
CREATE INDEX index_emails_on_from_email ON emails USING btree (lower(from_email));

ALTER TABLE ONLY emails
  ADD CONSTRAINT foreign_key_user_id FOREIGN KEY (user_id) REFERENCES users(id);

-- +micrate Down
DROP TABLE IF EXISTS emails;
