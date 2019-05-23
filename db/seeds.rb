# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_1 = User.create!(full_name: "Jon", email: "jon@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
user_2 = User.create!(full_name: "Erin", email: "erin@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :organizer, active: true)
user_3 = User.create!(full_name: "Noah", email: "noah@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :admin, active: true)
user_4 = User.create!(full_name: "Vincent", email: "vincent@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
user_5 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)

address_11 = Address.create!(owner: user_1, line_1: "123 Anywhere St", city: "Denver", state: "CO", zip: "80206", default: true)
address_12 = Address.create!(owner: user_1, line_1: "456 Nowhere St", city: "Denver", state: "CO", zip: "80206", default: false)
address_21 = Address.create!(owner: user_1, line_1: "123 Anywhere St", city: "New York", state: "NY", zip: "80206", default: true)
address_22 = Address.create!(owner: user_1, line_1: "456 Nowhere St", city: "New York", state: "NY", zip: "80206", default: false)
address_31 = Address.create!(owner: user_1, line_1: "123 Anywhere St", city: "Los Angeles", state: "CA", zip: "80206", default: true)
address_32 = Address.create!(owner: user_1, line_1: "456 Nowhere St", city: "Los Angeles", state: "CA", zip: "80206", default: false)

project_1 = Project.create!(title: "Go Green!", date: "2019-05-30", organizer: user_2, description: "Plant things.", active: true)
address_41 = Address.create!(owner: project_1, line_1: "At the trailhead", line_2: "Off I-70", city: "Frisco", state: "CO", zip: "80206")

vehicle_1 = Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 3, default: true)
vehicle_2 = Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "Blue", year: 2010, fuel_efficiency: 23, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 3, default: true)

carpool_1 = Carpool.create!(driver: user_1, project: project_1, vehicle: vehicle_1)

carpool_passenger_1 = CarpoolPassenger.create!(carpool: carpool_1, passenger: user_4)

user_block_1 = UserBlock.create!(blocking_user: user_1, blocked_user: user_5)
user_block_2 = UserBlock.create!(blocking_user: user_4, blocked_user: user_5)
