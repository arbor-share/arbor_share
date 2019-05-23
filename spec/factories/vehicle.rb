FactoryBot.define do
  factory :vehicle do
    user
    make { Faker::Vehicle.make }
    model { Faker::Vehicle.model }
    color { Faker::Vehicle.color }
    year { Faker::Vehicle.year }
    fuel_efficiency { rand(1..100).to_s }
    fuel_type { rand(0..1).to_s }
    fuel_efficiency { rand(0..1).to_s }
    passenger_limit { rand(1..6) }
    image { 'https://www.renderhub.com/weeray/generic-car/generic-car-01.jpg' }
    default { true }
  end
end
