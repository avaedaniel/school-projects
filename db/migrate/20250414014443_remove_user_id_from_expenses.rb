class RemoveUserIdFromExpenses < ActiveRecord::Migration[8.0]
  def change
    remove_column :expenses, :user_id, :integer
  end
end
