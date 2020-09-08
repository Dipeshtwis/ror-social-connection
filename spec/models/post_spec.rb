require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) do
    User.create(name: 'deepesh', email: 'dp@gmail.com.com',
                password: 'password', password_confirmation: 'password')
  end
  let(:user2) do
    User.create(name: 'deep', email: 'dp@gmail.com',
                password: 'password', password_confirmation: 'password')
  end

  let(:friendship) do
    Friendship.create(
      user_id: user1.id,
      friend_id: user2.id,
      status: true
    )
  end

  describe 'can see friend post' do
    it 'returns an array of post objects' do
      friendship
      Post.create(content: 'This is the first post', user_id: user1.id)
      result = Post.user_friend(user2)
      expect(result).to match_array(user1.posts)
    end
  end

  context 'validation post test' do
    it { should validate_presence_of(:content) }

    it do
      should validate_length_of(:content)
        .is_at_most(1000)
        .with_message('maximum 1000 characters allowed.')
    end

    it 'create a new post with related user' do
      post1 = Post.create(content: 'For Testing Purpose', user_id: 1)
      expect(post1) == true
    end
  end
end
