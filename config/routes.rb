Rails.application.routes.draw do
  # Users
  post "/users" => "users#create"
  

  # Sessions
  post "/sessions" => "sessions#create"

  # Runs
  post "/runs" => "runs#create"


end
