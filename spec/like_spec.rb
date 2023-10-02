require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'like count update' do
    it 'should update post likes count after create' do
      user = create(:user)
      post = create(:post)
      like = build(:like, user:, post:)

      expect { like.save }.to change { post.reload.likesCounter }.by(1)
    end

    it 'updates the post likes count after create' do
      user = create(:user)
      post = create(:post)
      like = build(:like, user:, post:)

      expect { like.save }.to change { post.reload.likesCounter }.by(1)
    end
  end
end
