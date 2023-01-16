require 'rails_helper'

RSpec.describe 'Budget Transactions#index', type: :system do
  subject do
    user = User.create(name: 'Tom', email: 'tom@example.com', password: 'password', balance: 30)
    @group = user.groups.create(name: 'group', icon: 'https://uxwing.com/wp-content/themes/uxwing/download/20-food-and-drinks/meal-food.png')
    BudgetTransaction.create(author: user, name: 'test-1', amount: 5, group_ids: [@group.id])
    BudgetTransaction.create(author: user, name: 'test-2', amount: 2, group_ids: [@group.id])

    wrong_group = user.groups.create(name: 'wrong group', icon: 'icon')
    BudgetTransaction.create(author: user, name: 'test-3', amount: 10, group_ids: [wrong_group.id])

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

  it 'should have content category name, image, total amount for this category' do
    subject
    visit group_budget_transactions_path(@group.id)
    expect(page).to have_content('group')
    expect(page).to have_selector('img[src="https://uxwing.com/wp-content/themes/uxwing/download/20-food-and-drinks/meal-food.png"]')
    expect(page).to have_content('Total amount: $7.00')
  end

  it 'should display all transactions except the one from other group' do
    subject
    visit group_budget_transactions_path(@group.id)
    expect(page).to have_content('test-1')
    expect(page).to have_content('Total payment: $5.00')
    expect(page).to have_content('test-2')
    expect(page).to have_content('Total payment: $2.00')
    expect(page).to_not have_content('test-3')
    expect(page).to_not have_content('Total payment: $10.00')
  end

  it 'should access the new transaction form when clicking add new category' do
    subject
    visit group_budget_transactions_path(@group.id)
    click_link 'ADD NEW TRANSACTION'
    expect(page).to have_current_path(new_group_budget_transaction_path(@group.id))
  end
end
