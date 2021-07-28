class FollowsController < ApplicationController
  before_action :authenticate_user
  def create
    follow = Follow.new(
      followee_id: params[:followee_id],
      follower_id: current_user.id
    )
    if follow.save
      render json: {message: "#{follow.follower.name} successfully followed #{follow.followee.name}"}
    else
      render json: {errors: follow.errors.full_messages}
    end
  end

end
