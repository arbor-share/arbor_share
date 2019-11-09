require 'rails_helper'

describe MapboxService do
  it 'can return longitude and latitude of a given address' do
    user_1 = User.create!(full_name: "Jon", email: "jon@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
    address = Address.create!(owner: user_1, line_1: "1331 17th st", city: "Denver", state: "CO", zip: "80206", default: true)
    mapbox_service = MapboxService.new
    result = mapbox_service.get_coords(address)

    expect(result).to be_a(Hash)

    coords = result[:features].first[:center]
    expect(coords[0]).to be > -105
    expect(coords[0]).to be < -104.9
    expect(coords[1]).to be > 39.7
    expect(coords[1]).to be < 39.8
  end
end
