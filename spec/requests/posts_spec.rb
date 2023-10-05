require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'renders a successful response' do
      user = FactoryBot.create(:user)
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      user = FactoryBot.create(:user)
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct elements' do
      user = FactoryBot.create(:user)
      get user_posts_path(user)

      expect(response.body).to include(user.name)
      expect(response.body).to include('<a href="#">')
      expect(response.body).to include('<button type="button" class="btn-pagination">Pagination</button>')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'renders a successful response' do
      user = FactoryBot.create(:user)
      post = FactoryBot.create(:post, author_id: user.id)
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end


    it 'renders the show template' do
      user = FactoryBot.create(:user, name: 'John')
      post = FactoryBot.create(:post, author_id: user.id, title: 'Sample Post', content: 'This is a sample post.') # Crear un post asociado al usuario
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end
  end
end
