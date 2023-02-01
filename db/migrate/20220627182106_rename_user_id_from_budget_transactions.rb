class RenameUserIdFromBudgetTransactions < ActiveRecord::Migration[7.0]
  def change
    change_table :budget_transactions do |t|
      t.rename :users_id, :author_id
    end
  end
end
