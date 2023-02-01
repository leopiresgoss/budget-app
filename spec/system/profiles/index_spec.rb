require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  subject do
    create(:user, name: 'Tom', email: 'tom@example.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log In'
  end

  it 'should visit splash page when user is not logged' do
    visit profiles_path
    expect(page).to have_link('LOG IN')
    expect(page).to have_link('SIGN UP')
  end

  it 'should have user name and sign out button' do
    subject
    visit profiles_path
    expect(page).to have_content('Tom')
    expect(page).to have_button('SIGN OUT')
  end

  it 'should sign out when clicking sign out' do
    subject
    visit profiles_path

    click_button 'SIGN OUT'
    expect(page).to have_link('LOG IN')
    expect(page).to have_link('SIGN UP')
  end
end
