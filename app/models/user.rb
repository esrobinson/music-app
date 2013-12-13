# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :password

  validates :email, :password_digest, :session_token, :presence => true
  validates :email, :uniqueness => true
  validates :password, :on => :create, :length => { :minimum => 6 }

  before_validation reset_session_token, :on => :create

  def password= (pt)
    @password_digest = BCrypt::Password.create(pt)
    @password = pt
  end

  def is_password(pt)
    BCrypt::Password.new(@password_digest).is_password?(pt)
  end

  def reset_session_token
    @session_token = SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    reset_session_token
    self.save!
  end

  def find_by_credentials(email, pt)
    user = User.find_by_email(email)
    return user if user && user.is_password(pt)
    nil
  end

end
