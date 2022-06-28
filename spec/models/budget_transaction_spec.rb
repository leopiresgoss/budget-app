require 'rails_helper'

RSpec.describe BudgetTransaction, type: :model do
  subject do
    @user = User.create(name: 'Jhon', email: 'test123@test.com', password: 'abc123')
    BudgetTransaction.new(name: 'Buy T-shirt', amount: 5.69, author: @user)
  end

  before { subject.save }

  it 'Should be valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Should not be valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid without an amount' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it 'Should not be valid when a amount is less or equal than zero' do
    subject.amount = 0
    expect(subject).to_not be_valid
  end

  context 'groups many-to-many relationship' do
    it 'should not add a group to budget_transactions when the author is not the same' do
      user2 = User.create(name: 'Maria', email: 'maria@test.com', password: 'abc123')
      group2 = Group.create(name: 'Clothes', icon: 'clothes', author: user2)

      expect { subject.groups << group2 }.to raise_error('Different authors')
    end

    it 'should add a group to budget_transactions when the author is the same' do
      group = Group.create(name: 'Clothes', icon: 'clothes', author: @user)
      subject.groups << group
      expect(subject.groups).to include(group)
    end
  end
end
