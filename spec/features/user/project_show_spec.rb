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
    end

    it 'Allows me to click the link on the index to go to the show page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
#       As a logged in user on the root path,
      visit root_path

      within ".project-#{@project1.id}" do
        # when I click on a project tile or "Join the Project" button,
        click_button 'Join the Project'
      end

      expect(current_path).to eq(project_path(@project1))
      expect(page).to have_content("Project: Project 1")
      expect(page).to have_xpath("//img[@src='http://clipart-library.com/image_gallery/104074.png']")
      expect(page).to have_content("Description: Description of Project 1")
      expect(page).to have_link('See this on google maps')
      expect(page).to have_button('Become a Driver')
    end
  end
end
