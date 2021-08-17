json.id user.id
json.image user.image
json.name user.name
json.email user.email
json.number_of_runs user.runs.count
json.total_miles user.total_miles
json.follower_ids user.followers, :id
json.followee_ids user.followees, :id