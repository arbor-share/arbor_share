class CarpoolPassenger < ApplicationRecord
  belongs_to :carpool
  belongs_to :passenger, foreign_key: 'passenger_id', class_name: :User
end
