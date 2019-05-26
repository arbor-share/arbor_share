class Project < ApplicationRecord
  belongs_to :organizer, foreign_key: 'organizer_id', class_name: :User
  has_one :location, as: :owner, class_name: :Address
  has_many :carpools

  validates_presence_of %i[title date description image]
  validate :date_must_be_current, on: :create

  def date_must_be_current
    errors.add(:date, "cannot be in the past") if date && date < Date.today
  end
  
  def self.sorted(sort = nil)
    if sort == 'a-z'
      Project.where(active: true).order(:title)
    elsif sort == 'needs_driver'
      projects = Project.where(active: true).order(:date)
      projects.find_all do |project|
        project.carpools.empty?
      end
    else
      Project.where(active: true).order(:date)
    end
  end
end
