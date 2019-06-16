module LoginHelper   
  def login(user)
    request.cookies[:auth_token] = user.auth_token
  end

  def current_user
    User.find_by_auth_token!(cookies[:auth_token])
  end

  def login_process(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"
  end
end