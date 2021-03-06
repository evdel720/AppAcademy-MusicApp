class User < ActiveRecord::Base
  attr_reader :password
  after_initialize :ensure_session_token
  after_initialize :ensure_activate_token
  validates :username, :session_token, :password_digest, :activate_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  has_many :notes


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def activate!
    self.activated = true
    self.save!
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def ensure_activate_token
    self.activate_token ||= SecureRandom.urlsafe_base64(16)
  end
end
