class User < ActiveRecord::Base
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
end

