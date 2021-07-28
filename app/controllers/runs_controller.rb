class RunsController < ApplicationController
  before_action :authenticate_user
  def index
    run_index_user_ids = current_user.followees.map {|followee| followee.id} # pulls user_ids of all users that current_user follows
    run_index_user_ids << current_user.id # User can also view their own runs on index page
    runs = Run.where(user_id: run_index_user_ids)
    render json: runs
  end

  def create
    run = Run.new(
      user_id: current_user.id,
      title: params[:title],
      distance: params[:distance],
      elapsed_time: params[:elapsed_time]
    )
    if run.save
      render json: run
    else
      render json: {errors: run.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
