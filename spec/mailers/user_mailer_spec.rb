require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'signup_confirmation' do
    let(:user) { User.create!(email: "test1@test.com" , password: "12345678", password_confirmation: "12345678") }
    let(:mail) { described_class.signup_confirmation(user).deliver_now }
  
    it 'correct subject' do
      expect(mail.subject).to eq('Sign Up Confirmation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(["from@example.com"])
    end

  end

  describe 'password reset' do
    let(:user) { User.create!(email: "test2@test.com", password: "12345678", password_confirmation: "12345678") }
    let(:mail) { described_class.password_reset(user).deliver_now }
  
    it 'correct subject' do
      expect(mail.subject).to eq('Password Reset')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(["from@example.com"])
    end
  end
end
