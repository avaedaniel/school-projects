class AddTotalAmountToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :total_amount, :decimal
  end
end
