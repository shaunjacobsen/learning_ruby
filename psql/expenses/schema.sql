CREATE TABLE expenses (
  id serial PRIMARY KEY,
  amount numeric(5,2) NOT NULL,
  memo text NOT NULL,
  created_on date NOT NULL
);

ALTER TABLE expenses ADD CONSTRAINT positive_amount CHECK (amount > 0.00);