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
end

