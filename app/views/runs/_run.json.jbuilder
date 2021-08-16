json.id run.id
json.user run.user.name
json.user_image run.user.image
json.title run.title
json.distance run.distance_miles
json.elapsed_time run.elapsed_time
json.start_latitude run.start_latitude
json.start_longitude run.start_longitude
json.summary_polyline run.summary_polyline
json.is_strava_import run.is_strava_import
json.created_at run.created_at
json.comments run.comments do |comment|
  json.partial! comment, partial: 'comments/comment', as: :comment
end