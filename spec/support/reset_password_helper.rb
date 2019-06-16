module ResetPasswordHelper   
    def generate_password_reset_token(user)
        user.generate_token(:password_reset_token)
        user.update_attribute(:password_reset_at, Time.zone.now)
        user.save
    end
  end