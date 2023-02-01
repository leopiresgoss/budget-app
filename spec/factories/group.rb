FactoryBot.define do
  factory :group do
    name { 'Group Name' }
    icon { 'icon' }
    author { create(:user) }
  end
end
