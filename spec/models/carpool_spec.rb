require 'rails_helper'
describe Carpool do
  describe 'Relationships:' do
    # driver is a User
    it{ should belong_to(:driver) }
    it{ should belong_to(:project) }
    it{ should belong_to(:vehicle) }
    # passengers are Users
    it{ should have_many(:passengers).through(:carpool_passengers) }
  end
  
  describe 'instance methods' do
    before :each do
      @organizer = User.create(full_name: 'Project Organizer', email: 'organizer@email.com', about: 'A little about myself, very little', avatar_image: 'link to image', google_token: 'google token', google_id: 1, role: 1, active: true)
      @project1 = Project.create(title: 'Project 1', date: 1.week.from_now, description: 'Description of Project 1', image: 'http://clipart-library.com/image_gallery/104074.png', organizer: @organizer, active: true)
      @user = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
      @vehicle = Vehicle.create!(owner: @user, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 3, default: true)
      @carpool = Carpool.create!(driver: @user, project: @project1, vehicle: @vehicle)
    end

   describe '#available' do
     it 'gives a count of the availble seats for a user' do
       user_2 = User.create!(full_name: "Erin", email: "erin@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :organizer, active: true)
       CarpoolPassenger.create!(carpool: @carpool, passenger: user_2)

       expect(@carpool.available).to eq(@vehicle.passenger_limit - 1)
     end
   end

   describe '#seats' do
     it 'gives a count of all seats for a carpool' do
       expect(@carpool.seats).to eq(@vehicle.passenger_limit)
     end
   end

   describe '#driver_name' do
     it 'gives the drivers name' do
       expect(@carpool.driver.full_name).to eq(@carpool.driver_name)
     end
   end
  end
end
