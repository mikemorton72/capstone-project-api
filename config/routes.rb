Rails.application.routes.draw do
  # Users
  post "/users" => "users#create"
  get "/users" => "users#index"
  
  # Sessions
  post "/sessions" => "sessions#create"
  
  # Runs
  post "/runs" => "runs#create"
  
  # Follows
  post "/follows" => "follows#create"
  delete "/follows" => "follows#destroy" # this doesn't follow REST...review with Brian

  # Strava
  get "/exchange_token" => "strava_oauth#initial_authorization"

end
