# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "chargify", password: "qwerty123", password_confirmation: "qwerty123")
Subscription.create([{
  subscription_name: "Bronze Box",
  subscription_price: 1900,
  subscription_term: :month
},
{
  subscription_name: "Silver Box",
  subscription_price: 4900,
  subscription_term: :month
},
{
  subscription_name: "Gold Box",
  subscription_price: 9900,
  subscription_term: :month
}])