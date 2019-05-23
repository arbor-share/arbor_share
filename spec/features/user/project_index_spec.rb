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

      @user = User.create(full_name: 'Reg User',
                              email: 'user@email.com',
                              about: 'I am a friendly user',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 0,
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
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  location_id: @address.id,
                                  organizer_id: @organizer.id,
                                  active: true)

      @project2 = Project.create(title: 'Project 2',
                                  date: 'June 2', 
                                  description: 'Description of Project 2',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  location_id: @address.id,
                                  organizer_id: @organizer.id,
                                  active: true)

      @project3 = Project.create(title: 'Project 3',
                                  date: 'June 3', 
                                  description: 'Description of Project 3',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  location_id: @address.id,
                                  organizer_id: @organizer.id,
                                  active: false)

      visit root_path
    end

    it 'can see a tile for each active project' do
      save_and_open_page
      # the projects are ordered by default by date?
      expect(page).to have_content("All Projects")
      expect(page).to_not have_content(@project3.title)

      within '.projects' do
        within ".project-#{@project1.id}" do
          within "#info-#{@project1.id}" do
            expect(page).to have_content(@project1.title)
            expect(page).to have_content(@project1.date)
            #testing for brief description?
            # expect(page).to have_content(project_1.description)
            expect(page).to have_content(@project1.image)
            expect(page).to have_content(@project1.location_id)
            expect(page).to_not have_content(@project2.title)
          end
          within "#join_button-#{@project1.id}" do
            expect(page).to have_button('Join Carpool')
          end
        end
      end
    end
  end
end
