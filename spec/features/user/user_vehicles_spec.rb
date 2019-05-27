require 'rails_helper'

feature 'User vehicles' do
  context 'as a logged-in user' do
    it 'can add a vehicle' do
      user = User.create(full_name: 'Volunteer',
                             email: 'volunteer@email.com',
                             about: 'A little about myself, very little',
                      avatar_image: 'link to image',
                      google_token: 'google token',
                         google_id: 2,
                              role: :default,
                            active: true)

      allow_any_instance_of(ApplicationController)
                           .to receive(:current_user)
                           .and_return(user)

      visit profile_path
      click_button 'Add a Vehicle'

      fill_in 'Make', with: 'Honda'
      fill_in 'Model', with: 'Insight'
      fill_in 'Year', with: '2019'
      fill_in 'Color', with: 'Blue'
      fill_in 'Fuel Efficiency', with: '40'
      select 'MPG', from: 'Fuel Efficiency Unit'
      select 'Gasoline', from: 'Fuel Type'

      click_button 'Add this vehicle'

      within '#vehicles' do
        expect (page).to have_content('2019 Honda Insight')
      end
    end
  end
end
