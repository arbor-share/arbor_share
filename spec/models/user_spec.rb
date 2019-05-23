require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'instance methods' do
    it '#address' do
      organizer = User.create(full_name: 'Project Organizer',
                              email: 'organizer@email.com',
                              about: 'A little about myself, very little',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 1,
                              active: true)

      project = Project.create(title: 'Project 1',
                                  date: '2019-05-30', 
                                  description: 'Description of Project 1',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: organizer,
                                  active: true)

      address = Address.create(owner: project,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      expect(project.location).to eq(address)
    end
  end
end
