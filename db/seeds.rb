# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.destroy_all
Comment.destroy_all
User.destroy_all

PASSWORD = "123"

super_user = User.create(
  name: "Admin",
  email: "test@test.com",
  password: PASSWORD,
  admin?: true
)

ethan_user = User.create(
  name: "Ethan",
  email: "ethan@ethan.com",
  password: PASSWORD,
  admin?: false
)

20.times do 
  name = Faker::Name.name
  User.create(
    name: name,
    email: "#{name}@fakeEmail.com",
    password: PASSWORD,
    admin?: false
  )
end

users = User.all


150.times do

  created_at = Faker::Date.backward(days: 365 * 5)

  p = Post.create(
    title: Faker::Name.unique.name,
    body: Faker::ChuckNorris.fact,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )

  if p.valid?
    rand(1..7).times do
    Comment.create(comment: Faker::Hacker.say_something_smart, post: p, user: users.sample)
    end
  end
end

posts = Post.all
comments = Comment.all

puts "You've generated #{posts.count} posts into the database :)"
puts "You've generated #{comments.count} comments into the database :)"
puts "You've generated #{users.count} users into the database :)"