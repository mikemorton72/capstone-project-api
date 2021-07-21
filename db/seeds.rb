
# Users
user_names = ['Mike', 'Sally', 'Bob', 'Sue', 'Bill', 'Anne', 'Sean', 'Lauren', 'Kevin', 'Jill', 'Jack', 'Erin', 'Dan', 'Brynn', 'Byron']
user_names.each do |user_name|
  user = User.new(
    name: user_name,
    email: "#{user_name.downcase}@website.com",
    password: 'password'
  )
  user.save
end

# Follows (has each user follow 6 others)
users = User.all
users.each do |user|
  all_others = []
  users.each do |another_user|
    if user != another_user
      all_others << another_user 
    end
  end
  all_others.shuffle!
  6.times do |i|
    Follow.create(followee_id: all_others[i].id, follower_id: user.id)
  end
end