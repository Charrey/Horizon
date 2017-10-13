# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!([{username: "alice", email: "alice@email.com", password: "password", password_confirmation: "password"}])
User.create!([{username: "bob", email: "bob@email.com", password: "password", password_confirmation: "password"}])
Roleplay.create!([{user: User.find_by_username("alice"), name: "Overwatch (18+ only)", image: File.new("/home/charrey/Desktop/sample.png"), description: "Only for 18+ people"}])
Roleplay.create!([{user: User.find_by_username("bob"), name: "Drakonite", image: File.new("/home/charrey/Desktop/sample.png"), description: "Very good medieval RP"}])
Character.create!([{name: "Widowmaker", description: "French person that is actually also evil", user: User.find_by_username("alice"), roleplay: Roleplay.find_by_name("Overwatch (18+ only)")}])
Character.create!([{name: "Mary", description: "Attractive and capable member of the Guard", user: User.find_by_username("alice"), roleplay: Roleplay.find_by_name("Drakonite")}])