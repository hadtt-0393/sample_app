class User < ApplicationRecord
  attr_accessor :remember_token

  before_save{email.downcase!}
  validates :name, presence: true,
            length: {maximum: Settings.digits.length_50}
  validates :email, presence: true,
            length: {maximum: Settings.digits.length_255},
            format: {with: Settings.email.regex},
            uniqueness: true
  has_secure_password
  validates :password, presence: true,
            length: {minimum: Settings.digits.length_6},
            allow_nil: true
  scope :by_earliest_created, ->{order(created_at: :asc)}
  class << self
    # Returns the hash digest of the given string.
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost:)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Returns true if the given token matches the digest.
  def authenticated? remember_token
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  # Forgets a user.
  def forget
    update_column :remember_digest, nil
  end
end
