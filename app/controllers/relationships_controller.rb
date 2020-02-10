class RelationshipsController < ApplicationController

  before_action :set_user, only: [:create, :destroy]

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: users_path)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: users_path)
    end
  end
  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: users_path)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: users_path)
    end
  end

    def following_index
      @followings = current_user.followings
    end
    def follower_index
      @followers = current_user.followers
    end
  private
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
