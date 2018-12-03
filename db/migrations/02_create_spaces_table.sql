CREATE TABLE spaces(
  id SERIAL PRIMARY KEY,
  user_id INT,
  description VARCHAR(300),
  price INT,
  FOREIGN KEY (user_id) REFERENCES users (id)
);
