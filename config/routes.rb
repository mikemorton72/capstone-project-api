Rails.application.routes.draw do
  # Users
  post "/users" => "users#create"
  get "/exchange_token" => "strava_oauth#initial_authorization"

  # Sessions
  post "/sessions" => "sessions#create"

  # Runs
  post "/runs" => "runs#create"
  
end
