Rails.application.routes.draw do
  # Users
  post "/users" => "users#create"
  get "/users" => "users#index"
  
  # Sessions
  post "/sessions" => "sessions#create"
  
  # Runs
  post "/runs" => "runs#create"
  
  # Strava
  get "/exchange_token" => "strava_oauth#initial_authorization"

end
