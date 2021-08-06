json.id run.id
json.user run.user.name
json.title run.title
json.distance run.distance_miles
json.elapsed_time run.elapsed_time
json.comments run.comments do |comment|
  json.partial! comment, partial: 'comments/comment', as: :comment
end