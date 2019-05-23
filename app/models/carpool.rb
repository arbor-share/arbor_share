class Carpool < ApplicationRecord
  belongs_to :driver, foreign_key: 'driver_id', class_name: :User
  belongs_to :project
  belongs_to :vehicle

  has_many :carpool_passengers
  has_many :passengers, through: :carpool_passengers, class_name: :User
end
