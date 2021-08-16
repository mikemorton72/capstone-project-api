Rails.application.routes.draw do
  # Users
  post "/users" => "users#create"
  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  
  # Sessions
  post "/sessions" => "sessions#create"
  
  # Runs
  get "/runs" => "runs#index"
  get "runs/:id" => "runs#show"
  post "/runs" => "runs#create"
  delete "/runs/:id" => "runs#destroy"

  # Comments
  post "/comments" => "comments#create"
  
  # Follows
  post "/follows/:followee_id" => "follows#create"
  delete "/follows/:followee_id" => "follows#destroy" # this doesn't follow REST...review with Brian

  # Strava
  get "/strava_oauth/exchange_token" => "strava_oauth#initial_authorization"
  get "/strava_oauth/runs" => "strava_oauth#index"
  delete "/strava_oauth" => "strava_oauth#destroy"

end
