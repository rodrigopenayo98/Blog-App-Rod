class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bio, presence: true
  validates :photo, presence: true

  def latest_posts
    posts.order(created_at: :desc).limit(3)
  end

  after_initialize :set_defaults

  def set_defaults
    self.posts_counter ||= 0
  end
end
