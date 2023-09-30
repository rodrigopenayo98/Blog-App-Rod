require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Rod.', photo: 'https://photos.app.goo.gl/fen6tqfZbGfaq3JPA', bio: 'Signature Rod.', posts_counter: 4) }
  before { user.save }

  let(:post) do
    Post.create(title: 'Music', text: 'Music is life', commentsCounter: 2, likesCounter: 10, author_id: user.id)
  end
  before { post.save }

  describe 'validations' do
    it 'validates the presence of the title' do
      post = Post.new(title: nil)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validate maximum title length' do
      long_title = 'a' * 251
      post = Post.new(title: long_title)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end

    it 'validates that the comment counter is greater than or equal to zero' do
      post = Post.new(commentsCounter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:commentsCounter]).to include('must be greater than or equal to 0')
    end

    it 'validates that the likes counter is greater than or equal to zero' do
      post = Post.new(likesCounter: -1)
      expect(post).not_to be_valid
      expect(post.errors[:likesCounter]).to include('must be greater than or equal to 0')
    end
  end

  describe 'user associations' do
    it "increments the user's posts_counter by 1" do
      user = create(:user)
      expect do
        post = create(:post, author: user)
        post.update_counter_posts
      end.to change { user.reload.posts_counter }.by(1)
    end
  end


  describe 'comments' do
    it 'should show the last 5 recent comments' do
      user = create(:user)
      post = create(:post, author: user)

      5.times do
        create(:comment, user:, post:, created_at: 1.hour.ago)
      end

      recent_comments = post.latest_comments

      expect(recent_comments.count).to eq(5)
    end
  end
end
