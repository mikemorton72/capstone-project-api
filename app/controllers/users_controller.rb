class UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  
  def index
    @users = User.all
    limit = 8
    if params[:page]
      offset = (params[:page].to_i - 1) * limit
      @users = User.order(created_at: :desc).offset(offset).limit(limit)
    else
      @users = User.order(created_at: :desc).limit(limit)
    end
    render "index.json.jbuilder"
  end

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      image: params[:image]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render "show.json.jbuilder"
  end
end
