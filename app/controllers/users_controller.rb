class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(email: current_user.email)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending = @user.pending_friends
    @requests = @user.friend_requests
  end

  def update
    @user = User.find(params[:user_id])

    if current_user.confirm_friend(@user)
      redirect_to users_path, notice: 'invitation accepted .'
    else
      redirect_to users_path, alert: 'Oops problem with accepting invitation.'
    end
  end

  def destroy
    @user = User.find(params[:user_id])

    if current_user.reject_friend(@user)
      redirect_to users_path, notice: 'Invitation rejected'
    else
      redirect_to users_path, alert: 'Something went wrong with the rejection'
    end
  end
end
