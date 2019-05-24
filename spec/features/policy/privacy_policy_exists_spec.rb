require 'rails_helper'

feature 'Policy page' do
  it 'exists' do
    visit '/policy'

    within 'main' do
      expect(page).to have_content('Privacy Policy')
    end
  end
end
