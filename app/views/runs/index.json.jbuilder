json.array! @runs do |run|
  json.user run.user.name
  json.title run.title
  json.distance run.distance
  json.elapsed_time run.time_minutes
  json.comments run.comments do |comment|
    json.user_id User.find_by(id: comment.user_id).id
    json.user_name User.find_by(id: comment.user_id).name
    json.text comment.text
  end
end