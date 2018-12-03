CREATE TABLE spaces(
  space_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  user_id INT,
  description VARCHAR(300),
  price INT,
  FOREIGN KEY (user_id) REFERENCES users (user_id)
);
