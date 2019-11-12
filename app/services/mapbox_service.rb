class MapboxService

  def get_coords(address)
    conn = Faraday.new('https://api.mapbox.com/geocoding/v5/mapbox.places/')
    response = conn.get("#{address_prep(address) + '.json?access_token=' + api_key}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_geo(coord_list)
    conn = Faraday.new('https://api.mapbox.com/optimized-trips/v1/mapbox/driving/')
    response = conn.get(coord_prep(coord_list)) do |r|
      r.params['access_token'] = api_key
      r.params['geometries'] = 'geojson'
      r.params['overview'] = 'full'
      r.params['source'] = 'first'
      r.params['destination'] = 'last'
      r.params['roundtrip'] = 'false'
    end
    geo_json = JSON.parse(response.body, symbolize_names: true)
    geo_json[:trips].first[:geometry][:coordinates]
  end

  private

  def api_key
    ENV['MAPBOX_TOKEN']
  end

  def address_prep(address)
    (address.line_1 + '%20' + address.city + '%20' + address.state + '%20' + address.zip).gsub(/[' ']/, '%20')
  end

  def coord_prep(coords)
    coords.map do |long, lat|
      "#{long},#{lat};"
    end.join.sub(/;\z/, '')
  end
end
