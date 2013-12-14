# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  password_digest  :string(255)      not null
#  session_token    :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activated        :boolean          not null
#  actication_token :string(255)      not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :authentication_token
  attr_reader :password

  validates :email, :password_digest, :session_token, :presence => true
  validates :email, :uniqueness => true
  validates :password, :on => :create, :length => { :minimum => 6 }

  before_validation :reset_session_token, :on => :create
  before_validation :reset_activation_token, :on => :create

  def self.find_by_credentials(params)
    user = User.find_by_email(params[:user][:email])
    return user if user && user.is_password?(params[:user][:password])
    nil
  end

  def activate
    self.activated = true
    self.save
  end

  def password= (pt)
    self.password_digest = BCrypt::Password.create(pt)
    @password = pt
  end

  def is_password?(pt)
    BCrypt::Password.new(self.password_digest).is_password?(pt)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    reset_session_token
    self.save!
  end

  def reset_activation_token
    self.activation_token = SecureRandom.urlsafe_base64
  end

  def reset_activation_token!
    reset_activation_token
    self.save!
  end


end
