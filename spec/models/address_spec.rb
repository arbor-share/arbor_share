require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Relationships:' do
    it{ should belong_to(:owner) }
  end

  describe 'Validations:' do
    it{ should define_enum_for(:state) }
    it{ should validate_presence_of(:line_1) }
    it{ should validate_presence_of(:city) }
    it{ should validate_presence_of(:state) }
    it{ should validate_presence_of(:zip) }
  end
end
