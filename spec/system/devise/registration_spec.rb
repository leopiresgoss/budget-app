require 'rails_helper'

RSpec.describe 'Sign-up page', type: :system do
  it 'I can see the name, email, password and confirmation passwords inputs and the "Sign up" button' do
    visit new_user_registration_path
    expect(page).to have_field('Name')
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_field('Confirm Password')
    expect(page).to have_button('Sign Up')
  end

  it 'When I click the submit button without filling in the username and the password, I get a detailed error' do
    visit new_user_registration_path
    click_button 'Sign Up'
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Name can't be blank")
  end

  it 'When I click the submit button after filling in the email and the name field with  data but not in password field,
       I get a detailed error' do
    visit new_user_registration_path
    within('#new_user') do
      fill_in 'Name', with: 'Rspec'
      fill_in 'Email', with: 'wrong@email.com'
    end
    click_button 'Sign Up'
    expect(page).to have_content("Password can't be blank")
  end

  it 'When I click the submit button after trying sign-up with an existing email, I get a detailed error' do
    visit new_user_registration_path
    create(:user, email: 'capybara@test.com', password: 'abc123')
    within('#new_user') do
      fill_in 'Name', with: 'Jhon Capybara'
      fill_in 'Email', with: 'capybara@test.com'
      fill_in 'user_password', with: 'abc123456'
    end
    click_button 'Sign Up'
    expect(page).to have_content('Email has already been taken')
  end

  it 'When I click the submit button after signing-up with correct data, I am redirected to the root page' do
    visit new_user_registration_path
    within('#new_user') do
      fill_in 'Name', with: 'Jhon Capybara'
      fill_in 'Email', with: 'capybara@test.com'
      fill_in 'user_password', with: 'abc123456'
      fill_in 'Confirm Password', with: 'abc123456'
    end
    click_button 'Sign Up'
    expect(page).to have_current_path(root_path)
  end
end
