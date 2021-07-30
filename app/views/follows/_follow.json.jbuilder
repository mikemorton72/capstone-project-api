json.follower do
  json.id follow.follower_id
  json.name User.find_by(id: follow.follower_id).name
end
json.followee do
  json.followee_id follow.followee_id
  json.name User.find_by(id: follow.followee_id).name
end