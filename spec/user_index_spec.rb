require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    @users = [
      @user1 = User.create(
        name: 'Mosi',
        photo: 'https://avatars.githubusercontent.com/u/112550568?v=4',
        bio: 'C# Developer.',
        posts_counter: 6
      ),
      @user2 = User.create(
        name: 'Rod',
        photo: 'https://avatars.githubusercontent.com/u/109859994?v=4',
        bio: 'Software developer.',
        posts_counter: 0
      )
    ]
    visit users_url
  end

  it 'displays a message when there are no users' do
    User.delete_all
    visit users_url
    expect(page).to have_content('Theres no information about any user yet')
  end

  it 'displays user information when users exist' do
    @users.each do |user|
      expect(page).to have_content(user.name)
      expect(page).to have_css("img[src*='#{user.photo}']")
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
      expect(page).to have_link(user.name, href: user_path(user))
    end
  end
end
