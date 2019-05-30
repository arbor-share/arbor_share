require 'rails_helper'

describe 'As an admin' do
  describe 'when I visit /admin/dashboard I see link to add a project' do
    before :each do
      @admin = User.new(full_name: "Vincent", email: "vincent@example.com", about: "TBD", avatar_image: nil, google_token: nil, google_id: nil, role: :admin, active: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit admin_dashboard_path
      click_link 'Add Project'
    end

    it 'when I click it I can create a new project' do
      expect(current_path).to eq(new_admin_project_path)

      fill_in 'Title', with: 'Test Project'
      fill_in 'Date', with: 10.days.from_now
      fill_in 'Description', with: 'The testiest of all test projects.'
      fill_in 'project[location_attributes][line_1]', with: '1331 17th St'
      fill_in 'project[location_attributes][line_2]', with: 'LL100'
      fill_in 'project[location_attributes][city]', with: 'Denver'
      select 'CO', from: 'project[location_attributes][state]'
      fill_in 'project[location_attributes][zip]', with: '80202'
      fill_in 'Image', with: 'https://www.historycolorado.org/sites/default/files/media/images/2018/pikes-peak-1273566_1920.jpg'

      click_button 'Create Project'

      project = Project.last

      expect(current_path).to eq(admin_project_path(project))
      expect(page).to have_content("Your project was successfully created!")
      expect(page).to have_content(project.title)
      expect(page).to have_content(project.location.line_1)
    end

    it 'I receive an error message if the new project form is not filled out correctly' do
      fill_in 'Title', with: 'Test Project'
      fill_in 'Date', with: '2018-01-01'
      fill_in 'Description', with: 'The testiest of all test projects.'
      fill_in 'project[location_attributes][line_1]', with: '1331 17th St'
      fill_in 'project[location_attributes][line_2]', with: 'LL100'
      fill_in 'project[location_attributes][city]', with: 'Denver'
      select 'CO', from: 'project[location_attributes][state]'
      fill_in 'project[location_attributes][zip]', with: '80202'
      fill_in 'Image', with: 'https://www.historycolorado.org/sites/default/files/media/images/2018/pikes-peak-1273566_1920.jpg'

      click_button 'Create Project'

      expect(current_path).to eq(admin_project_path)
      expect(page).to have_content("Invalid input. Please try again")
    end
  end
end
