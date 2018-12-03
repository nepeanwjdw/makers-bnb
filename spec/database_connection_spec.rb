require_relative '../DatabaseConnection_setup'

describe 'database_connection' do
  it 'connection is persistent' do
    connection = DatabaseConnection.setup('makers_bnb_test')
    expect(DatabaseConnection.connection).to eq connection
  end
end
