class UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  
  def index
    @users = User.all
    render "index.json.jbuilder"
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if current_user.followees.include?(user)
      render json: user
    else
      render json: {message: "Follow #{user.name} to view their posts"}
    end
  end
end
