require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /users' do
    it 'renders a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct content in the response body' do
      get users_path
      expect(response.body).to include('USERS')
    end
  end

  describe 'GET /users/1' do
    it 'renders a successful response' do
      user = FactoryBot.create(:user)
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = FactoryBot.create(:user)
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct content' do
      user = FactoryBot.create(:user)
      get user_path(user)
      expect(response.body).to include('USER PROFILE')
    end
  end
end
