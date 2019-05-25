require 'rails_helper'

describe 'As an admin' do
  describe 'when I visit a project show page' do
    it "I see the project info and options to delete and edit the project" do
      admin = User.new(full_name: "Vincent",
                       email: "vincent@example.com",
                       about: "TBD",
                       avatar_image: nil,
                       google_token: nil,
                       google_id: nil,
                       role: 2,
                       active: true)
       project_1 = Project.create!(title: 'Shelf Lake Trail Restoration', date: "2019-05-30", organizer: admin, description: "You'll work to improve a half-mile section of the popular Shelf Lake Trail. This project is relatively small with 20-25 volunteers and tasks may be technical in nature as you install water bars, check steps, and other drainage structures as well as build new rock step stream crossings. If you are new to trail work, don't worry! No previous experience is required; just be prepared to work hard at high altitude among classic Colorado views.", active: true, image: 'https://www.voc.org/sites/default/files/styles/760x420/public/op_images/ShelfLake_8.jpg?itok=_ZH6V4li')
       address_1 = Address.create!(owner: project_1, line_1: "Shelf Lake Trailhead", line_2: "Co Rd 1038", city: "Grant", state: "CO", zip: "80448")

       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

       visit admin_project_path(project_1)

       expect(current_path).to eq(admin_project_path(project_1))
       expect(page).to have_content("#{project_1.title}")
       expect(page).to have_content("#{project_1.date.strftime('%A, %b %-d, %Y')}")
       expect(page).to have_content("#{project_1.location.state}")
       expect(page).to have_content("#{project_1.description}")
       expect(page).to have_link("Delete Project")
       expect(page).to have_link("Edit Project")
    end
  end
end
