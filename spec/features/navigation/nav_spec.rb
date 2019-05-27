require 'rails_helper'

feature 'Navigation' do
  context 'as a visitor' do
    it 'sees homepage link and Google login button' do
      visit '/'

      within 'nav' do
        expect(page).to have_selector("a[href='/']")
        expect(page).to have_selector('#Google-login')

        expect(page).to_not have_selector("a[href='#{profile_path}']")
      end
    end
  end

  context 'as a logged-in user' do
    it 'sees links to homepage, own profile, and logout' do
      user = User.create(full_name: "Volunteer",
                             email: "volunteer@example.com",
                             about: "Vivid and thrilling detail.",
                      avatar_image: "url/to/image",
                      google_token: "thisisatoken",
                         google_id: 1,
                              role: :default,
                            active: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/'

      within 'nav' do
        expect(page).to have_selector("a[href='/']")
        expect(page).to have_selector("a[href='#{logout_path}']")

        expect(page).to have_selector("a[href='#{profile_path}']")
      end
    end
  end
end
