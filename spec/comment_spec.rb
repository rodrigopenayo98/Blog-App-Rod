require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Rod.', photo: 'https://photos.app.goo.gl/fen6tqfZbGfaq3JPA', bio: 'Signature Rod.', posts_counter: 4) }
  let(:post) { Post.create(title: 'Music', text: 'Music is life', commentsCounter: 2, likesCounter: 10, author_id: user.id) }

  describe 'comment count update' do
    it 'should update post comments counter after create' do
      comment = build(:comment, user:, post:) # Utiliza los objetos user y post que has creado

      expect { comment.save }.to change { post.reload.commentsCounter }.by(1)
    end

    it 'updates the post comments counter after create' do
      comment = build(:comment, user:, post:) # Utiliza los objetos user y post que has creado

      expect { comment.save }.to change { post.reload.commentsCounter }.by(1)
    end
  end
end
