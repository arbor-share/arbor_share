require 'rails_helper'

feature 'User addresses' do
  context 'as a logged-in user' do
    it 'can add an address' do
      user = User.create(full_name: 'Volunteer',
                             email: 'volunteer@email.com',
                             about: 'A little about myself, very little',
                      avatar_image: 'link to image',
                      google_token: 'google token',
                         google_id: 2,
                              role: :default,
                            active: true)

      allow_any_instance_of(ApplicationController)
                           .to receive(:session)
                           .and_return({user_id: user.id})

      visit profile_path
      click_button 'Add an Address'

      fill_in 'Line 1', with: 'In a van'
      fill_in 'Line 2', with: 'down by the river'
      fill_in 'City', with: 'Denver'
      select 'CO', from: 'State'
      fill_in 'Zip', with: '80206'

      click_button 'Add this address'

      within '#addresses' do
        expect(page).to have_content('In a van')
      end
    end
  end
end
