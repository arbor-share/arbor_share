class MapboxService

  def get_coords(address)
    conn = Faraday.new('https://api.mapbox.com/geocoding/v5/mapbox.places/')
    response = conn.get("#{address_prep(address) + '.json?access_token=' + api_key}")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def api_key
    ENV['MAPBOX_TOKEN']
  end

  def address_prep(address)
    (address.line_1 + '%20' + address.city + '%20' + address.state + '%20' + address.zip).gsub(/[' ']/, '%20')
  end
end
