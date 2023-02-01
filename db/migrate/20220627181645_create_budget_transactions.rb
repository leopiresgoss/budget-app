class CreateBudgetTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :budget_transactions do |t|
      t.string :name
      t.decimal :amount
      t.references :users, null: false, foreign_key: true
      t.datetime :created_at
    end
  end
end
