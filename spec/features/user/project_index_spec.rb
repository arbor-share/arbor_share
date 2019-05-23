require 'rails_helper'

RSpec.describe 'as a logged in user' do
  context 'on the project index page' do
    before :each do
      @organizer = User.create(full_name: 'Project Organizer',
                              email: 'organizer@email.com',
                              about: 'A little about myself, very little',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 1,
                              active: true)

      @user = User.create(full_name: 'Project Organizer',
                              email: 'organizer@email.com',
                              about: 'A little about myself, very little',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 1,
                              active: true,)

      @address = Address.create(owner_id: @organizer.id,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true,
                              )

                              # require 'pry'; binding.pry
      @project1 = Project.create(title: 'Project 1',
                                  date: 'correct format?', 
                                  description: 'Description of Project 1',
                                  image: 'thumbnail link here',
                                  location_id: @address.id,
                                  organizer_id: @organizer.id,
                                  active: true)

      @project2 = Project.create(title: 'Project 2',
                                  date: 'June 1', 
                                  description: 'Description of Project 2',
                                  image: 'thumbnail link here',
                                  location_id: @address.id,
                                  organizer_id: @organizer.id,
                                  active: true)

                                  require 'pry'; binding.pry

      visit root_path
    end

    it 'can see a tile for each project' do
      # the projects are ordered by default by date?
      expect(page).to have_content("All Projects")
      within '.projects' do
        within "#project-#{@project1_id}" do
          within "#project-#{@project1_id}" do
            expect(page).to have_content(@project_1.title)
            expect(page).to have_content(@project_1.date)
            #testing for brief description?
            # expect(page).to have_content(project_1.description)
            expect(page).to have_content(@project_1.image)
            expect(page).to have_content(@project_1.location)
            expect(page).to_not have_content(@project_2.title)
          end
          within "#join_button-#{@project1_id}" do
            expect(page).to have_button('Join Carpool')
          end
        end
      end
    end
  end
end

# As a logged in user,
# when I visit the root path,
# I see tiles for each project,
# Each project tile has a title, image, date, location, brief description.
# Under each tile there is a button "Join the Project",
# the projects are ordered by default by date