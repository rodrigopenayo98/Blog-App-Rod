require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }

  it 'returns the latest 3 posts' do
    user = create(:user)
    post1 = create(:post, author: user, created_at: 1.day.ago)
    post2 = create(:post, author: user, created_at: 2.days.ago)
    post3 = create(:post, author: user, created_at: 3.days.ago)
    post4 = create(:post, author: user, created_at: 4.days.ago)

    latest_posts = user.latest_posts

    expect(latest_posts).to eq([post1, post2, post3])
    expect(latest_posts).not_to include(post4)
  end
end
