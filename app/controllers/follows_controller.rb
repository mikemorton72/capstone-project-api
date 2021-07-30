class FollowsController < ApplicationController
  before_action :authenticate_user
  
  def create
    if Follow.find_by(follower_id: current_user.id, followee_id: params[:followee_id])
      render json: {message: "#{current_user.name} is already following #{User.find_by(id: params[:followee_id]).name}"}
    else
      @follow = Follow.new(
        followee_id: params[:followee_id],
        follower_id: current_user.id
      )
      if @follow.save
        render "show.json.jbuilder"
      else
        render json: {errors: @follow.errors.full_messages}, status: :unprocessable_entity
      end
    end
  end
  
  def destroy
    follow = Follow.find_by(follower_id: current_user.id, followee_id: params[:followee_id])
    if follow
      follow.destroy
      render json: {message: "#{follow.follower.name} unfollowed #{follow.followee.name}"}
    else
      render json: {message: "Follow not found"}
    end
  end
end
