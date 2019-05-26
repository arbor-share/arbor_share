class Carpool < ApplicationRecord
  belongs_to :driver, foreign_key: 'driver_id', class_name: :User
  belongs_to :project
  belongs_to :vehicle

  has_many :carpool_passengers
  has_many :passengers, through: :carpool_passengers, class_name: :User

  def seats
    self.vehicle.passenger_limit
  end

  def available
    (seats - self.carpool_passengers.count)
  end

  def driver_name
    self.driver.full_name
  end

  def full?
    available.zero?
  end
end
