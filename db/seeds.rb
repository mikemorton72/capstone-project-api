
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