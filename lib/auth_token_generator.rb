class AuthTokenGenerator
  def self.token
    SecureRandom.hex
  end
end