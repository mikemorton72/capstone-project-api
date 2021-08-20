class RunsController < ApplicationController
  before_action :authenticate_user
  def index
    run_index_user_ids = current_user.followees.map {|followee| followee.id} # pulls user_ids of all users that current_user follows
    run_index_user_ids << current_user.id # User can also view their own runs on index page
    if params[:user_id] # included in request as user_id when it's a User Show page
      run_index_user_ids = params[:user_id]
    end
    limit = 8
    if params[:page]
      offset = (params[:page].to_i - 1) * limit
      @runs = Run.where(user_id: run_index_user_ids).order(created_at: :desc).offset(offset).limit(limit)
    else
      @runs = Run.where(user_id: run_index_user_ids).order(created_at: :desc).limit(limit)
    end
    render "index.json.jbuilder"
  end

  def show
    @run = Run.find_by(id: params[:id])
    render "show.json.jbuilder"
  end

  def create
    @run = Run.new(
      user_id: current_user.id,
      title: params[:title],
      distance: params[:distance],
      elapsed_time: params[:elapsed_time],
      is_strava_import: params[:is_strava_import] || false,
      start_latitude: params[:start_latitude],
      start_longitude: params[:start_longitude],
      summary_polyline: params[:summary_polyline],
      location_name: params[:location_name]
    )
    if params[:is_strava_import]
      results = Geocoder.search([params[:start_latitude], params[:start_longitude]])
      location = results.first
      @run.location_name = "#{location.town}, #{location.state}"
      @run.strava_id = params[:strava_id]
    else
      if params[:using_my_current_location]
        @run.start_latitude = params[:start_latitude]
        @run.start_longitude = params[:start_longitude]
      else
        results = Geocoder.search(params[:location_name]).first
        if results
          coordinates = results.coordinates
          @run.start_latitude = coordinates[0]
          @run.start_longitude = coordinates[1]
        end
      end
    end
    if @run.save
      render "show.json.jbuilder"
    else
      render json: {errors: @run.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    run = Run.find_by(id: params[:id])
    if run.user_id == current_user.id
      if run
        run.destroy
        render json: {message: "#{run.title} was successfully destroyed"}
      else
        render json: {message: "run not found"}
      end
    else
      render json: {message: "user cannot delete someone else's run"}
    end
  end
end
