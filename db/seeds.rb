# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create devise user for heroku testing
# for admin: User.create(email:'admin@test.com', password:'coolguy', password_confirmation:'coolguy')
# for operator: # User.create(email:'operator01@test.com', password:'operator01', password_confirmation:'operator01')
# for client: # User.create(email:'client01@test.com', password:'client01', password_confirmation:'client01')
# PublicActivity.enabled = false
# # random db for first test:
# 2.times do 
#     Trip.create([{
#         title: Faker::FunnyName.three_word_name,
#         description: Faker::TvShows::AquaTeenHungerForce.quote,
#         # user_id: User.first.id,
#         user: User.find_by(email: "admin@test.com"),
#         brief_info: Faker::Quote.famous_last_words,
#         duration: '5-Days-4-Nights',
#         language: 'English',
#         price: Faker::Number.between(from: 1000, to: 20000)
#     }])
# end
# PublicActivity.enabled = true

#update seeds file for newest app db version:

# if User.find_by_email("admin01@test.com").nil?
#     admin = User.create!(email: "admin01@test.com", password: "coolguy", password_confirmation: "coolguy")
#     # admin.skip_confirmation!
#     admin.add_role(:admin) unless admin.has_role?(:admin)
#     admin.add_role(:operator) unless admin.has_role?(:operator)
# end
  
if User.find_by_email("operator01@test.com").nil?
    operator01 = User.create!(email: "operator01@test.com", password: "operator01", password_confirmation: "operator01")
    # studentteacher.skip_confirmation!
    operator01.add_role(:operator) unless operator01.has_role?(:operator)
    operator01.add_role(:client) unless operator01.has_role?(:client)
end
  
# if User.find_by_email("client01@test.com").nil?
#     client01 = User.create!(email: "client01@test.com", password: "client01", password_confirmation: "client01")
#     # client.skip_confirmation!
#     client01.add_role(:client) unless client01.has_role?(:client)
# end
  
#   PublicActivity.enabled = false
  
#   5.times do
#     Trip.create!([{
#         title: Faker::FunnyName.three_word_name,
#         description: Faker::TvShows::AquaTeenHungerForce.quote,
#         user: User.find_by(email: "admin@test.com"),
#         brief_info: Faker::Quote.famous_last_words,
#         duration: '1-Day',
#         language: 'English',
#         price: 0,
#         approved: true,
#         published: true
#     }])
#   end

#   5.times do
#     Trip.create!([{
#         title: Faker::FunnyName.three_word_name,
#         description: Faker::TvShows::AquaTeenHungerForce.quote,
#         user: User.find_by(email: "operator01@test.com"),
#         brief_info: Faker::Quote.famous_last_words,
#         duration: '1-Day',
#         language: 'Chinese(Simplified)',
#         price: 0,
#         approved: true,
#         published: true
#     }])
#   end
  
#   Trip.all.each do |trip|
#     10.times do
#       Itinerary.create!([{
#         title: Faker::Lorem.sentence(word_count: 3),
#         content: Faker::Lorem.sentence,
#         trip: trip
#       }])
#     end
  
#     Order.create!([{
#       user: User.find_by(email: "operator01@test.com"),
#       trip: trip
#     }])
  
#     Order.create!([{
#       user: User.find_by(email: "client01@test.com"),
#       trip: trip,
#       price: trip.price
#     }])
#   end
  
#   PublicActivity.enabled = true