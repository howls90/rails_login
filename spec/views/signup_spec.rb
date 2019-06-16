require 'spec_helper'

describe 'Signup Page', type: :feature do
    let(:user) { User.new(email: "email@login.com", password: "12345678", password_confirmation: "12345678")}

  it "signup success" do
    visit signup_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Create User"
    expect(page).to have_content 'User was successfully created.'
    signed_user = User.find_by_email(user.email)
    expect(current_path).to eq(edit_user_path(signed_user))
  end

  it "signup email presence fail" do
    visit signup_path
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Create User"
    expect(page).to have_content "Email can't be blank Email is invalid"
    expect(current_path).to eq("/users")
  end

  it "signup email format fail" do
    visit signup_path
    fill_in "Email", with: "test.com"
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Create User"
    expect(page).to have_content 'error prohibited this user from being saved:'
    expect(current_path).to eq("/users")
  end

  it "signup password presence fail" do
    visit signup_path
    fill_in "Email", with: user.email
    fill_in "Password confirmation", with: user.password
    click_button "Create User"
    expect(page).to have_content 'Password is too short (minimum is 8 characters)'
    expect(current_path).to eq("/users")
  end

  it "signup password length fail" do
    visit signup_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "123"
    fill_in "Password confirmation", with: "123"
    click_button "Create User"
    expect(page).to have_content 'Password is too short (minimum is 8 characters)'
    expect(current_path).to eq("/users")
  end

  it "signup password != password confirm" do
    visit signup_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: "123"
    click_button "Create User"
    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(current_path).to eq("/users")
  end
end