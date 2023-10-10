require 'rails_helper'

RSpec.describe 'User Post Show Page', type: :feature do
  let(:user) { User.create(name: 'ROD', photo: 'https://avatars.githubusercontent.com/u/112550568?v=4', bio: 'React Developer.', posts_counter: 6) }

  before do
    @post = Post.create(author: user, title: 'Post 1', text: 'Text for post 1', commentsCounter: 2, likesCounter: 3)
    visit user_post_path(user_id: user.id, id: @post.id)
  end

  it "Displays title" do
    expect(page).to have_content(@post.title)
  end

  it 'Displays the author of the post' do
    expect(page).to have_content("by #{user.name}")
  end

  it 'Displays all the comments' do
    expect(page).to have_content("Comments: #{@post.commentsCounter}")
  end

  it 'Displays all the Likes' do
    expect(page).to have_content("Likes: #{@post.likesCounter}")
  end

  it 'Displays the post text' do
    expect(page).to have_content(@post.text)
  end

  it 'Show the username of every comment' do
    @post.latest_comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'Show the comment for each commenter' do
    @post.latest_comments.each do |comment|
      expect(page).to have_content(comment.body)
    end
  end

  it 'Displays the "Like" button' do
    expect(page).to have_button('Like')
  end

  it 'Displays the "Add Comment" button' do
    expect(page).to have_link('Add Comment', class: 'btn-add-comment')
  end
end
