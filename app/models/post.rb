class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  # ...
  def lastet_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_counter_posts
    author.update(posts_count: author.posts.count)
  end
end
