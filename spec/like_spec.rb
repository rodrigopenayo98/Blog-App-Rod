require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }

  it 'should update post likes count after create' do
    user = create(:user)
    post = create(:post)
    like = build(:like, user:, post:)

    expect { like.save }.to change { post.reload.likes_count }.by(1)
  end

  it 'updates the post likes count after create' do
    user = create(:user)
    post = create(:post)
    like = build(:like, user:, post:)
    expect { like.save }.to change { post.reload.likes_count }.by(1)
  end
end
