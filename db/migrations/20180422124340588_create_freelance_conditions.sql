-- +micrate Up
CREATE TABLE freelance_conditions (
  id BIGSERIAL NOT NULL PRIMARY KEY,

  email_id BIGINT NOT NULL,

  hourly_fee_low NUMERIC(10, 2) NOT NULL,
  hourly_fee_high NUMERIC(10, 2) NOT NULL,
  hours INT NOT NULL,

  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX index_freelance_conditions_on_email_id ON freelance_conditions USING btree (email_id);

ALTER TABLE ONLY freelance_conditions
  ADD CONSTRAINT foreign_key_email_id FOREIGN KEY (email_id) REFERENCES emails(id);

-- +micrate Down
DROP TABLE IF EXISTS freelance_conditions;
