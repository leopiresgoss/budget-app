class RenameUserIdFromGroups < ActiveRecord::Migration[7.0]
  def change
    change_table :groups do |t|
      t.rename :users_id, :author_id
    end
  end
end
