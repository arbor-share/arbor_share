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
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_dashboard_path

        expect(current_path).to eq(admin_dashboard_path)
        expect(page).to have_content("Add a Project")

        within ".project-#{project_1.id} project-card" do
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
