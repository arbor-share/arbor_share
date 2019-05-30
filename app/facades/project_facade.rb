class ProjectFacade
  attr_reader :title, :date, :image, :location, :carpools, :description
  def initialize(project)
    @title = project.title
    @description = project.description
    @date = project.date
    @image = project.image
    @location = project.location
    @carpools = project.carpools
  end

  def no_rides?
    @carpools.count.zero?
  end

  def check_carpool(carpool, user)
    carpool.full? || carpool.driver == user || carpool.passengers.include?(user)
  end

  def driver?
    @carpools.passengers
  end
end
