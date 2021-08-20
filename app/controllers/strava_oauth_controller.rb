class StravaOauthController < ApplicationController
  before_action :authenticate_user, except: [:initial_authorization]
  def initial_authorization
    # Front end sends user to (make sure to include user id in query params as 'state')
    # https://www.strava.com/oauth/authorize?client_id=68303&response_type=code&redirect_uri=http://localhost:3000/strava_oauth/exchange_token&approval_prompt=force&scope=activity:read_all&state=#{current_user.id}

    # After they log in and authorize, a request with needed params will be sent to the route calling this controller method. 

    # initial token exchange request 
    response = HTTP.post("https://www.strava.com/oauth/token?client_id=#{Rails.application.credentials.client_id}&client_secret=#{Rails.application.credentials.client_secret}&code=#{params[:code]}&scope=activity:read_all&grant_type=authorization_code")
    # pull tokens and expiration from response
    data = response.parse(:json)
    access_token = data['access_token']
    access_token_expiration = Time.at(data['expires_at'])
    refresh_token = data['refresh_token']
    # Save to db
    user = User.find_by(id: params['state']) # The user_id must be included in the original redirect as a query param (state=[user_id]) for it to be present in params here.
    user.strava_access_token = access_token
    user.strava_access_expiration = access_token_expiration
    user.strava_refresh_token = refresh_token
    user.save
    # send user back to app frontend
    redirect_to('http://localhost:8080?strava_initial_auth=true')
  end

  def index
    if current_user.strava_access_token
      # Check if access_token has expired
      if Time.now > current_user.strava_access_expiration    
        refresh_access_token(current_user)
      end
      # Request user data from Strava
      response = HTTP.headers(:Authorization => "Bearer #{current_user.strava_access_token}")
      .get("https://www.strava.com/api/v3/athlete/activities")
      strava_runs = response.parse(:json).select {|activity| activity['type'] == "Run"}
      imported_strava_run_ids = Run.where(user_id: current_user.id, is_strava_import: true).map {|run| run.strava_id}
      unimported_strava_runs = strava_runs.select {|run| !imported_strava_run_ids.include?(run["id"].to_s)}
      results_per_page = 3
      start_index = (params[:page].to_i - 1) * results_per_page
      end_index = start_index + results_per_page - 1

      p start_index
      p end_index
      render json: unimported_strava_runs[start_index..end_index]
    else
      render json: {message: "user account not linked to Strava"}
    end
  end

  def refresh_access_token(user)
    p 'refreshing'
    # send request for new tokens to Strava API
    response = HTTP.post("https://www.strava.com/api/v3/oauth/token?client_id=#{Rails.application.credentials.client_id}&client_secret=#{Rails.application.credentials.client_secret}&grant_type=refresh_token&refresh_token=#{current_user.strava_refresh_token}")
    data = response.parse(:json)
    # Pull necessary data
    access_token = data['access_token']
    access_token_expiration = Time.at(data['expires_at'])
    refresh_token = data['refresh_token']
    # save to user
    user.strava_access_token = access_token
    user.strava_access_expiration = access_token_expiration
    user.strava_refresh_token = refresh_token
    user.save
  end
  
  def destroy()
    user = current_user
    user.strava_access_token = nil
    user.strava_access_expiration = nil
    user.strava_refresh_token = nil
    user.save
  end
end
