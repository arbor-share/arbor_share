require 'rails_helper'

RSpec.describe 'as a logged in user' do
  context 'on my profile page' do
    before :each do
      @user = User.create(full_name: 'Volunteer',
                              email: 'volunteer@email.com',
                              about: 'A little about myself, very little',
                       avatar_image: 'link to image',
                       google_token: 'google token',
                          google_id: 2,
                               role: :default,
                             active: true)

      @address1 = Address.create(owner: @user,
                                line_1: "In a van",
                                line_2: "down by the river",
                                  city: "Speakerville",
                                 state: 'WA',
                                   zip: '12345',
                               default: false)

      @address2 = Address.create(owner: @user,
                                line_1: "Wabash and Lake",
                                line_2: "near the ringing phone",
                                  city: "Chicago",
                                 state: 'IL',
                                   zip: '12345',
                               default: true)

      @address3 = Address.create(owner: @user,
                                line_1: "Market and 17th",
                                line_2: "east corner",
                                  city: "Denver",
                                 state: 'CO',
                                   zip: '12345',
                               default: false)

      @vehicle1 = Vehicle.create(owner: @user,
                                  make: "Honda",
                                 model: "Insight",
                                 color: "Blue",
                                  year: "2019",
                       fuel_efficiency: 55,
                  fuel_efficiency_unit: "MPG",
                             fuel_type: "Gasoline",
                       passenger_limit: 4,
                                 image: "url/to/image",
                               default: true)

      @vehicle2 = Vehicle.create(owner: @user,
                                  make: "Chevrolet",
                                 model: "Suburban",
                                 color: "Blue",
                                  year: "1988",
                       fuel_efficiency: 12,
                  fuel_efficiency_unit: "MPG",
                             fuel_type: "Gasoline",
                       passenger_limit: 8,
                                 image: "url/to/image",
                               default: false)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path
    end

    it 'can see my profile information' do
      within '#user-info' do
        expect(page).to have_content(@user.full_name)
        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.about)
        expect(page).to have_selector("img[src='#{@user.avatar_image}']")
      end
    end

    it 'can see my address information and select my default' do
      within '#addresses' do
        expect(page).to have_selector('.address', count: 3)

        within '.address.default' do
          expect(page).to have_content(@address2.line_1)
          expect(page).to have_content(@address2.line_2)
          expect(page).to have_content(@address2.city)
          expect(page).to have_content(@address2.state)
          expect(page).to have_content(@address2.zip)

          expect(page).to_not have_content(@address1.line_1)
        end

        within('.address:last-of-type') do
          click_button 'Make Default'
        end
      end

      within '.address.default' do
        expect(page).to have_content(@address3.line_1)

        expect(page).to_not have_content(@address2.line_1)
      end
    end

    xit 'can see my vehicle information and select my default' do
      within '#vehicles' do
        expect(page).to have_selector('.vehicle', count: 2)

        within '.vehicle.default' do
          expect(page).to have_content(@vehicle1.make)
          expect(page).to have_content(@vehicle1.model)
          expect(page).to have_content(@vehicle1.color)
          expect(page).to have_content(@vehicle1.year)
          expect(page).to have_content(@vehicle1.fuel_type)
          expect(page).to have_content("#{@vehicle1.fuel_efficiency} #{@vehicle1.fuel_efficiency_unit}")
          expect(page).to have_content("Passenger Limit: #{@vehicle1.passenger_limit}")

          expect(page).to_not have_content(@vehicle2.make)
        end

        within('.vehicle:last-of-type') do
          click_on 'Make Default'
        end
      end

      within '.vehicle.default' do
        expect(page).to have_content(@vehicle2.make)

        expect(page).to_not have_content(@vehicle1.make)
      end
    end
  end
end
