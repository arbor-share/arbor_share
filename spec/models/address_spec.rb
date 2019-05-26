require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Relationships:' do
    # Address should have an owner.
    # Users may own multiple addresses:
    #   User.addresses
    # Projects may own a single address, as 'location':
    #   Project.location
    it{ should belong_to(:owner) }
  end

  describe 'Validations:' do
    it{ should define_enum_for(:state) }
    it{ should validate_presence_of(:line_1) }
    # line_2 is not required
    it{ should validate_presence_of(:city) }
    it{ should validate_presence_of(:state) }
    it{ should validate_presence_of(:zip) }
  end
end
