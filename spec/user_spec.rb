require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates the presence of the name' do
    user = User.new(name: nil)
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'validates that the post counter is greater than or equal to zero' do
    user = User.new(posts_counter: -1)
    expect(user).not_to be_valid
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  it "returns the user's last 3 posts" do
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
