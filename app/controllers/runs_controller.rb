class RunsController < ApplicationController
  before_action :authenticate_user
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
