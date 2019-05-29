class MapboxService

  def get_coords(address)
    conn = Faraday.new('https://api.mapbox.com/geocoding/v5/mapbox.places/')
    response = conn.get("#{address_prep(address) + '.json?access_token=' + api_key}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def api_key
    ENV['MAPBOX_TOKEN']
  end

  def address_prep(address)
    (address.line_1 + '%20' + address.city + '%20' + address.state + '%20' + address.zip).gsub(/[' ']/, '%20')
  end


  #   def get_email(github_handle)
  #   conn = Faraday.new('https://api.github.com/users/'\
  #     "#{github_handle}?access_token=#{@token}")
  #   response = conn.get
  #   JSON.parse(response.body, symbolize_names: true)
  # end
end
