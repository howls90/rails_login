require 'digest/sha1'

class User
  module Authentication
    extend ActiveSupport::Concern

    def send_password_reset
      generate_token(:password_reset_token)
      update_attribute(:password_reset_at, Time.zone.now)
    end
        
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column]) 
    end

    def set_password_digest
      self.salt = Digest::SHA1.hexdigest("#{self.email} #{Time.now}")
      self.password_digest = Digest::SHA1.hexdigest("#{self.password} and #{self.salt}")
    end

    def authenticate(password)
      self.password_digest == Digest::SHA1.hexdigest("#{password} and #{self.salt}")
    end
  end
end