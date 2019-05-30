require 'rails_helper'

describe MapboxService do
  it 'can return longitude and latitude of a given address' do
    user_1 = User.create!(full_name: "Jon", email: "jon@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
    address = Address.create!(owner: user_1, line_1: "1331 17th st", city: "Denver", state: "CO", zip: "80206", default: true)
    mapbox_service = MapboxService.new
    result = mapbox_service.get_coords(address)

    expect(result).to be_a(Hash)
    expect(result[:features].first[:center]).to eq([-104.99625, 39.75109])
  end
end
