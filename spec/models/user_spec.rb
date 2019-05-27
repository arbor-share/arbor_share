require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships:' do
    it{ should have_many(:addresses) }
    it{ should have_many(:vehicles)
               .with_foreign_key('owner_id') }
    it{ should have_many(:blocked_users)
               .through(:user_blocks) }

    # carpools are Carpools where the User is a driver
    it{ should have_many(:carpools)
               .with_foreign_key('driver_id') }

    # rides are Carpools where the User is a passenger
    it{ should have_many(:rides)
               .through(:carpool_passengers) }
  end

  describe 'Validations:' do
    it{ should validate_presence_of(:email) }

    it{ should allow_values('test@test.com',
                            'test@test.co.uk',
                            'te-st.us_er+filter@gmail.com').for(:email) }

    it{ should_not allow_values('test.com',
                                'test@test',
                                'nothankyou',
                                '').for(:email) }

    it{ should define_enum_for(:role)
               .with_values([:default, :organizer, :admin]) }
  end
  
    describe 'instance methods' do
    describe '#default_vehicle' do
      it 'returns the default vehicle of a user' do
        user_1 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
        Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 2, default: false)
        def_vehicle = Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 2, default: true)

        expect(user_1.default_vehicle).to eq(def_vehicle)
      end
    end

    describe '#has_address?' do
      it 'gives a boolean if the user has an address attatched to them' do
        user_1 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
        user_2 = User.create!(full_name: "man", email: "man@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
        Address.create!(owner: user_1, line_1: "123 Anywhere St", city: "Denver", state: "CO", zip: "80206", default: true)

        expect(user_1.has_address?).to eq(true)
        expect(user_2.has_address?).to eq(false)
      end
    end
end
