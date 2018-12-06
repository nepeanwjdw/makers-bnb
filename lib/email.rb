require 'net/smtp'

class Email
  def self.create(to, type)
    our_smtp_server = 'smtp.office365.com'
    our_smtp_port = 587
    our_email = 'makers_bnb@outlook.com'
    our_password = 'nakers_bmb'
    our_message = "From: <#{our_email}>\nTo: <#{to}>\nSubject: #{composer(type)}"
    smtp = Net::SMTP.new(our_smtp_server, our_smtp_port)
    smtp.enable_starttls # this is dependant on the smtp_server's authentication method
    smtp.start('localhost', our_email, our_password, :login) do |smtp|
      smtp.send_message our_message, our_email, to
    end
  end

  def self.composer(type)
    case type
    when "signed_up"
      "You signed up to makers bnb...\n\nWhy not go list a space?!"
    when "created_a_space"
      "You created a space...\n\nAll you have to do now is wait for the requests to roll in."
    when "updated_a_space"
      "You updated a space...\n\nWell, a change is as good as a rest."
    when "request_to_host"
      "You received a request...\n\nGo to your dashboard to review it."
    when "confirm_request"
      "You confirmed a request...\n\nYou're a welcoming host, go you!"
    when "requested_a_space"
      "You requested a space...\n\nFingers crossed the host says yes."
    when "request_confirmed"
      "Are you sitting comfortably...\n\nGood news! Your request was confirmed!"
    when "request_denied"
      "Are you sitting comfortably...\n\nWe're sorry to have to tell you, your request was denied."
    end
  end
end