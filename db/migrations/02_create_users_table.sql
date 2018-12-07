CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(254) UNIQUE,
  password VARCHAR(128)
);
