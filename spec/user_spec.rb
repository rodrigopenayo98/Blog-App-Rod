require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { create(:user, name: 'Rod.', bio: 'Signature Rod.', photo: 'URL de la foto', posts_counter: 4) }
    before { user.save }

    it 'validates the presence of the name' do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates that the post counter is greater than or equal to zero' do
      expect(user).to be_valid
      user.posts_counter = -1
      expect(user).not_to be_valid
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end

    it 'validates the presence of the biography' do
      user.bio = nil
      expect(user).not_to be_valid
      expect(user.errors[:bio]).to include("can't be blank")
    end

    it 'validates the presence of the photo' do
      user.photo = nil
      expect(user).not_to be_valid
      expect(user.errors[:photo]).to include("can't be blank")
    end
  end

  describe 'latest_posts' do
    it "returns the user's last 3 posts" do
      user = create(:user)
      post1 = create(:post, author: user, created_at: 1.day.ago, commentsCounter: 0, likesCounter: 0)
      post2 = create(:post, author: user, created_at: 2.days.ago, commentsCounter: 0, likesCounter: 0)
      post3 = create(:post, author: user, created_at: 3.days.ago, commentsCounter: 0, likesCounter: 0)
      post4 = create(:post, author: user, created_at: 4.days.ago, commentsCounter: 0, likesCounter: 0)

      latest_posts = user.latest_posts

      expect(latest_posts).to eq([post1, post2, post3])
      expect(latest_posts).not_to include(post4)
    end
  end
end
