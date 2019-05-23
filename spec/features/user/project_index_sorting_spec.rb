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

      @project1 = Project.create(title: 'A Project 1',
                                  date: '2019-07-30', 
                                  description: 'Description of Project 1',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: @organizer,
                                  active: true)

      @project2 = Project.create(title: 'C Project 2',
                                  date: '2019-06-30', 
                                  description: 'Description of Project 2',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: @organizer,
                                  active: true)

      @project3 = Project.create(title: 'B Project 3',
                            date: '2019-05-30', 
                            description: 'Description of Project 3',
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

      @address2 = Address.create(owner: @project2,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      @address3 = Address.create(owner: @project3,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      visit root_path
    end

    it 'sees the projects in order by date' do
      within '.projects' do
        expect(@project3.title).to appear_before(@project1.title)
        expect(@project2.title).to appear_before(@project1.title)
      end
    end

    it 'can sort the projects by title a-z ' do
      within '.projects' do
        expect(@project1.title).to appear_before(@project3.title)
        expect(@project3.title).to appear_before(@project2.title)
      end
    end
  end
end
