json.user run.user.name
json.title run.title
json.distance run.distance
json.elapsed_time run.time_minutes
json.comments run.comments do |comment|
  json.partial! comment, partial: 'comments/comment', as: :comment
end