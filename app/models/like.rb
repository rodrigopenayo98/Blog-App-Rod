class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :update_counter_likes

  private

  def update_counter_likes
    post.update(likesCounter: post.likes.count)
  end
end
