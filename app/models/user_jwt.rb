class UserJwt < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  before_create :generate_auth_token

  private

  def generate_auth_token
    self.auth_token = SecureRandom.hex(10)
  end
end
