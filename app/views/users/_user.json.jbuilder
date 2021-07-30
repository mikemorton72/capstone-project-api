json.id user.id
json.name user.name
json.email user.email
json.number_of_runs user.runs.count
json.total_miles user.total_miles
json.runs user.runs do |run|
  json.partial! run, partial: 'runs/run', as: :run
end
json.follower_ids user.followers, :id
json.followee_ids user.followees, :id