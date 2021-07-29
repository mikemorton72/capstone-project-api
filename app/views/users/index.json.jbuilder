json.users @users do |user|
  json.name user.name
  json.email user.email
  json.total_miles user.total_miles
  json.followers user.followers, :id
  json.number_of_runs user.runs.count
end