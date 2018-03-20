class User < ApplicationRecord
  before_save {email.downcase!}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates :email, presence: true, length: {maximum: 250}, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
