# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create devise user for testing
# User.create(email:'admin@test.com', password:'coolguy', password_confirmation:'coolguy')

PublicActivity.enabled = false
# random db for first test:
2.times do 
    Trip.create([{
        title: Faker::FunnyName.three_word_name,
        description: Faker::TvShows::AquaTeenHungerForce.quote,
        user_id: User.first.id,
        # user: User.find_by(email: "admin@test.com"),
        brief_info: Faker::Quote.famous_last_words,
        duration: '5-Days-4-Nights',
        language: 'English',
        price: Faker::Number.between(from: 1000, to: 20000)
    }])
end
PublicActivity.enabled = true