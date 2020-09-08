require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET#index' do
    before { get posts_path }

    it { should redirect_to(new_user_session_path) }
  end

  describe 'Authenticated User' do
    before do
      @user = User.create(name: 'deepesh', email: 'dp@gmail.com', password: 'password')
      sign_in @user
    end

    it 'should successfully access post timeline' do
      get posts_path
      assert_response :success
    end

    it 'should be able to create a post' do
      @post = @user.posts.create(content: 'For Testing Purpose')

      expect(@post) == true
    end
  end
end
