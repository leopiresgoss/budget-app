require 'rails_helper'

RSpec.describe Group, type: :model do
  subject do
    @user = create(:user)
    build(:group, author: @user)
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
      create(:budget_transaction, amount: 5.2, author: @user, group_ids: [group.id])
      create(:budget_transaction, amount: 1, author: @user, group_ids: [group.id])
      false_group = create(:group, author: @user)
      create(:budget_transaction, amount: 10, author: @user, group_ids: [false_group.id])
      expect(subject.total_amount.to_f).to be(6.2)
    end
  end
end
