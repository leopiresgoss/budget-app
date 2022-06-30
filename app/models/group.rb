class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :budget_transactions

  validates_associated :author
  validates :name, :icon, presence: true

  def total_amount
    budget_transactions.sum(:amount)
  end
end
