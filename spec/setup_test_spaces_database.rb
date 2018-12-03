require 'pg'

def setup_test_spaces_database
  conn = PG.connect( dbname: 'makers_bnb_test' )
  conn.exec("TRUNCATE spaces;")
end
