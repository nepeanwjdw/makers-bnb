require 'email'

describe Email do
  describe '.create' do
    it 'sends an email' do
      # NEED TO DOUBLE COMPOSER
      output = Email.create('alittlecross@live.co.uk', 'signed_up')
      expect(output.status).to eq("250")
    end
  end

  describe '.composer' do
    it 'expects the correct content to be returned' do
      expect(Email.composer("signed_up")).to eq("You signed up to makers bnb...\n\nWhy not go list a space?!")
      expect(Email.composer("created_a_space")).to eq("You created a space...\n\nAll you have to do now is wait for the requests to roll in.")
      expect(Email.composer("updated_a_space")).to eq("You updated a space...\n\nWell, a change is as good as a rest.")
      expect(Email.composer("request_to_host")).to eq("You received a request...\n\nGo to your dashboard to review it.")
      expect(Email.composer("confirm_request")).to eq("You confirmed a request...\n\nYou're a welcoming host, go you!")
      expect(Email.composer("requested_a_space")).to eq("You requested a space...\n\nFingers crossed the host says yes.")
      expect(Email.composer("request_confirmed")).to eq("Are you sitting comfortably...\n\nGood news! Your request was confirmed!")
      expect(Email.composer("request_denied")).to eq("Are you sitting comfortably...\n\nWe're sorry to have to tell you, your request was denied.")
    end
  end
end