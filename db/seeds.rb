
# Users
user_names = ['Mike', 'Sally', 'Bob', 'Sue', 'Bill', 'Anne', 'Sean', 'Lauren', 'Kevin', 'Jill', 'Jack', 'Erin', 'Dan', 'Brynn', 'Byron']
user_names.each do |user_name|
  user = User.new(
    name: user_name,
    email: "#{user_name.downcase}@website.com",
    password: 'password'
  )
  user.save!
end

# Follows (has each user follow 6 others)
users = User.all
users.each do |follower|
  followee_ids = users.map {|followee| followee.id}
  followee_ids.delete(follower.id)
  followee_ids.shuffle!
  6.times do |i|
    Follow.create!(followee_id: followee_ids[i], follower_id: follower.id)
  end
end