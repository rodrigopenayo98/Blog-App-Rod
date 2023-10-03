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

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is some placeholder text for the index page')
    end
  end

  describe 'GET /users/1' do
    it 'renders a successful response' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create(name: 'John')
      get user_path(user)
      expect(response.body).to include('Here is some placeholder text for the show page')
    end
  end
end
