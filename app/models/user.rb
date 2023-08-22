class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true,
            length: {maximum: Settings.digits.length_50}
  validates :email, presence: true,
            length: {maximum: Settings.digits.length_255},
            format: {with: Settings.email.regex},
            uniqueness: true
  has_secure_password
  validates :password, presence: true,
            length: {minimum: Settings.digits.length_6}
end
