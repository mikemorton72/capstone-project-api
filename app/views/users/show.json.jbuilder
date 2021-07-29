json.name @user.name
json.email @user.email
json.number_of_runs @user.runs.count
json.total_miles @user.total_miles
json.runs @user.runs
json.followers @user.followers, :id
