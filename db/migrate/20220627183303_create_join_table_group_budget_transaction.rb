class CreateJoinTableGroupBudgetTransaction < ActiveRecord::Migration[7.0]
  def change
    create_join_table :budget_transactions, :groups do |t|
      t.index :budget_transaction_id
      t.index :group_id
    end
  end
end
