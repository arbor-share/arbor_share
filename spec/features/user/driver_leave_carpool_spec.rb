require 'rails_helper'

RSpec.describe 'as a logged in user' do
  context 'as a driver on the carpool show page' do
    before :each do
      @organizer = User.create(full_name: 'Project Organizer',
        email: 'organizer@email.com',
        about: 'A little about myself, very little',
        avatar_image: 'link to image',
        google_token: 'google token',
        google_id: 1,
        role: 1,
        active: true)

      @driver = User.create(full_name: 'Driver Dan',
        email: 'user@email.com',
        about: 'Nothing about yourself',
        avatar_image: 'link to image',
        google_token: 'google token',
        google_id: 1,
        role: 0,
        active: true)

      @passenger = User.create(full_name: 'Passenger Pauly',
        email: 'user@email.com',
        about: 'Nothing about yourself',
        avatar_image: 'link to image',
        google_token: 'google token',
        google_id: 1,
        role: 0,
        active: true)

      @project1 = Project.create(title: 'Project 1',
                                  date: '2019-05-30',
                                  description: 'Description of Project 1',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: @organizer,
                                  active: true)

      @address1 = Address.create(owner: @project1,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      @address2 = Address.create(owner: @driver,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      @address3 = Address.create(owner: @passenger,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      @vehicle1 = Vehicle.create(owner: @driver, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 3, default: true)

      @carpool = Carpool.create(driver: @driver, project: @project1, vehicle: @vehicle1, passengers: [@passenger])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@driver)
    end
    it 'can cancel the carpool' do
      visit project_path(@project1)

      click_link 'Cancel Carpool'

      expect(current_path).to eq(project_path(@project1))
      expect(page).to have_content('You are no longer a driver.')
      expect(page).to_not have_content("Driver: #{@driver.full_name}")
    end
  end
end

