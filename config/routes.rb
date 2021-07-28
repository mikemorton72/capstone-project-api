Rails.application.routes.draw do
  # Users
  post "/users" => "users#create"
  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  
  # Sessions
  post "/sessions" => "sessions#create"
  
  # Runs
  get "/runs" => "runs#index"
  post "/runs" => "runs#create"
  delete "/runs/:id" => "runs#destroy"
  
  # Follows
  post "/follows" => "follows#create"
  delete "/follows/:followee_id" => "follows#destroy" # this doesn't follow REST...review with Brian

  # Strava
  get "/exchange_token" => "strava_oauth#initial_authorization"
  get "/strava_runs" => "strava_oauth#index"

end
