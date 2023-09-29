require 'rails_helper'


RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }

  it 'should update post comments counter after create' do
    user = create(:user)
    post = create(:post)
    comment = build(:comment, user:, post:)

    expect { comment.save }.to change { post.reload.commentsCounter }.by(1)
  end

  it 'updates the post comments counter after create' do
    user = create(:user)
    post = create(:post)

    comment = build(:comment, user:, post:)

    expect { comment.save }.to change { post.reload.commentsCounter }.by(1)
  end
end
