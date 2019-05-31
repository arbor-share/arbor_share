require 'rails_helper'

describe "When I visit a project's show page" do
  describe 'As a logged in user' do
    before :each do
      @organizer = User.create(full_name: 'Project Organizer',
        email: 'organizer@email.com',
        about: 'A little about myself, very little',
        avatar_image: 'link to image',
        google_token: 'google token',
        google_id: 1,
        role: 1,
        active: true)

      @user = User.create(full_name: 'Person mchelper',
        email: 'user@email.com',
        about: 'Nothing about yourself',
        avatar_image: 'link to image',
        google_token: 'google token',
        google_id: 1,
        role: 0,
        active: true)

      @project1 = Project.create(title: 'Project 1',
                                  date: 1.week.from_now,
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
    end

    it 'Allows me to click the link on the index to go to the show page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit root_path

      within ".project-#{@project1.id}" do
        click_button 'Join the Project'
      end

      within '.project-show-card' do
        expect(current_path).to eq(project_path(@project1))
        expect(page).to have_content("Project: Project 1")
        expect(page).to have_xpath("//img[@src='http://clipart-library.com/image_gallery/104074.png']")
        expect(page).to have_content("Project Details: Description of Project 1")
      end

      within '.drivers' do
        expect(page).to have_button('Become a Driver')
        expect(page).to_not have_button('Catch a Ride')
      end
    end

    it 'shows listed carpools if they are present' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      user_1 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
      user_2 = User.create!(full_name: "Erin", email: "erin@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :organizer, active: true)
      vehicle_1 = Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 3, default: true)
      carpool = Carpool.create!(driver: user_1, project: @project1, vehicle: vehicle_1)
      CarpoolPassenger.create!(carpool: carpool, passenger: user_2)

      visit project_path(@project1)

      within '.drivers' do
        expect(page).to have_button('Become a Driver')
      end

      within ".carpool-#{carpool.id}" do
        expect(page).to have_content("Driver: #{user_1.full_name}")
        expect(page).to have_content("Available Seats: 2 of 3")
        expect(page).to have_button('Catch a Ride')
        within '.passengers' do
          expect(page).to have_content(user_2.full_name)
        end
      end
    end

    it 'will not show a button to catch a ride if there are no carpools' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit project_path(@project1)

      expect(page).to_not have_css('.carpools')
      expect(page).to_not have_button('Catch a Ride')
    end

    it 'will not show the catch a ride button if a carpool if full' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      user_1 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
      user_2 = User.create!(full_name: "Erin", email: "erin@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :organizer, active: true)
      vehicle_1 = Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 1, default: true)
      carpool = Carpool.create!(driver: user_1, project: @project1, vehicle: vehicle_1)
      CarpoolPassenger.create!(carpool: carpool, passenger: user_2)

      visit project_path(@project1)

      within ".carpool-#{carpool.id}" do
        expect(page).to have_content("Driver: #{user_1.full_name}")
        expect(page).to have_content("Available Seats: 0 of 1")
        expect(page).to_not have_button('Catch a Ride')
      end
    end

    it 'lets a logged in user join a carpool' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      user_1 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
      vehicle_1 = Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 2, default: true)
      carpool = Carpool.create!(driver: user_1, project: @project1, vehicle: vehicle_1)
      Address.create!(owner: @user, line_1: "123 Anywhere St", city: "Denver", state: "CO", zip: "80206", default: true)

      visit project_path(@project1)

      within ".carpool-#{carpool.id}" do
        expect(page).to have_button('Catch a Ride')
        expect(page).to have_content("Available Seats: 2 of 2")
        within '.passengers' do
          expect(page).to have_content('No Passengers Yet!')
          expect(page).to_not have_content('Person mchelper')
        end
        click_button 'Catch a Ride'
      end

      expect(page).to have_content("You have joined #{user_1.full_name}'s carpool!")

      within ".carpool-#{carpool.id}" do
        expect(page).to_not have_button('Catch a Ride')
        expect(page).to have_content('Available Seats: 1 of 2')
        within '.passengers' do
          expect(page).to have_content('Person mchelper')
        end
      end
    end

    it 'will let a user create their own carpool' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      vehicle_1 = Vehicle.create!(owner: @user, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 2, default: true)
      Address.create!(owner: @user, line_1: "123 Anywhere St", city: "Denver", state: "CO", zip: "80206", default: true)

      visit project_path(@project1)

      expect(page).to_not have_css('.carpools')

      click_button 'Become a Driver'

      expect(current_path).to eq(project_path(@project1))
      expect(page).to have_content("You are now a driver for #{@project1.title}!")
      within '.drivers' do
        expect(page).to have_content("Driver: #{@user.full_name}")
        expect(page).to_not have_button('Catch a Ride')
      end
    end

    it 'will not let a user become a driver if they do not have an address' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      vehicle_1 = Vehicle.create!(owner: @user, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 2, default: true)

      visit project_path(@project1)

      click_button 'Become a Driver'

      expect(current_path).to eq(project_path(@project1))
      expect(page).to_not have_css('.carpools')
      expect(page).to have_content("You were unable to become a driver!")
    end

    it 'will not let a user become a passenger if they do not have an address' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      user_1 = User.create!(full_name: "Jerk", email: "jerk@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :default, active: true)
      vehicle_1 = Vehicle.create!(owner: user_1, make: "Honda", model: "Civic", color: "White", year: 2004, fuel_efficiency: 24, fuel_type: "Gasoline", fuel_efficiency_unit: "MPG", passenger_limit: 2, default: true)
      carpool = Carpool.create!(driver: user_1, project: @project1, vehicle: vehicle_1)

      visit project_path(@project1)

      within ".carpool-#{carpool.id}" do
        click_button 'Catch a Ride'
      end

      expect(current_path).to eq(project_path(@project1))
      expect(page).to have_content("You were not able to join this carpool")
      within '.drivers' do
        expect(page).to_not have_content(@user.full_name)
      end
    end

    it 'will not let a visitor join a carpool or become a driver without logging in first' do
      visit project_path(@project1)

      expect(page).to_not have_css('.drivers')
      expect(page).to_not have_button('Catch a Ride')
      expect(page).to_not have_button('Become a Driver')
      expect(page).to have_content('Sign in to become a Driver or join a Carpool!')
    end
  end
end
