require 'rails_helper'

RSpec.describe Group, type: :model do
  subject do
    @user = User.create(name: 'Jhon', email: 'test123@test.com', password: 'abc123')
    Group.new(name: 'Foods', icon: 'icon', author: @user)
  end

  before { subject.save }

  it 'Should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Should not be valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid without an icon' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  context '#total_amount' do
    it 'should sum transactions only for the same group' do
      group = subject
      BudgetTransaction.create(name: 'Clothes', amount: 5.2, author: @user, group_ids: [group.id])
      BudgetTransaction.create(name: 'T-shirt', amount: 1, author: @user, group_ids: [group.id])
      false_group = Group.create(name: 'Laundry', icon: 'icon', author: @user)
      BudgetTransaction.create(name: 'other group', amount: 10, author: @user, group_ids: [false_group.id])
      expect(subject.total_amount.to_f).to be(6.2)
    end
  end
end
