require 'rails_helper'

RSpec.describe BudgetTransaction, type: :model do
  subject do
    @user = create(:user)
    @group = @user.groups.create(name: 'group1', icon: 'icon')
    build(:budget_transaction, amount: 5.69, author: @user, group_ids: [@group.id])
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

  it 'Should not be valid when a group_ids is nil' do
    subject.group_ids = []
    expect(subject).to_not be_valid
  end

  it "Should reduce the author's balance" do
    subject.save
    expect(subject.author.balance.to_s).to eq '14.31'
  end
end
