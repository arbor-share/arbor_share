class Project < ApplicationRecord
  belongs_to :organizer, foreign_key: 'organizer_id', class_name: :User
  has_one :location, as: :owner, class_name: :Address
  has_many :carpools
end
