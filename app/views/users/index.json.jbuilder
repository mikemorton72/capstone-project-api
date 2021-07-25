json.users @users do |user|
  json.name user.name
  json.email user.email
  json.number_of_runs user.runs.count
  json.followers user.followers, :name

end