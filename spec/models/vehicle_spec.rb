require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'Relationships:' do
    it{ should belong_to(:owner) }
  end

  describe 'Validations:' do
    it{ should validate_presence_of(:make) }
    it{ should validate_presence_of(:model) }
    it{ should validate_presence_of(:color) }
    it{ should validate_presence_of(:year) }
    it{ should validate_numericality_of(:year) }
    it{ should validate_presence_of(:passenger_limit) }
    it{ should validate_numericality_of(:passenger_limit) }

    it{ should validate_presence_of(:fuel_efficiency) }
    it{ should validate_numericality_of(:fuel_efficiency) }
    it{ should validate_presence_of(:fuel_type) }
    it{ should validate_presence_of(:fuel_efficiency_unit) }

    it{ should define_enum_for(:fuel_type)
               .with_values(['Gasoline', 'Diesel']) }

    it{ should define_enum_for(:fuel_efficiency_unit)
               .with_values(['MPG', 'KPG']) }
  end
end
