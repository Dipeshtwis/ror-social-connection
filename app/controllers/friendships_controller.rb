class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], status: false)

    if @friendship.save
      redirect_to users_path, notice: 'friend invitation sent.'
    else
      redirect_to users_path, alert: 'Oops something wrong with the invite.'
    end
  end
end
