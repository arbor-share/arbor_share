require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Class Methods' do
    it '.sorted' do
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

      @vehicle1 = Vehicle.create 
      @carpool1 = Carpool.create(driver: @organizer, project: @project1, vehicle: @vehicle1)

      alphabetically = Project.sorted("a-z")
      needs_driver = Project.sorted("needs_driver")

      expect(alphabetically).to eq([@project1, @project3, @project2])
      expect(needs_driver).to eq([@project3, @project2])
      # Project.sorted("date")
      # Project.sorted("no_driver")
      # require 'pry'; binding.pry
    end
  end
end