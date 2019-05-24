require 'rails_helper'

feature 'Google OAuth' do
  context 'as a visitor' do
    before :each do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
        provider: 'google',
        uid: '100000000000000000000',
        credentials: {
          token: 'TOKEN',
          refresh_token: 'REFRESH_TOKEN',
          expires_at: 1496120719,
          expires: true
        },
        info: {
          name: 'John Smith',
          email: 'john@example.com',
          first_name: 'John',
          last_name: 'Smith',
          image: 'https://lh4.googleusercontent.com/photo.jpg'
        }
      })
    end

    it 'can sign up with Google' do
      visit '/'
      expect(page).to have_selector("button[alt='Sign in with Google']")
      expect(page).to_not have_selector("a[href='/logout']")

      click_on 'Google-login'
      expect(current_path).to eq(new_user_path)

      click_on 'Sign Up'
      expect(current_path).to eq('/')
      expect(page).to have_selector("a[href='/logout']")
      expect(page).to_not have_selector("button[alt='Sign in with Google']")

      click_on 'Logout'
      click_on 'Google-login'
      expect(current_path).to eq('/')
    end
  end
end
