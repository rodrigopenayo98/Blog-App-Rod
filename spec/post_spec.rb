require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(250) }
  it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }

  it 'returns the latest 5 comments' do
    user = create(:user)
    post = create(:post, author: user)

    comment1 = create(:comment, user:, post:, created_at: 1.day.ago)
    comment2 = create(:comment, user:, post:, created_at: 2.days.ago)
    comment3 = create(:comment, user:, post:, created_at: 3.days.ago)
    comment4 = create(:comment, user:, post:, created_at: 4.days.ago)
    comment5 = create(:comment, user:, post:, created_at: 5.days.ago)
    comment6 = create(:comment, user:, post:, created_at: 6.days.ago)

    latest_comments = post.latest_comments

    expect(latest_comments).to eq([comment1, comment2, comment3, comment4, comment5])
    expect(latest_comments).not_to include(comment6)
  end

  it 'updates the posts count for the author' do
    user = create(:user)
    post1 = create(:post, author: user)
    create(:post, author: user)

    post1.update_counter_posts

    expect(user.reload.posts_count).to eq(2)
  end
end
