class StravaOauthController < ApplicationController

  def initial_authorization
    # Front end sends user to (make sure to include user id in query params as 'state')
    # https://www.strava.com/oauth/authorize?client_id=68303&response_type=code&redirect_uri=http://localhost:3000/exchange_token&approval_prompt=force&scope=activity:read_all&state=#{current_user.id}

    # After they log in and authorize, a request with needed params will be sent to the route calling this controller method. 

    # initial token exchange request 
    response = HTTP.post("https://www.strava.com/oauth/token?client_id=68303&client_secret=#{Rails.application.credentials.client_secret}&code=#{params[:code]}&scope&grant_type=authorization_code")
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
    user.save!
    # send user back to app frontend
    redirect_to('http://localhost:8080')
  end

end
