FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'test@test.com' }
    password { '123456' }
    balance { 20 }
  end
end
