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

  context 'budget_transactions many-to-many relationship' do
    it 'should not add a transaction to groups when the author is not the same' do
      user2 = User.create(name: 'Maria', email: 'maria@test.com', password: 'abc123')
      transaction2 = BudgetTransaction.create(name: 'Clothes', amount: 5.2, author: user2)

      expect { subject.budget_transactions << transaction2 }.to raise_error('Different authors')
    end

    it 'should add a group to budget_transactions when the author is the same' do
      transaction = BudgetTransaction.create(name: 'Clothes', amount: 5.2, author: @user)
      subject.budget_transactions << transaction

      expect(subject.budget_transactions).to include(transaction)
    end

    context '#total_amount' do
      it 'should sum transactions only for the same group' do
        subject.budget_transactions.create(name: 'Clothes', amount: 5.2, author: @user)
        subject.budget_transactions.create(name: 'T-shirt', amount: 1, author: @user)
        Group.create(name: 'Laundry', icon: 'icon', author: @user).budget_transactions.create(name: 'other group', amount: 10, author: @user)

        expect(subject.total_amount.to_f).to be(6.2)
      end
    end
  end
end
