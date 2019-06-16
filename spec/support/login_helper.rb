module LoginHelper   
  def login(user)
    request.cookies[:auth_token] = user.auth_token
  end

  def current_user
    User.find_by_auth_token!(cookies[:auth_token])
  end
end