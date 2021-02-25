class User < ApplicationRecord
  has_many :missions
  has_secure_token :auth_token
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  before_create :set_auth_token

  private

  def set_auth_token
    self.auth_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.uuid
      break token unless User.where(auth_token: token).exists?
    end
  end
end
