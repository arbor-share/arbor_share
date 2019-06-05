# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CarpoolPassenger.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(CarpoolPassenger.table_name)
Carpool.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(Carpool.table_name)
Vehicle.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(Vehicle.table_name)
Address.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(Address.table_name)
Project.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(Project.table_name)
UserBlock.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(UserBlock.table_name)
User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)

rng = Random.new(95645032351715211055821224457215536482)

user_1 = User.create!(full_name: "Jon", email: "jon@example.com", about: "I am super cool user person thanx.", avatar_image: 'https://lh4.googleusercontent.com/-Z1B1qMSGKh4/AAAAAAAAAAI/AAAAAAAAADA/3TMpm2XMghg/photo.jpg', google_token: nil, google_id: ENV['USER_1_GID'], role: :default, active: true)
user_2 = User.create!(full_name: "Erin", email: "erin@example.com", about: "I am sooo hip.", avatar_image: 'https://lh6.googleusercontent.com/-J9dEbNBA8oQ/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rcDxX2elApRbpb7sH4x5IKRPn6KMw/mo/photo.jpg', google_token: nil, google_id: ENV['USER_2_GID'], role: :organizer, active: true)
user_3 = User.create!(full_name: "Noah", email: "noah@example.com", about: "UTTER GIBBERISH", avatar_image: 'https://lh4.googleusercontent.com/-XKSoVNGu0Mg/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rcDmtHaF7LzPOpE1gd0kD3sjpNrUw/mo/photo.jpg', google_token: nil, google_id: ENV['USER_3_GID'], role: :admin, active: true)
user_4 = User.create!(full_name: "Vincent", email: "vincent@example.com", about: "<insert lorem ipsum text here>", avatar_image: 'https://lh4.googleusercontent.com/-uv3DmBQVDP8/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rf5OHMgfo_Z8d0u__K69OEVhj6NKw/mo/photo.jpg', google_token: nil, google_id: ENV['USER_4_GID'], role: :default, active: true)
user_5 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "I'm a jerk. Any resemblence to real persons is unfortunate and should be mitigated by said real persons.", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)

address_11 = Address.create!(owner: user_1, line_1: "Civic Center Station", line_2: "Along Colfax westbound", city: "Denver", state: "CO", zip: "80202", default: true, longitude: '-104.9870', latitude: '39.7402')
address_12 = Address.create!(owner: user_1, line_1: "Union Station", line_2: "Wynkoop and 17th", city: "Denver", state: "CO", zip: "80202", default: false, longitude: '-104.9997', latitude: '39.7528')
address_21 = Address.create!(owner: user_2, line_1: "Central Park S and 7th", city: "New York", state: "NY", zip: "10019", default: true, longitude: '-73.9790', latitude: '40.7669')
address_22 = Address.create!(owner: user_2, line_1: "World Trade Center Memorial", city: "New York", state: "NY", zip: "10007", default: false, longitude: '-74.0122', latitude: '40.7115')
address_31 = Address.create!(owner: user_3, line_1: "Dodgers Stadium parking lot", city: "Los Angeles", state: "CA", zip: "90099", default: true, longitude: '-118.2411', latitude: '34.0682')
address_32 = Address.create!(owner: user_3, line_1: "Union Station loading area", line_2: "West side", city: "Los Angeles", state: "CA", zip: "90099", default: false, longitude: '-118.2368', latitude: '34.0561')
address_41 = Address.create!(owner: user_4, line_1: "Civic Center Station", line_2: "Along Colfax westbound", city: "Denver", state: "CO", zip: "80202", default: false, longitude: '-104.9870', latitude: '39.7402')
address_42 = Address.create!(owner: user_4, line_1: "Union Station", line_2: "Wynkoop and 17th", city: "Denver", state: "CO", zip: "80202", default: true, longitude: '-104.9997', latitude: '39.7528')

project_1 = Project.create!(title: "Colorado Trail Restoration", date: 2.weeks.from_now, organizer: user_2, description: "EXAMPLE PROJECT - DESCRIPTION MOST LIKELY DOES NOT ACCURATELY DESCRIBE ANY REAL PLACE. The Colorado Trail has a 0.2 mile section which has been heavily eroded and is in desperate need of renovation. Come help us rebuild the base and seed nearby ground cover to help prevent future erosion.", active: true, image: 'https://picsum.photos/id/1018/400/300')
address_p1_1 = Address.create!(owner: project_1, line_1: "Trailhead Parking Lot", line_2: "Platte River Rd", city: "Sedalia", state: "CO", zip: "80135", longitude: '-105.17264859140049', latitude: '39.4075517143136')

project_2 = Project.create!(title: "Dome Rock Loop Trail Extension", date: 8.days.from_now, organizer: user_2, description: "EXAMPLE PROJECT - DESCRIPTION MOST LIKELY DOES NOT ACCURATELY DESCRIBE ANY REAL PLACE. We will be adding an extension loop to the Dome Rock Loop Trail, which will reach out to a new overlook. From here, we will have fantastic views of both Dome Rock and Pike's Peak, and typical weather should permit seasonal access from very early spring through late fall. This project will span multiple weeks, so please check the date of this copy before signing up.", active: true, image: 'https://picsum.photos/id/136/400/300')
address_p2_1 = Address.create!(owner: project_2, line_1: "Trailhead Parking Lot", line_2: "Four Mile Rd", city: "Divide", state: "CO", zip: "80814", longitude: '-105.17404416912477', latitude: '38.83809324888048')

project_3 = Project.create!(title: "Lost Creek Wilderness Erosion Mitigation", date: 11.weeks.from_now, organizer: user_2, description: "EXAMPLE PROJECT - DESCRIPTION MOST LIKELY DOES NOT ACCURATELY DESCRIBE ANY REAL PLACE. Natural runoff patterns are creating streams across the trail at several locations, which is leading to high erosion. We will be installing small culverts at three such crossings to prevent them washing out the trail. Lunch will be provided by the project organizer, so please make sure to RSVP with Fictional Volunteer Organization to make sure we bring enough for you!", active: true, image: 'https://picsum.photos/id/1016/400/300')
address_p3_1 = Address.create!(owner: project_3, line_1: "Rolling Creek Trailhead", line_2: "Near Wellington Lake Rd", city: "Bailey", state: "CO", zip: "80421", longitude: '-105.40276551346462', latitude: '39.33589658403696')

project_4 = Project.create!(title: "Clear Deadfall at Maxwell Falls Trail", date: 47.days.from_now, organizer: user_2, description: "EXAMPLE PROJECT - DESCRIPTION MOST LIKELY DOES NOT ACCURATELY DESCRIBE ANY REAL PLACE. Over the winter we had an exceptional number of trees fall across and near the trail. We will need to clear these out. Project organizers will be bringing chainsaws and trimming equipment, so you will not need to bring your own. Please bring work gloves though, as the trees are very splintery.", active: false, image: 'https://picsum.photos/id/1028/400/300')
address_p4_1 = Address.create!(owner: project_4, line_1: "Trailhead Parking Lot", line_2: "S Brook Forest Rd", city: "Evergreen", state: "CO", zip: "80439", longitude: '-105.3609175079507', latitude: '39.58265828796877')

project_5 = Project.create!(title: "Dome Rock Loop Trail Extension", date: 15.days.from_now, organizer: user_2, description: "EXAMPLE PROJECT - DESCRIPTION MOST LIKELY DOES NOT ACCURATELY DESCRIBE ANY REAL PLACE. We will be adding an extension loop to the Dome Rock Loop Trail, which will reach out to a new overlook. From here, we will have fantastic views of both Dome Rock and Pike's Peak, and typical weather should permit seasonal access from very early spring through late fall. This project will span multiple weeks, so please check the date of this copy before signing up.", active: true, image: 'https://picsum.photos/id/136/400/300')
address_p5_1 = Address.create!(owner: project_5, line_1: "Trailhead Parking Lot", line_2: "Four Mile Rd", city: "Divide", state: "CO", zip: "80814", longitude: '-105.17404416912477', latitude: '38.83809324888048')

project_6 = Project.create!(title: "National Trails Day Celebration!", date: "2019-06-01", organizer: user_2, description: "EXAMPLE PROJECT - DESCRIPTION MOST LIKELY DOES NOT ACCURATELY DESCRIBE ANY REAL PLACE. Come out and enjoy outdoor trails in celebration of National Trails Day! No volunteer work is organized for this event, so please use this 'project' as a collection place to organize carpools to your favorite trails.", active: true, image: 'https://picsum.photos/id/17/400/300')
address_p6_1 = Address.create!(owner: project_6, line_1: "Trailhead Parking Lot", line_2: "Four Mile Rd", city: "Divide", state: "CO", zip: "80814", longitude: '-104.9888455783472', latitude: '39.73926913741266')

vehicle_1 = Vehicle.create!(owner: user_1, make: "Honda", model: "Insight", color: "White", year: 2019, fuel_efficiency: 45, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 3, default: true)
vehicle_2 = Vehicle.create!(owner: user_1, make: "Chevy", model: "Suburban", color: "Blue", year: 1988, fuel_efficiency: 12, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 8, default: false)

carpool_1 = Carpool.create!(driver: user_1, project: project_1, vehicle: vehicle_1)

carpool_passenger_1 = CarpoolPassenger.create!(carpool: carpool_1, passenger: user_4)

user_block_1 = UserBlock.create!(blocking_user: user_1, blocked_user: user_5)
user_block_2 = UserBlock.create!(blocking_user: user_4, blocked_user: user_5)

names = %w[Nicolas Luke Renato Patricia Renaldo Dennis Hong Thanh Leif Elton Mohammed Valentin Rosendo Cesar Charley Kerry Dewey Noble Gerard Oliver Brad Chance Doyle Dewayne Martin Marvin Jerrell Hipolito Elliot Leroy]
names += %w[Damaris Shaunte Santana Albertha Samara Malinda Ouida Melaine Yun Melony Rosalina Lasandra Kirstin Carmon Obdulia Zenobia Yolande Kenda Abigail Gisele Deane Cherlyn Elizabet Venetta Jerlene Pearlene Vania Tish Tisa Rachel]
last_names = %w[Astin Atkinson Pouncy Baumann Merriweather Vanderveen Altizer Alexandria Tomson Trott Lefler Mckoy Reel Stearn Crumb Burley Hitchings Padgett Stephenson Delcambre Lovelace Rascon Moretti Sher Haller Hulings Brent Anzalone Salamanca Awad Kealoha Chock Crayton Cobos Toribio Satterfield Diggs Cushenberry Mcentyre Montgomery Shorter Kreiner Stanley Harrelson Ranieri Mcelfresh Fiecke Mastroianni Barlowe Postma]
images = [0,1,10,100,1000,1001,1002,1003,1004,1005,1006,1008,1009,101,1010,1011,1012,1013,1014,1015,1016,1018,1019,102,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,103,1031,1032,1033,1035,1036,1037,1038,1039,104,1040,1041,1042,1043,1044,1045,1047,1048,1049,1050,1051,1052,1053,1054,1055,1056]

demo_users = names.map do |name|
  user = User.create!(full_name: "#{name} #{last_names.sample(random: rng)}",
  email: "#{name.downcase}@example.com",
  about: "I am a demo user.",
  avatar_image: "https://picsum.photos/id/#{images.shift}/160",
  google_token: nil,
  google_id: nil,
  role: :default,
  active: true)
  Address.create!(owner: user, line_1: "At #{name}'s favorite place", city: "Denver", state: "CO", zip: "80802", default: true, longitude: rng.rand((-105.5000)..(-104.5000)).to_s, latitude: rng.rand(39.7000..39.8000).to_s)
  user
end

projects = [project_1, project_2, project_3, project_5, project_6]
carpools = []

drivers = demo_users.sample(12, random: rng)
drivers.each do |driver|
  vehicle = Vehicle.create!(owner: driver, make: "Honda", model: "Civic", color: "Silver", year: 2012, fuel_efficiency: 35, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: rng.rand(2..5), default: true)
  undriven = projects.dup
  (1..rng.rand(1..2)).each do |i|
    carpools << Carpool.create!(driver: driver, project: undriven.delete_at(rng.rand(0..(undriven.count-1))), vehicle: vehicle)
  end
end

carpools.each do |carpool|
  potential_passengers = demo_users.dup
  potential_passengers.delete(carpool.driver)
  (1..rng.rand(0..carpool.vehicle.passenger_limit)).each do |i|
    CarpoolPassenger.create!(carpool: carpool, passenger: potential_passengers.delete_at(rng.rand(0..(potential_passengers.count-1))))
  end
end
