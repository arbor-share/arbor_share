class Vehicle < ApplicationRecord
  belongs_to :owner, foreign_key: 'owner_id', class_name: :User

  enum fuel_type: %i[Gasoline Diesel]
  enum fuel_efficiency_unit: %i[MPG KPG]
end
