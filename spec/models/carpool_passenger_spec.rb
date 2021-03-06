require 'rails_helper'

RSpec.describe CarpoolPassenger, type: :model do
  describe 'Relationships:' do
    # passengers are Users
    it{ should belong_to(:passenger) }
    it{ should belong_to(:carpool) }
  end
end
