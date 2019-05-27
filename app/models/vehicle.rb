class Vehicle < ApplicationRecord
  belongs_to :owner, foreign_key: 'owner_id', class_name: :User

  enum fuel_type: %i[Gasoline Diesel]
  enum fuel_efficiency_unit: %i[MPG KPG]

  validates_presence_of %i[make model color year passenger_limit fuel_efficiency fuel_type fuel_efficiency_unit]
  validates :year, numericality: {
                     only_integer: true,
                     greater_than: 1878
                   }
  validates :passenger_limit, numericality: {
                                only_integer: true,
                                greater_than: 0
                              }
  validates :fuel_efficiency, numericality: {
                                greater_than: 0
                              }

  def self.make_default(id, owner)
    find_by(owner: owner, default: true).toggle!(:default)
    find(id).toggle!(:default)
  end
end
