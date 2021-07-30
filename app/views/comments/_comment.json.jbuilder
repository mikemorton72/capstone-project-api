json.user_id comment.user_id
json.user_name User.find_by(id: comment.user_id).name
json.text comment.text