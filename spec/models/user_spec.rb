require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships:' do
    it{ should have_many(:addresses) }
    it{ should have_many(:vehicles)
               .with_foreign_key('owner_id') }

    it{ should have_many(:blocked_users)
               .through(:user_blocks) }

    it{ should have_many(:carpools)
               .with_foreign_key('driver_id') }

    it{ should define_enum_for(:role)
               .with_values([:default, :organizer, :admin]) }
  end

  describe 'Validations:' do
    it{ should validate_presence_of(:email) }
    it{ should allow_values('test@test.com',
                            'test@test.co.uk',
                            'te-st.us_er+filter@gmail.com').for(:email) }
    it{ should_not allow_values('test.com',
                                'test@test',
                                'nothankyou',
                                '').for(:email) }
  end
end
