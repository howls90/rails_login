class User < ApplicationRecord

  attr_accessor :password, :password_confirmation

  include Authentication

  before_create :set_new_user
  after_create :sent_confirmation_email

  after_validation :set_password_digest, if: :not_blank_password?


  EMAIL_REGEX = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX } 
  validates :password, length: { minimum: 8 }, confirmation: true, if: :not_blank_password?
  validates :username, length: { minimum: 5 }, allow_nil: true, on: [ :update ], if: :username_changed?

  private

    def not_blank_password?
      (self.new_record? || !self.password.blank?) ? true : false
    end

    def set_new_user
      generate_token(:auth_token)
      self.username = self.email.split('@').first
    end

end
