require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let(:user) { User.create(name: 'Rod', photo: 'https://avatars.githubusercontent.com/u/112550568?v=4', bio: 'C# Developer.', posts_counter: 6) }
  let(:posts) do
    [
      Post.create(author: user, title: 'Post 1', text: 'Text for post 1', commentsCounter: 0, likesCounter: 0),
      Post.create(author: user, title: 'Post 2', text: 'Text for post 2', commentsCounter: 0, likesCounter: 0),
      Post.create(author: user, title: 'Post 3', text: 'Text for post 3', commentsCounter: 0, likesCounter: 0)
    ]
  end

  before do
    visit user_path(user)
  end

  it "Can see the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it "Can see the user's username" do
    expect(page).to have_content(user.name)
  end

  it 'Can see the number of posts' do
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it 'Can see the bio' do
    expect(page).to have_content(user.bio)
  end

  it 'Can see the last 3 posts' do
    user.latest_posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it "Can see a 'See All Posts' button" do
    expect(page).to have_link('See All Posts', href: user_posts_path(user), class: 'btn-all-posts')
  end

  it "It correctly redirects me to the user's post index page when I click on see all posts" do
    click_link 'See All Posts'
    expect(current_path).to eq(user_posts_path(user))
  end
end
