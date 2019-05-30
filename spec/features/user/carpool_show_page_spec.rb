require 'rails_helper'

describe 'As a logged in user' do
  before :each do
    @user_1 = User.create!(full_name: "Jon", email: "jon@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
    @user_2 = User.create!(full_name: "Erin", email: "erin@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :organizer, active: true)
    @user_3 = User.create!(full_name: "Noah", email: "noah@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :admin, active: true)
    @user_4 = User.create!(full_name: "Vincent", email: "vincent@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)

    @address_11 = Address.create!(owner: @user_1, line_1: "123 Anywhere St", city: "Denver", state: "CO", zip: "80206", default: true, longitude: '-100.99625', latitude: '40.75109')
    @address_12 = Address.create!(owner: @user_2, line_1: "456 Nowhere St", city: "Denver", state: "CO", zip: "80206", default: true, longitude: '-14.99625', latitude: '9.75109')
    @address_13 = Address.create!(owner: @user_3, line_1: "084 Nowhere St", city: "Denver", state: "CO", zip: "80206", default: true, longitude: '-104.343', latitude: '39.123')
    @address_14 = Address.create!(owner: @user_4, line_1: "0483 Nowhere St", city: "Denver", state: "CO", zip: "80206", default: true, longitude: '-104.925', latitude: '39.79')

    @project_1 = Project.create!(title: "Go Green!", date: "2019-05-30", organizer: @user_3, description: "Plant things.", active: true, image: 'https://picsum.photos/id/1018/400/300')
    @address_41 = Address.create!(owner: @project_1, line_1: "At the trailhead", line_2: "Off I-70", city: "Frisco", state: "CO", zip: "80206", longitude: '-104.99625', latitude: '39.75109')

    @vehicle_1 = Vehicle.create!(owner: @user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 3, default: true)
    @carpool_1 = Carpool.create!(driver: @user_1, project: @project_1, vehicle: @vehicle_1)
    @carpool_passenger_1 = CarpoolPassenger.create!(carpool: @carpool_1, passenger: @user_4)
  end
  it 'allows me to see a list of people in my carpool' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit carpool_path(@carpool_1)

    expect(page).to have_content("Driver: #{@user_1.full_name} - Email: #{@user_1.email}")
    expect(page).to have_content("Passenger: #{@user_4.full_name} - Email: #{@user_4.email}")
    expect(page).to_not have_content("Passenger: #{@user_2.full_name} - Email: #{@user_2.email}")
    expect(page).to have_css('.map')
  end
end
