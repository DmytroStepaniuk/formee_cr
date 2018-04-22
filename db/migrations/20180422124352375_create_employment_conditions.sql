-- +micrate Up
CREATE TABLE employment_conditions (
  id BIGSERIAL NOT NULL PRIMARY KEY,

  email_id BIGINT NOT NULL,

  thirteenth_month BOOLEAN DEFAULT FALSE NOT NULL,
  fixed_annual_bonus DECIMAL NOT NULL,
  vacation_days INT NOT NULL,
  variable_annual_bonus NUMERIC(10, 2) NOT NULL,

  wage_indexation BOOLEAN DEFAULT FALSE NOT NULL,
  monthly_wage_low NUMERIC(10, 2) NOT NULL,
  monthly_wage_high NUMERIC(10, 2) NOT NULL,

  pension_compensation NUMERIC(10, 2) NOT NULL,

  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX index_employment_conditions_on_email_id ON employment_conditions USING btree (email_id);

ALTER TABLE ONLY employment_conditions
  ADD CONSTRAINT foreign_key_email_id FOREIGN KEY (email_id) REFERENCES emails(id);

-- +micrate Down
DROP TABLE IF EXISTS employment_conditions;
