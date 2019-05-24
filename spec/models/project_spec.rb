require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Relationships:' do
    it{ should belong_to(:organizer) }
  end

  describe 'Validations:' do
    it{ should validate_presence_of(:title) }
    it{ should validate_presence_of(:date) }
    it{ should validate_presence_of(:description) }
    it{ should validate_presence_of(:image) }
  end
end
