CREATE TABLE entries (
    id serial PRIMARY KEY,
    date_entered timestamp DEFAULT NOW(),
    pH decimal(1,1) NOT NULL,
    temp decimal(2,1) NOT NULL,
    ammonia int NOT NULL,
    nitrites int NOT NULL,
    nitrates int NOT NULL,
    notes text NOT NULL
);