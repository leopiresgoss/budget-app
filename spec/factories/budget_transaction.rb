FactoryBot.define do
  factory :budget_transaction do
    name { 'MyString' }
    amount { 1.5 }
    author { create(:user) }
    group_ids { [create(:group).id] }
  end
end
