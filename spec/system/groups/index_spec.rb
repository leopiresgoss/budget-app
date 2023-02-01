require 'rails_helper'

RSpec.describe 'Groups(Categories)#index', type: :system do
  subject do
    test_user = create(:user, email: 'tom@example.com', password: 'password')
    @group = create(:group, author: test_user, name: 'food', icon: 'https://uxwing.com/wp-content/themes/uxwing/download/20-food-and-drinks/meal-food.png')
    create(:group, author: test_user, name: 'food2', icon: 'https://')
    create(:budget_transaction, author: test_user, name: 'amount test 1', amount: 1, group_ids: [@group.id])
    create(:budget_transaction, author: test_user, name: 'amount test 2', amount: 2.5, group_ids: [@group.id])

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'password'

    click_button 'Log In'
  end

  it 'should visit splash page when user is not logged' do
    visit groups_path
    expect(page).to have_link('LOG IN')
    expect(page).to have_link('SIGN UP')
  end

  it 'should have content category name, image, total amount for all categories' do
    subject
    visit groups_path
    expect(page).to have_content('food')
    expect(page).to have_selector('img[src="https://uxwing.com/wp-content/themes/uxwing/download/20-food-and-drinks/meal-food.png"]')
    expect(page).to have_content('Total amount: $3.50')
    expect(page).to have_content('food2')
    expect(page).to have_content('Total amount: $0.00')
  end

  it 'should access the budget transactions path for this cataegory when clicking the card' do
    subject
    visit groups_path
    click_link 'food'
    expect(page).to have_current_path(group_budget_transactions_path(@group.id))
  end

  it 'should access the new category form when clicking add new category' do
    subject
    visit groups_path
    click_link 'ADD NEW CATEGORY'
    expect(page).to have_current_path(new_group_path)
  end
end
