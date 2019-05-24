require 'rails_helper'

describe 'As an admin' do
  describe 'when I visit the admin dashboard' do
    describe 'I see a simplified data-driven list of all my projects' do
      it 'when I click on a project I am directed to the project show page' do
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

        visit admin_dashboard_path

        expect(current_path).to eq(admin_dashboard_path)
        expect(page).to have_content("Add Project")

        within ".project-#{project_1.id}" do
          expect(page).to have_content(project_1.title)
          expect(page).to have_content(project_1.description)
          expect(page).to have_content(project_1.date.strftime('%A, %b %-d, %Y'))
          expect(page).to have_content(project_1.location.line_1)
          expect(page).to have_content(project_1.location.line_2)
          expect(page).to have_content(project_1.location.city)
          expect(page).to have_content(project_1.location.zip)
        end
      end
    end
  end
end

describe 'As a default user' do
  it 'does not allow default user to see admin dashboard' do
    user = User.new(full_name: "Erin",
                     email: "erin@example.com",
                     about: "TBD",
                     avatar_image: nil,
                     google_token: nil,
                     google_id: nil,
                     role: 0,
                     active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to_not have_content("Add a Project")
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
