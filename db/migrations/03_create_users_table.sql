CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email char(254) UNIQUE,
  password char(128)
);
