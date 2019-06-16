require 'spec_helper'

describe 'Reset Password Page', type: :feature do
  let(:user) { User.create!(email: "email@reset.com", password: "12345678", password_confirmation: "12345678")}

  it "reset successfully" do
    new_password = "87654321"
    generate_password_reset_token(user)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", with: new_password
    fill_in "Password confirmation", with: new_password
    click_button "Update Password"
    expect(page).to have_content 'Password has been reset!'
    expect(current_path).to eq(login_path)
  end

  it "reset password too short" do
    new_password = "098"
    generate_password_reset_token(user)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", with: new_password
    fill_in "Password confirmation", with: new_password
    click_button "Update Password"
    expect(page).to have_content 'Password is too short (minimum is 8 characters)'
    expect(current_path).to eq(password_reset_path(user.password_reset_token))
  end

  it "ensure password == password confirmation" do
    new_password = "098"
    generate_password_reset_token(user)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: new_password
    click_button "Update Password"
    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(current_path).to eq(password_reset_path(user.password_reset_token))
  end

  it "ensure password not blank" do
    new_password = "098"
    generate_password_reset_token(user)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Update Password"
    expect(page).to have_content "Fields can not be blank"
    expect(current_path).to eq(password_reset_path(user.password_reset_token))
  end
end