require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensure email presence' do
      user = User.new(password: "12345678", password_confirmation: "12345678")
      user.valid?
      expect(user.errors.messages[:email]).to include("can't be blank")
      expect(user.errors.messages[:email]).to include("is invalid")
    end

    it 'ensure email format' do
      user = User.new(email: "email" , password: "12345678", password_confirmation: "12345678")
      user.valid?
      expect(user.errors.messages[:email]).to include("is invalid")
    end

    it 'ensure password presence' do
      user = User.new(email: "test999@user.com" ,password_confirmation: "12345678").save
      expect(user).to eq(false)
    end

    it 'ensure password & password confirmation are equal' do
      user = User.new(email: "test@user.com" , password: "12345678", password_confirmation: "123")
      user.valid?
      expect(user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end

    it 'ensure username is correct' do
      user = User.create(email: "test@user.com" , password: "12345678", password_confirmation: "12345678")
      expect(user.username).to match(user.email.split('@').first)
    end
  end

  context 'validation on update' do
    let(:user) { User.create!(email: "email2@user.com", password: "12345678", password_confirmation: "12345678")}

    it 'ensure username fail' do
      user.assign_attributes(username: "test")
      expect(user.save).to eq(false)
    end

    it 'ensure username success' do
      password_digest = user.password_digest
      user.assign_attributes(username: "tests")
      expect(user.save).to eq(true)
      expect(password_digest).to eq(user.password_digest)
    end

    it 'ensure password length' do
      user.assign_attributes(password: "1234567", password_confirmation: "1234567")
      expect(user.save).to eq(false)
    end

    it 'ensure password == password_confirmation fail' do
      user.assign_attributes(password: "12345679", password_confirmation: "12345670")
      expect(user.save).to eq(false)
    end

    it 'ensure password == password_confirmation success' do
      password_digest = user.password_digest
      user.assign_attributes(password: "12345679", password_confirmation: "12345679")
      expect(user.save).to eq(true)
      expect(password_digest).not_to eq(user.password_digest)
    end
  end

  context 'user module' do
    let(:user) { User.create!(email: "email2@user.com", password: "12345678", password_confirmation: "12345678")}

    it 'check authentication success' do
      expect(user.authenticate(user.password)).to eq(true)
    end

    it 'check authentication success' do
      expect(user.authenticate("123")).to eq(false)
    end
  end
end
