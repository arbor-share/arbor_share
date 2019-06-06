class CarpoolFacade
  attr_reader :driver, :passengers, :vehicle, :project
  def initialize(carpool)
    @driver = carpool.driver
    @passengers = carpool.passengers
    @vehicle = carpool.vehicle
    @project = carpool.project
  end

  def project_name
    @project.title
  end

  def driver_name
    @driver.full_name
  end

  def driver_email
    @driver.email
  end

  def center_coord(current_user)
    boundary = bounding_coords(current_user)
    lng = (boundary.first.first + boundary.last.first) / 2
    lat = (boundary.first.last + boundary.last.last) / 2
    [lng, lat]
  end

  def coord_format(user)
    map = MapboxService.new
    @_coords ||= if user == @driver
      route = @passengers.map do |person|
        person.format_coords
      end
      route << @project.format_coords
      driver_coords = route.prepend(@driver.format_coords)
      map.get_geo(driver_coords)
    else
      user_route = [user.format_coords, @project.format_coords]
      map.get_geo(user_route)
    end
  end

  def bounding_coords(user)
    [coord_format(user).first, coord_format(user).last]
  end
end
