# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.destroy_all
Comment.destroy_all

150.times do
  p = Post.create(
    title: Faker::Name.unique.name,
    body: Faker::ChuckNorris.fact
  )

  if p.valid?
    rand(1..7).times do
    Comment.create(comment: Faker::Hacker.say_something_smart, post: p)
    end
  end
end

posts = Post.all
comments = Comment.all

puts "You've generated #{posts.count} posts into the database :)"
puts "You've generated #{comments.count} comments into the database :)"