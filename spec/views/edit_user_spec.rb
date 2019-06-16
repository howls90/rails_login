require 'spec_helper'

describe 'Profile Page', type: :feature do
    let(:user) { User.create!(email: "email@profile.com", password: "12345678", password_confirmation: "12345678")}

  it "edit username succcess" do
    login_process(user)
    visit edit_user_path(user)
    fill_in "Username", with: "test2"
    click_button "Update User"
    expect(page).to have_content 'User was successfully updated.'
    expect(current_path).to eq(edit_user_path(user))
  end

  it "edit username length fail" do
    login_process(user)
    visit edit_user_path(user)
    fill_in "Username", with: "te"
    click_button "Update User"
    expect(page).to have_content 'Username is too short (minimum is 5 characters)'
    expect(current_path).to eq(user_path(user))
  end

  it "edit password length fail" do
    login_process(user)
    visit edit_user_path(user)
    fill_in "Password", with: "123"
    fill_in "Password confirmation", with: "123"
    click_button "Update User"
    expect(page).to have_content 'Password is too short (minimum is 8 characters)'
    expect(current_path).to eq(user_path(user))
  end

  it "edit password confirmation fail" do
    new_password = "09876543"
    login_process(user)
    visit edit_user_path(user)
    fill_in "Password", with: new_password
    fill_in "Password confirmation", with: user.password
    click_button "Update User"
    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(current_path).to eq(user_path(user))
  end

  it "edit password successfully" do
    new_password = "09876543"
    login_process(user)
    visit edit_user_path(user)
    fill_in "Password", with: new_password
    fill_in "Password confirmation", with: new_password
    click_button "Update User"
    expect(page).to have_content 'User was successfully updated.'
    expect(current_path).to eq(edit_user_path(user))
  end

  
end