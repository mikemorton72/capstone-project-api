# # # Users
male_user_names = ['Mike', 'Sean', 'Dan', 'Jack', 'Niko', 'Tristan', 'Tony', 'Daniel', 'John', 'Byron', 'Michael', 'James', 'Robert', 'Jeremy', 'Nick', 'Matt', 'Orlando', 'Brandon', 'Mitch', 'Tim', 'Tom', 'Bert']
male_user_names.each do |user_name|
  user = User.new(
    name: user_name,
    email: "#{user_name.downcase}@website.com",
    password: 'password',
    image: "https://avatars.dicebear.com/api/male/#{user_name}.svg"
  )
  user.save!
end

female_user_names = ['Sue', 'Anne', 'Ellen', 'Shiela', 'Jeanne', 'Julie', 'Lauren', 'Jill', 'Erin', 'Brynn', 'Karen', 'Madeline', 'Julia', 'Adriana', 'Cynthia', 'Christina' 'Sally', 'Katie', 'Ellie']
female_user_names.each do |user_name|
  user = User.new(
    name: user_name,
    email: "#{user_name.downcase}@website.com",
    password: 'password',
    image: "https://avatars.dicebear.com/api/female/#{user_name}.svg"
  )
  user.save!
end


# # # Follows (has each user follows 6 others)
users = User.all
users.each do |follower|
  followee_ids = users.map {|followee| followee.id}
  followee_ids.delete(follower.id)
  followee_ids.shuffle!
  5.times do |i|
    Follow.create!(followee_id: followee_ids[i], follower_id: follower.id)
  end
end


# # # Runs (4 for each user)
user_ids = User.all.map{|user| user.id}
run_titles = ['Morning Run', 'Lunch Run', 'Afternoon Run', 'Night Run', 'Trail Run', 'Recovery Run', 'Interval Training', 'Easy Run', 'Park Run', 'Fast Run', 'Threshold Run', 'Fast Run', 'Neighborhood Run', 'Run Around the Block', 'Quick Run', 'Hard Run']
location_names = ['Chicago, IL', 'Palatine, IL', 'Charlotte, NC', 'Buffalo, NY', 'San Francisco, CA', 'Honolulu, Hawaii', 'Portland, OR', 'Nashville, TN', 'Austin, TX', 'Miami, FL', 'Atlanta, GA', 'Houston, TX', 'Dallas, TX', 'Palatine, IL', 'Cleveland, OH', 'Columbus, OH', 'Cincinnati, OH', 'Glen Ellyn, IL']
5.times do
  user_ids.each do |user_id|
    distance = rand(3000..10000)
    location_name = location_names.sample
    p location_name
    results = Geocoder.search(location_name).first
    if results
      coordinates = results.coordinates
      lat = coordinates[0]
      lng = coordinates[1]
    end
    Run.create!(
      user_id: user_id,
      title: run_titles.sample,
      distance: distance, # in meters
      elapsed_time: distance * rand(0.24..0.45), # in seconds
      location_name: location_name,
      start_latitude: lat,
      start_longitude: lng,
      is_strava_import: false
    )
  end
end

# # Comments (10 for each user)
comment_texts = ['Great pace', 'I ran there last week!','nice PR', 'Cool!','nice', 'Wow!', 'Keep it up', 'Nice!', 'Woah!', 'Amazing!', 'Nice improvement', 'Good effort', 'Very fast!', 'Congrats!', 'Great job', 'Neato!', 'Excellent', 'Noice!', 'I can run faster']
user_ids.each do |user_id|
  20.times do
    run = Run.all.sample
    Comment.create!(
      user_id: user_id,
      run_id: run.id,
      text: comment_texts.sample
    )
  end
end