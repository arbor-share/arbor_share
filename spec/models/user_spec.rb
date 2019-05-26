require 'rails_helper'

RSpec.describe User, type: :model do

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
end
