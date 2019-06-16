require 'digest/sha1'

class User < ApplicationRecord

  attr_accessor :password, :password_confirmation

  before_create :set_new_user

  after_validation :set_password_digest, if: :not_blank_password?


  EMAIL_REGEX = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX } 
  validates :password, length: { minimum: 8 }, confirmation: true, if: :not_blank_password?
  validates :username, length: { minimum: 5 }, allow_nil: true, on: [ :update ]

  private

    def not_blank_password?
      (self.new_record? || !self.password.blank?) ? true : false
    end

    def set_new_user
      self.username = self.email.split('@').first
    end

    def set_password_digest
      self.salt = Digest::SHA1.hexdigest("#{self.email} #{Time.now}")
      self.password_digest = Digest::SHA1.hexdigest("#{self.password} and #{self.salt}")
    end

end