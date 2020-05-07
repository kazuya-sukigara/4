class RelationshipsController < ApplicationController

   before_action :set_user
   def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to request.referer
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to request.referer
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to request.referer

    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to request.referer

    end
  end

  private
  def set_user
    # params = {
    #   relationship: {
    #     follow_id: 1
    #   }
    # }
    # params = {
    #   follow_id: 1
    # }
    @user = User.find(params[:relationship][:follow_id])
  end

end
