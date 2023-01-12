class BudgetTransaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups

  validates_associated :author
  validates :name, :amount, presence: true
  validates :amount, numericality: true, comparison: { greater_than_or_equal_to: 0.01 }
  validates :group_ids, length: { minimum: 1 }
  validate :budget_available, on: :create

  private

  def budget_available
    if BigDecimal(author.balance.to_s) - amount <= 0
      errors.add(:base, "You don't have enough money to make this transaction, please add more money first")
    end
  end

  def update_author_balance
    author.balance -= amount
    author.save
  end
end
