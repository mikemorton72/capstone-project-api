# # Users
user_names = ['Mike', 'Sally', 'Bob', 'Sue', 'Bill', 'Anne', 'Sean', 'Lauren', 'Kevin', 'Jill', 'Jack', 'Erin', 'Dan', 'Brynn', 'Byron', 'Michael', 'Karen', 'James', 'Madeline', 'Jackson', 'Julia', 'Tracy', 'Robert', 'Jeremy', 'Greg', 'Cecily', 'Nick', 'Matt', 'Adriana', 'Orlando' ,'Cynthia', 'Zach', 'Brandon', 'Mitch', 'Tim', 'Tom', 'Christina', 'Bert']
user_names.each do |user_name|
  user = User.new(
    name: user_name,
    email: "#{user_name.downcase}@website.com",
    password: 'password',
    image: "https://avatars.dicebear.com/api/male/#{user_name}.svg"
  )
  user.save!
end


# # Follows (has each user follows 6 others)
users = User.all
users.each do |follower|
  followee_ids = users.map {|followee| followee.id}
  followee_ids.delete(follower.id)
  followee_ids.shuffle!
  5.times do |i|
    Follow.create!(followee_id: followee_ids[i], follower_id: follower.id)
  end
end


# # Runs (4 for each user)
user_ids = User.all.map{|user| user.id}
run_titles = ['Morning Run', 'Lunch Run', 'Afternoon Run', 'Night Run', 'Trail Run', 'Recovery Run', 'Interval Training', 'Easy Run', 'Park Run', 'Fast Run', 'Threshold Run', 'Fast Run']
run_locations = [[42.1105779, -88.0336888], [41.8755616, -87.6244212], [34.851354, -82.3984882], [35.2272086, -80.8430827], [30.2711286, -97.7436995], [37.7790262, -122.419906], [47.6038321, -122.3300624], [39.1014537, -84.5124602], [38.0464066, -84.4970393], [43.0349931, -87.922497], [43.0393671, -89.3870443985615], [42.7876022, -86.1090828], [42.3800209, -88.2420315], [33.7849591, -84.442163], [25.7741728, -80.19362], [36.1565461, -86.77474161400752], [29.7589382, -95.3676974], [32.7762719, -96.7968559], [39.7284945, -121.8374777], [40.43624385, -86.92673255999318], [33.5859518, -7.6738855], [43.6166163, -116.200886], [45.5202471, -122.6741949], [5.3428475, -72.3959849]]
5.times do
  user_ids.each do |user_id|
    distance = rand(3000..10000)
    run_location = run_locations.sample
    lat = run_location[0]
    lng = run_location[1]
    Run.create!(
      user_id: user_id,
      title: run_titles.sample,
      distance: distance, # in meters
      elapsed_time: distance * rand(0.24..0.45), # in seconds
      start_latitude: lat,
      start_longitude: lng,
      is_strava_import: false
    )
  end
end

# # Comments (10 for each user)
comment_texts = ['Great pace', 'I ran there last week!','nice PR', 'Cool!','nice', 'Wow!', 'Keep it up', 'Nice!', 'Woah!', 'Amazing!', 'Nice improvement', 'Good effort', 'Very fast!', 'Congrats!', 'Great job', 'Neato!', 'Excellent', 'Noice!']
user_ids.each do |user_id|
  10.times do
    run = Run.all.sample
    Comment.create!(
      user_id: user_id,
      run_id: run.id,
      text: comment_texts.sample
    )
  end
end