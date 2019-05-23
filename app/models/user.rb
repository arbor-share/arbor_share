class User < ApplicationRecord
  has_many :addresses, as: :owner
  has_many :vehicles, foreign_key: 'owner_id'

  has_many :blocked_users, through: :user_blocks
  has_many :carpools, foreign_key: 'driver_id'

  enum role: %i[default organizer admin]
end
