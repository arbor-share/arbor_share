require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Relationships:' do
    # organizer is a User
    it{ should belong_to(:organizer) }
    # location is an Address
    it{ should have_one(:location) }
    it{ should have_many(:carpools) }
  end

  describe 'Validations:' do
    it{ should validate_presence_of(:title) }
    it{ should validate_presence_of(:date) }
    it{ should allow_value(2.weeks.from_now).for(:date) }
    it{ should_not allow_value(2.weeks.ago).for(:date) }
    it{ should validate_presence_of(:description) }
    it{ should validate_presence_of(:image) }
  end

  describe 'instance methods' do
    describe '#format_coords' do
      it 'formats the longitude and latitude into a usable array for mapbox' do
       organizer = User.create(full_name: 'Project Organizer',
                                email: 'organizer@email.com',
                                about: 'A little about myself, very little',
                                avatar_image: 'link to image',
                                google_token: 'google token',
                                google_id: 1,
                                role: 1,
                                active: true)

       project1 = Project.create(title: 'A Project 1',
                                    date: 9.weeks.from_now,
                                    description: 'Description of Project 1',
                                    image: 'http://clipart-library.com/image_gallery/104074.png',
                                    organizer: organizer,
                                    active: true)
       address1 = Address.create(owner: project1,
                                line_1: "first address line",
                                line_2: "second address line",
                                city: "city town",
                                state: 0,
                                zip: '12345',
                                latitude: '13.31',
                                longitude: '420.024',
                                default: true)

        expect(project1.format_coords).to eq([420.024, 13.31])
      end
    end
  end

  describe 'Class Methods' do
    context '.sorted' do
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
                                    date: 9.weeks.from_now,
                                    description: 'Description of Project 1',
                                    image: 'http://clipart-library.com/image_gallery/104074.png',
                                    organizer: @organizer,
                                    active: true)

        @project2 = Project.create(title: 'C Project 2',
                                    date: 5.weeks.from_now,
                                    description: 'Description of Project 2',
                                    image: 'http://clipart-library.com/image_gallery/104074.png',
                                    organizer: @organizer,
                                    active: true)

        @project3 = Project.create(title: 'B Project 3',
                              date: 1.week.from_now,
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
      end

      it 'can defaults to sort by date by default' do
        default = Project.sorted

        expect(default).to eq([@project3, @project2, @project1])
      end

      it 'can sort title alphabetically' do
        alphabetically = Project.sorted("a-z")

        expect(alphabetically).to eq([@project1, @project3, @project2])
      end

      it 'sorts by projects that need drivers' do
        needs_driver = Project.sorted("needs_driver")

        expect(needs_driver).to eq([@project3, @project2])
      end
    end
  end
end
