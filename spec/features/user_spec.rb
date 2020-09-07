require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'Sign-in process' do
    before :each do
      User.create(name: 'deepesh', email: 'dp@gmail.com', password: 'password', password_confirmation: 'password')
      visit 'users/sign_in'
      within('#new_user') do
        fill_in 'user_email', with: 'dp@gmail.com'
        fill_in 'user_password', with: 'password'
      end
      click_button 'commit'
    end

    it 'sign in with the name' do
      expect(page).to have_content 'deepesh'
    end

    it 'signs me out' do
      click_link('Sign out')
      expect(page).to have_content 'Sign in'
    end
  end
end
