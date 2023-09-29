require 'rails_helper'

RSpec.describe Post, type: :model do
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
    post = Post.new(comments_counter: -1)
    expect(post).not_to be_valid
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'validates that the likes counter is greater than or equal to zero' do
    post = Post.new(likes_counter: -1)
    expect(post).not_to be_valid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it "increments the user's posts_counter by 1" do
    user = create(:user)
    post = build(:post, author: user)

    expect { post.save }.to change { user.reload.posts_counter }.by(1)
  end

  it 'should show last 5 recent comments' do
    user = create(:user)
    post = create(:post, author: user)

    create(:comment, post:, created_at: 1.hour.ago)
    create(:comment, post:, created_at: 1.hour.ago)
    create(:comment, post:, created_at: 1.hour.ago)
    create(:comment, post:, created_at: 1.hour.ago)
    create(:comment, post:, created_at: 1.hour.ago)

    recent_comments = post.latest_comments

    expect(recent_comments.count).to eq(5)
  end
end
