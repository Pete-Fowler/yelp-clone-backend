require 'rest-client'
require 'dotenv'
require 'faker'
require 'pry'

puts "🌱 Seeding DB ..."

categories=["restaurants", "shopping", "nightlife", "active", "beautysvc", "auto", "homeservices"]
url = "https://api.yelp.com/v3/businesses/search?location=denver&limit=50"
businesses = []

Faker::Config.locale = 'en-US'

response = RestClient.get(url + "&categories=restaurants", headers = { Authorization: ENV['API_KEY'] })
restaurants = JSON.parse(response)["businesses"]
restaurants.each do |restaurant|
  Business.create(
    name: restaurant["name"],
    category: "restaurants",
    business_type: restaurant["categories"][0]["title"],
    address: restaurant["location"]["display_address"].join(', '),
    price: restaurant["price"],
    image_url: restaurant["image_url"],
    phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
    website: Faker::Internet.url, 
    transactions: restaurant["transactions"]
  )
end

response = RestClient.get(url + "&categories=shopping", headers = { Authorization: ENV['API_KEY'] })
shopping = JSON.parse(response)["businesses"]
shopping.each do |shop|
  Business.create(
    name: shop["name"],
    category: "shopping",
    business_type: shop["categories"][0]["title"],
    address: shop["location"]["display_address"].join(', '),
    price: shop["price"],
    image_url: shop["image_url"],
    phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
    website: Faker::Internet.url, 
    transactions: shop["transactions"]
  )
end

response = RestClient.get(url + "&categories=nightlife", headers = { Authorization: ENV['API_KEY'] })
nightlife = JSON.parse(response)["businesses"]
nightlife.each do |life|
  Business.create(
    name: life["name"],
    category: "nightlife", 
    business_type: life["categories"][0]["title"],
    address: life["location"]["display_address"].join(', '),
    price: life["price"],
    image_url: life["image_url"],
    phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
    website: Faker::Internet.url, 
    transactions: life["transactions"]
  )
end

response = RestClient.get(url + "&categories=active", headers = { Authorization: ENV['API_KEY'] })
active = JSON.parse(response)["businesses"]
active.each do |act|
  Business.create(
    name: act["name"],
    category: "active",
    business_type: act["categories"][0]["title"],
    address: act["location"]["display_address"].join(', '),
    price: act["price"],
    image_url: act["image_url"],
    phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
    website: Faker::Internet.url, 
    transactions: act["transactions"]
  )
end

response = RestClient.get(url + "&categories=beautysvc", headers = { Authorization: ENV['API_KEY'] })
beautysvc = JSON.parse(response)["businesses"]
beautysvc.each do |beauty|
  Business.create(
    name: beauty["name"],
    category: "beautysvc", 
    business_type: beauty["categories"][0]["title"],
    address: beauty["location"]["display_address"].join(', '),
    price: beauty["price"],
    image_url: beauty["image_url"],
    phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
    website: Faker::Internet.url, 
    transactions: beauty["transactions"]
  )
end

response = RestClient.get(url + "&categories=auto", headers = { Authorization: ENV['API_KEY'] })
auto = JSON.parse(response)["businesses"]
auto.each do |aut|
  Business.create(
    name: aut["name"],
    category: "auto",
    business_type: aut["categories"][0]["title"], 
    address: aut["location"]["display_address"].join(', '),
    price: aut["price"],
    image_url: aut["image_url"],
    phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
    website: Faker::Internet.url, 
    transactions: aut["transactions"]
  )
end

response = RestClient.get(url + "&categories=homeservices", headers = { Authorization: ENV['API_KEY'] })
homeservices = JSON.parse(response)["businesses"]
homeservices.each do |home|
  Business.create(
    name: home["name"],
    category: "home",
    business_type: "home",
    address: home["location"]["display_address"].join(', '),
    price: home["price"],
    image_url: home["image_url"],
    phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
    website: Faker::Internet.url, 
    transactions: home["transactions"]
  )
end

# businesses.each do |business|
#   Business.create(
#     name: business["name"],
#     business_type: business["categories"][0]["title"],
#     address: business["location"]["display_address"].join(', '),
#     price: business["price"],
#     image_url: business["image_url"],
#     phone_number: "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code}-#{Faker::PhoneNumber.subscriber_number(length: 4)}",
#     website: Faker::Internet.url, 
#     transactions: business["transactions"]
#   )
# end

20.times do
  User.create(
    username: Faker::Internet.username,
    profile_picture: "https://source.unsplash.com/400x400/?face?#{rand(1000).to_s}"
  )
end

1500.times do
  review = Faker::Restaurant.review

  review_stated_stars = review.match(/(\d)\ star/)

  stars = rand(1..5)
  stars = review_stated_stars[1].to_i.clamp(1, 5) unless review_stated_stars.nil?

  Review.create(
    user_id: User.all.pluck(:id).sample,
    business_id: Business.all.pluck(:id).sample,
    star_rating: stars,
    comment: review
  )
end

puts "✅ Done seeding!"
