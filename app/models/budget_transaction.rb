class BudgetTransaction < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups

  validates_associated :author
  validates :name, :amount, presence: true
  validates :amount, numericality: true, comparison: { greater_than_or_equal_to: 0.01 }
  validates :group_ids, length: { minimum: 1 }
end
