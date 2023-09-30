class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :update_counter_posts

  private

  def update_counter_posts
    post.update(commentsCounter: post.commentsCounter + 1)
  end
end
