class User < ApplicationRecord
  has_many :addresses, -> { order(default: :desc, id: :desc) }, as: :owner
  has_many :vehicles, -> { order(default: :desc, id: :desc) }, foreign_key: 'owner_id'

  has_many :user_blocks
  has_many :blocked_users, through: :user_blocks

  has_many :carpools, foreign_key: 'driver_id'
  has_many :carpool_passengers
  has_many :rides, through: :carpool_passengers, class_name: :Carpool

  enum role: %i[default organizer admin]

  validates :email,
            presence: true,
            format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  def default_vehicle
    self.vehicles.find_by(default: true)
  end

  def default_address
    self.addresses.find_by(default: true)
  end

  def needs_default?(child)
    case child
    when :vehicle then self.default_vehicle.nil?
    when :address then self.default_address.nil?
    end
  end

  def has_address?
    self.addresses.count > 0
  end

  def add_vehicle(params)
    Vehicle.create(params.merge({
                    owner: self,
                    default: needs_default?(:vehicle)
                  }))
  end

  def add_address(params)
    address = Address.new(params.merge({
                    owner: self,
                    default: needs_default?(:address)
                  }))

    if address.latitude.nil? || address.longitude.nil?
      geocode = MapboxService.new
      longitude,latitude = geocode.get_coords(address)[:features].first[:center]
      address.update(longitude: longitude, latitude: latitude)
      address.save
    end
  end

  def format_coords
    addr = self.default_address
    [addr.longitude.to_f, addr.latitude.to_f]
  end

  def in_carpool?(carpool)
    carpool.driver == self || carpool.passengers.include?(self)
  end

  def is_driver_for?(project)
    driving_to_projects.include?(project)
  end

  def driving_to_projects
    @_driving_to_projects ||= Project.joins(:carpools).where(carpools: {driver: self})
  end
end
