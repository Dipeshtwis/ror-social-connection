require 'rails_helper'

RSpec.describe Post, type: :model do
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
