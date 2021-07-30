class CommentsController < ApplicationController
  before_action :authenticate_user
  def create
    comment = Comment.new(
      user_id: current_user.id,
      run_id: params[:run_id],
      text: params[:text]
    )
    if comment.save
      render json: comment
    else
      render json: {errors: comment.errors.full_messages}
    end
  end
end
