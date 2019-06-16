require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  context 'GET #new' do
    it 'returns success response' do
      get :new
      expect(response).to render_template(:new) 
    end
  end

  context 'POST #create' do
    it 'returns validation errors response' do
      params =  { user: {email: "", password: ""}}
      post :create, params: params
      expect(response).to render_template(:new)
    end

    it 'returns success response' do
      params =  {user: { email: "email@user_controller.com" , password: "12345678", password_confirmation: "12345678" }}
      post :create, params: params
      user = User.find_by_email!(params[:user][:email])
      expect(flash[:success]).to match("User was successfully created.")
      expect(response).to redirect_to(edit_user_path(user))
    end
  end

  context 'GET #edit' do
    let(:user) { User.create!(email: "email1@user_controller.com", password: "12345678", password_confirmation: "12345678")}

    it 'returns success response' do
      login(user)
      get :edit, params: { id: user.to_param }
      expect(current_user).to match(user)
      expect(response).to render_template(:edit)
    end

    it 'prevent user update another user profile' do
      user2 = User.create!(email: "email2@user_controller.com", password: "12345678", password_confirmation: "12345678")
      login(user)
      get :edit, params: { id: user2.to_param }
      expect(flash[:danger]).to match("Unauthorized action.")
      expect(response).to redirect_to(edit_user_path(user))
    end
  end

  context 'PATH #update' do
    it 'returns success response' do
      user = User.create!(email: "email3@test.com", password: "12345678", password_confirmation: "12345678")
      login(user)
      form_params = { id: user.to_param, user: {username: "tests2"}}
      put :update, params: form_params 
      expect(flash[:success]).to match("User was successfully updated.")
      expect(response).to redirect_to(edit_user_path(user))
    end
  end
end
