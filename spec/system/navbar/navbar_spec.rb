require 'rails_helper'

RSpec.describe 'Navbar', type: :system do
  subject do
    create(:user, email: 'tom@example.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log In'
  end

  it 'should not display navbar in the root_path' do
    visit root_path
    expect(page).to_not have_selector('nav')
  end

  context 'categories page' do
    it 'should display CATEGORIES and link to profile page' do
      subject
      visit root_path
      expect(page).to have_content('CATEGORIES')
      expect(page).to have_link('profile')
    end

    it 'should visit profile page when clicking the user icon' do
      subject
      visit root_path
      click_link 'profile'
      expect(page).to have_current_path(profiles_path)
    end
  end

  context 'other pages' do
    it 'should display CATEGORIES and link to profile page' do
      subject
      visit new_group_path
      expect(page).to have_content('NEW CATEGORY')
      expect(page).to have_link('back')
    end

    it 'should visit homepage when clicking the back icon' do
      subject
      visit new_group_path
      click_link 'back'
      expect(page).to have_current_path(root_path)
    end
  end
end
