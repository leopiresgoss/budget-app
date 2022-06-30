require 'rails_helper'

RSpec.describe 'Groups(Categories)#new', type: :system do
  subject do
    User.create(name: 'Tom', email: 'tom@example.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log In'
  end

  it 'should visit splash page when user is not logged' do
    visit new_group_path
    expect(page).to have_link('LOG IN')
    expect(page).to have_link('SIGN UP')
  end

  it 'should have Name and Icon fields, and Submit button' do
    subject
    visit new_group_path
    expect(page).to have_field('Name')
    expect(page).to have_field('Icon URL')
    expect(page).to have_button('SUBMIT')
  end

  it 'should NOT be valid when all fields are empty' do
    subject
    visit new_group_path
    click_button 'SUBMIT'
    expect(page).to have_current_path(new_group_path)
    expect(page).to have_content('Please, fill all fields')
  end

  it 'should NOT be valid when icon is missing' do
    subject
    visit new_group_path
    fill_in 'Name', with: 'Test'
    click_button 'SUBMIT'
    expect(page).to have_current_path(new_group_path)
    expect(page).to have_content('Please, fill all fields')
  end

  it 'should NOT be valid when name is missing' do
    subject
    visit new_group_path
    fill_in 'Icon URL', with: 'Test'
    click_button 'SUBMIT'
    expect(page).to have_current_path(new_group_path)
    expect(page).to have_content('Please, fill all fields')
  end

  it 'should be validate when all fields are filled' do
    subject
    visit new_group_path
    fill_in 'Name', with: 'Test Category'
    fill_in 'Icon URL', with: 'https://uxwing.com/wp-content/themes/uxwing/download/20-food-and-drinks/meal-food.png'
    click_button 'SUBMIT'
    expect(page).to have_current_path(groups_path)
    expect(page).to have_content('Category added')
    expect(page).to have_content('Test Category')
  end
end
