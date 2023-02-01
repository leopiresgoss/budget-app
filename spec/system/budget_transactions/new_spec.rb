require 'rails_helper'

RSpec.describe 'Budget Transactions#new', type: :system do
  subject do
    user = create(:user, email: 'tom@example.com', password: 'password', balance: 20)
    @group = user.groups.create(name: 'group1', icon: 'icon')
    @group2 = user.groups.create(name: 'group2', icon: 'icon')

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log In'
  end

  it 'should visit splash page when user is not logged' do
    visit new_group_budget_transaction_path(1)
    expect(page).to have_link('LOG IN')
    expect(page).to have_link('SIGN UP')
  end

  it 'should have Name and Amount fields, checkboxes and Submit button' do
    subject
    visit new_group_budget_transaction_path(@group.id)
    expect(page).to have_field('Transaction Name')
    expect(page).to have_field('Amount')
    expect(page).to have_field('group1')
    expect(page).to have_field('group2')
    expect(page).to have_button('SUBMIT')
  end

  it 'should NOT be valid when all fields are empty' do
    subject
    visit new_group_budget_transaction_path(@group.id)
    click_button 'SUBMIT'
    expect(page).to have_current_path(new_group_budget_transaction_path(@group.id))
    expect(page).to have_content("Name can't be blank")
  end

  it 'should NOT be valid when amount is missing' do
    subject
    visit new_group_budget_transaction_path(@group.id)
    fill_in 'Transaction Name', with: 'Test'
    click_button 'SUBMIT'
    expect(page).to have_current_path(new_group_budget_transaction_path(@group.id))
    expect(page).to have_content("Amount can't be blank")
  end

  it 'should NOT be valid when you dont have enough money' do
    subject
    visit new_group_budget_transaction_path(@group.id)
    fill_in 'Transaction Name', with: 'Test'
    fill_in 'Amount', with: 600.70
    check 'group1'
    click_button 'SUBMIT'
    expect(page).to have_current_path(new_group_budget_transaction_path(@group.id))
    expect(page).to have_content("You don't have enough money to make this transaction, please add more money first")
  end

  # it 'should NOT be valid when name is missing' do
  #   subject
  #   visit new_group_budget_transaction_path(@group.id)
  #   fill_in 'Amount', with: 5.7
  #   click_button 'SUBMIT'
  #   expect(page).to have_current_path(new_group_budget_transaction_path(@group.id))
  #   expect(page).to have_content('Please, fill all fields')
  # end

  # it 'should be valid when all fields are filled' do
  #   subject
  #   visit new_group_budget_transaction_path(@group.id)
  #   fill_in 'Transaction Name', with: 'Test'
  #   fill_in 'Amount', with: 5.7
  #   click_button 'SUBMIT'
  #   expect(page).to have_current_path(group_budget_transactions_path(@group.id))
  #   expect(page).to have_content('Transaction added')
  # end
end
