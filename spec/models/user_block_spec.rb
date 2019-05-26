require 'rails_helper'

RSpec.describe UserBlock, type: :model do
  describe 'Relationships:' do
    it{ should belong_to(:blocking_user) }
    it{ should belong_to(:blocked_user) }
  end
end
