require_relative '../DatabaseConnection_setup'

describe 'database_connection' do
  it 'connection is persistent' do
    connection = DatabaseConnection.setup('makersbnb_test')
    expect(DatabaseConnection.connection).to eq connection
  end
end
