require 'rails_helper'

RSpec.describe 'Splash page', type: :system do
  it 'should be displayed when the user is not logged in' do
    visit root_path

    expect(page).to have_link('LOG IN')
    expect(page).to have_link('SIGN UP')
  end

  it 'should not be displayed when the user is logged in' do
    visit new_user_session_path
    User.create(name: 'Tester', email: 'capybara@test.com', password: 'abc123')
    within('#new_user') do
      fill_in 'Email', with: 'capybara@test.com'
      fill_in 'Password', with: 'abc123'
    end
    click_button 'Log In'

    expect(page).to_not have_link('LOG IN')
    expect(page).to_not have_link('SIGN UP')
  end

  it 'should redirect to log in when clicking LOG IN' do
    visit root_path

    click_link 'LOG IN'
    expect(page).to have_current_path(new_user_session_path)
  end

  it 'should redirect to sign up when clicking LOG IN' do
    visit root_path

    click_link 'SIGN UP'
    expect(page).to have_current_path(new_user_registration_path)
  end
end
