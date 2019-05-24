require 'rails_helper'

RSpec.describe Carpool, type: :model do
  describe 'Relationships:' do
    it{ should belong_to(:driver) }
    it{ should belong_to(:project) }
    it{ should belong_to(:vehicle) }
    it{ should have_many(:passengers).through(:carpool_passengers) }
  end
end
