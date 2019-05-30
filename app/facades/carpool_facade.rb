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
    current_user.format_coords
  end

  def coord_format(user)
    map = MapboxService.new
    if user == @driver
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
end
