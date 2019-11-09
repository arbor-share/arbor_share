require 'rails_helper'
require 'date'

describe 'As an admin' do
  before :each do
    @future_date = (Date.today >> 1).strftime('%Y-%m-%d')
    @admin = User.new(full_name: "Vincent",
                     email: "vincent@example.com",
                     about: "TBD",
                     avatar_image: nil,
                     google_token: nil,
                     google_id: nil,
                     role: 2,
                     active: true)
     @project_1 = Project.create!(title: 'Shelf Lake Trail Restoration', date: @future_date, organizer: @admin, description: "You'll work to improve a half-mile section of the popular Shelf Lake Trail. This project is relatively small with 20-25 volunteers and tasks may be technical in nature as you install water bars, check steps, and other drainage structures as well as build new rock step stream crossings. If you are new to trail work, don't worry! No previous experience is required; just be prepared to work hard at high altitude among classic Colorado views.", active: true, image: 'https://www.voc.org/sites/default/files/styles/760x420/public/op_images/ShelfLake_8.jpg?itok=_ZH6V4li')
     @address_1 = Address.create!(owner: @project_1, line_1: "Shelf Lake Trailhead", line_2: "Co Rd 1038", city: "Grant", state: "CO", zip: "80448")

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

     visit admin_project_path(@project_1)
     click_link "Edit Project"
  end

  it 'I can edit a project' do
     expect(current_path).to eq(edit_admin_project_path(@project_1))
     expect(page.find_field('Title').value).to eq(@project_1.title)
     expect(page.find_field('Description').value).to eq(@project_1.description)
     expect(page.find_field('Date').value).to eq(@future_date)

     expect(page.find_field('Line 1').value).to eq(@project_1.location.line_1)
     expect(page.find_field('Line 2').value).to eq(@project_1.location.line_2)
     expect(page.find_field('City').value).to eq(@project_1.location.city)
     expect(page.find_field('Zip').value).to eq(@project_1.location.zip)
     expect(page.find_field('Image').value).to eq(@project_1.image)
     expect(page).to have_checked_field('Active')

     fill_in 'Title', with: "New Project Title"
     fill_in 'project[location_attributes][city]', with: "Fountain"

     page.uncheck('Active')

     click_button("Update Project")

     expect(current_path).to eq(admin_dashboard_path)
     expect(page).to have_content("Your project was updated successfully!")
     expect(page).to have_content("New Project Title")
     expect(page).to have_content("Fountain")
  end

  it 'shows an error message if project fields not filled out correctly' do
    new_date = (Date.today >> 2).strftime('%Y-%m-%d')
    fill_in 'Date', with: new_date

    click_button("Update Project")

    expect(current_path).to eq(admin_project_path(@project_1))
    expect(page).to have_content("Date cannot be in the past")
    expect(page.find_field('Title').value).to eq(@project_1.title)
    expect(page.find_field('Date').value).to eq(new_date)
  end

  it 'shows an error message if project address fields not filled out correctly' do
    fill_in 'Line 1', with: nil

    click_button("Update Project")

    expect(current_path).to eq(admin_project_path(@project_1))
    expect(page).to have_content("Location line 1 can't be blank")
    expect(page.find_field('Title').value).to eq(@project_1.title)
    expect(page.find_field('Date').value).to eq(@future_date)
  end

end
