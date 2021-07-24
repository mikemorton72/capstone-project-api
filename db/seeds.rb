# # Users
user_names = ['Mike', 'Sally', 'Bob', 'Sue', 'Bill', 'Anne', 'Sean', 'Lauren', 'Kevin', 'Jill', 'Jack', 'Erin', 'Dan', 'Brynn', 'Byron']
user_names.each do |user_name|
  user = User.new(
    name: user_name,
    email: "#{user_name.downcase}@website.com",
    password: 'password'
  )
  user.save!
end


# # Follows (has each user follows 6 others)
users = User.all
users.each do |follower|
  followee_ids = users.map {|followee| followee.id}
  followee_ids.delete(follower.id)
  followee_ids.shuffle!
  6.times do |i|
    Follow.create!(followee_id: followee_ids[i], follower_id: follower.id)
  end
end


# # Runs (4 for each user)
user_ids = User.all.map{|user| user.id}
run_titles = ['Morning Run', 'Lunch Run', 'Afternoon Run', 'Night Run', 'Trail Run', 'Recovery Run', 'Interval Training', 'Easy Run', 'Park Run', 'Fast Run', 'Threshold Run']
user_ids.each do |user_id|
  4.times do
    distance = rand(2..26)
    Run.create!(
      user_id: user_id,
      title: run_titles.sample,
      distance: distance, # in miles? maybe km
      elapsed_time: distance * 10 * 60, # in seconds assumes 10min/distance pace
    )
  end
end

# # Comments (10 for each user)
comment_texts = ['Great pace', 'I ran there last week!','nice PR', 'Cool!','nice', 'Wow!', 'Keep it up', 'Nice!', 'Woah!', 'Amazing!', 'Nice improvement', 'Good effort', 'Very fast!', 'Congrats!']
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