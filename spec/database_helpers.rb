require 'pg'

def persisted_spaces_data(space_id:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  result = connection.query("
    SELECT * FROM spaces
    WHERE space_id = #{space_id};
    ")
  result.first
end

def persisted_users_data(user_id:)
  connection = PG.connect(dbname: 'makers_bnb_test')
  result = connection.query("
    SELECT * FROM users
    WHERE user_id = #{user_id};
    ")
  result.first
end
