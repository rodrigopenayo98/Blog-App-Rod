require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  let(:user) { User.create(name: 'Rod', photo: 'https://avatars.githubusercontent.com/u/112550568?v=4', bio: 'C# Developer.', posts_counter: 6) }

  before do
    @posts = [
      Post.create(author: user, title: 'Working on new react project', text: 'Text for post 1',
                  commentsCounter: 0, likesCounter: 0),
      Post.create(author: user, title: 'Learning Redux', text: 'Text for post 2',
                  commentsCounter: 0, likesCounter: 0),
      Post.create(author: user, title: 'Still studying CSS', text: 'Text for post 3',
                  commentsCounter: 0, likesCounter: 0),
      Post.create(author: user, title: 'Update my Portfolio', text: 'Text for post 4',
                  commentsCounter: 0, likesCounter: 0)
    ]
    visit user_path(user)
  end

  it "can see the user's bio" do
    expect(page).to have_content(user.bio)
  end

  it "can see the user's name" do
    expect(page).to have_content(user.name)
  end

  it "can see the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it 'can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it "can see a button that lets me view all of a user's posts" do
    expect(page).to have_link('See All Posts', href: user_posts_path(user), class: 'btn-all-posts')
  end
end
