require 'spec_helper'

describe 'Login Page', type: :feature do
  let(:user) { User.create!(email: "email@login.com", password: "12345678", password_confirmation: "12345678")}

  it "login success" do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"
    expect(page).to have_content 'Logged in!'
    expect(current_path).to eq(edit_user_path(user))
  end

  it "login incorrect params" do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "123"
    click_button "Login"
    expect(page).to have_content 'Email or password is invalid'
    expect(current_path).to eq('/sessions')
  end

  it "reset password" do
    visit login_path
    click_link "password"
    expect(current_path).to eq('/password_resets/new')
    fill_in "Email", with: user.email
    click_button "Reset Password"
    expect(page).to have_content 'Email sent with password reset instruction.'
    expect(current_path).to eq('/login')
  end
end