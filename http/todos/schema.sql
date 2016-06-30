CREATE TABLE lists (
    id serial PRIMARY KEY,
    name text NOT NULL
);

ALTER TABLE lists ADD CONSTRAINT unique_name UNIQUE (name);

CREATE TABLE todos (
    id serial PRIMARY KEY,
    name text NOT NULL,
    completed boolean NOT NULL DEFAULT false,
    list_id integer NOT NULL
);

ALTER TABLE todos ADD FOREIGN KEY (list_id) REFERENCES lists (id);