class User < ActiveRecord::Base
  attr_accessor :remember_token

  validates(:name, presence: true)
  validates(:name, length: { maximum: 50 })
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true)
  validates(:email, length: { maximum: 200 })
  validates(:email, format: { with: VALID_EMAIL_REGEX })
  validates(:email, uniqueness: { case_sensitive: false })
  before_save { email.downcase! }

  validates(:password, length: { minimum: 6 })
  has_secure_password


  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine::cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
end

