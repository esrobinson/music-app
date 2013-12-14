require 'addressable/uri'

class UserMailer < ActionMailer::Base
  default from: "activation@musicappexample.com"

  def activation_email(user)
    @user = user
    @url = Addressable::URI.new(
    :scheme => "http",
    :host => "localhost:3000",
    :path => "users/activate",
    :query_values => { :activation_token => user.activation_token }
    ).to_s
    mail(:to => user.email, :subject => "Activate your account!")
  end
end
