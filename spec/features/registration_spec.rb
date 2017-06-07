# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :feature do
  let(:google_oauth2) do
    {
        provider: 'google_oauth2',
        uid: '123456789',
        info: {
            name: 'John Doe',
            email: 'john@company_name.com',
            first_name: 'John',
            last_name: 'Doe',
            image: 'https://lh3.googleusercontent.com/url/photo.jpg'
        }
    }
  end

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(google_oauth2)
  end

  context 'when using google_auth2' do
    let(:user) { User.find_by email: 'john@company_name.com' }
    it 'creates a new user if not found' do
      visit '/auth/google_oauth2'
      # follow_redirect!
      expect(user.name).to eq('John Doe')
      # follow_redirect!

      fill_in 'Organization Name', with: 'The Simpsons'
      fill_in 'Primary contact email', with: 'support@simpsons.com'
      click_on 'Create'

      user.reload
      expect(user.find_organization.name).to eql('The Simpsons')

      click_on 'New'

      fill_in 'Site Name', with: 'Home Page'
      click_on 'Create'

      user.reload
      expect(user.organizations.first.sites.first.name).to eql('Home Page')

      click_on 'New'

      fill_in 'Site Name', with: 'Home Page'
      click_on 'Create'

      expect(page).to have_content('Name has already been taken')

      click_on 'Cancel'

      click_on 'Details'
      expect(page).to have_content('Home Page')
    end
  end
end