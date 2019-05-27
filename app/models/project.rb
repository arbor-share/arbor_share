class Project < ApplicationRecord
  belongs_to :organizer, foreign_key: 'organizer_id', class_name: :User
  has_one :location, as: :owner, class_name: :Address
  has_many :carpools

  validates_presence_of %i[title date description image]
  validate :date_must_be_current, on: [:create, :update]

  def date_must_be_current
    errors.add(:date, "cannot be in the past") if date && date < Date.today
  end
end
