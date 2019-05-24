require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Relationships:' do
    # organizer is a User
    it{ should belong_to(:organizer) }
    # location is an Address
    it{ should have_one(:location) }
    it{ should have_many(:carpools) }
  end

  describe 'Validations:' do
    it{ should validate_presence_of(:title) }
    it{ should validate_presence_of(:date) }
    it{ should validate_presence_of(:description) }
    it{ should validate_presence_of(:image) }
  end
end
