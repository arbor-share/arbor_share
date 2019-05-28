require 'rails_helper'

RSpec.describe 'as a logged in user' do
  context 'on the project index page' do
    before :each do
      @user = User.create(full_name: 'Regular User',
                              email: 'user@email.com',
                              about: 'Some stuff.',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 0,
                              active: true)

      @organizer = User.create(full_name: 'Project Organizer',
                              email: 'organizer@email.com',
                              about: 'A little about myself, very little',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 1,
                              active: true)

      @admin = User.create(full_name: 'Super Admin',
                              email: 'admin@email.com',
                              about: 'More stuff.',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 2,
                              active: true)

      @project1 = Project.create(title: 'Project 1',
                                  date: '2019-05-30',
                                  description: 'Description of Project 1',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: @organizer,
                                  active: true)

      @project2 = Project.create(title: 'Project 2',
                                  date: '2019-06-30',
                                  description: 'Description of Project 2',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: @organizer,
                                  active: true)

      @project3 = Project.create(title: 'Project 3',
                            date: 'June 3',
                            description: 'Description of Project 3',
                            image: 'http://clipart-library.com/image_gallery/104074.png',
                            organizer: @organizer,
                            active: false)

      @address1 = Address.create(owner: @project1,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      @address2 = Address.create(owner: @project2,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)
    end

    it 'as an admin, it can see an Admin Dashboard link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit root_path

      expect(page).to have_content("Logout")
    end

    it 'as a regular user, it does not see an Admin Dashboard link' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit root_path

      expect(page).to_not have_content("Admin Dashboard")
    end

    it 'can see a tile for each active project' do
      # the projects are ordered by default by date?
      visit root_path

      expect(page).to have_content("Current Projects")
      expect(page).to_not have_content(@project3.title)

      within '.projects' do
        within ".project-#{@project1.id}" do
          expect(page).to have_content(@project1.date.strftime('%A, %b %-d, %Y'))
          within "#info-#{@project1.id}" do
            expect(page).to have_content(@project1.title)
            expect(page).to have_content(@project1.description)
            # expect(page).to have_content(@project1.image)
            expect(page).to have_content(@project1.location.line_1)
            expect(page).to have_content(@project1.location.line_2)
            expect(page).to have_content(@project1.location.city)
            expect(page).to have_content(@project1.location.state)
            expect(page).to have_content(@project1.location.zip)
            expect(page).to_not have_content(@project2.title)
          end
          within "#join_button-#{@project1.id}" do
            expect(page).to have_button('Join the Project')
          end
        end
      end
    end
  end
end
