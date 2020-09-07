require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before :each do
    User.create(name: 'deepesh', email: 'dp@gmail.com', password: 'password', password_confirmation: 'password')
    User.create(name: 'deep', email: 'dip@gmail.com', password: 'password', password_confirmation: 'password')
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: 'dp@gmail.com'
      fill_in 'user_password', with: 'password'
    end
    click_button 'commit'
    visit '/users'
  end

  it 'send invitations to other users' do
    expect(page).to have_content('Invite')
  end

  it 'status changed to pending' do
    click_link('deep')
    expect(page).to have_content('Pending')
  end
end
