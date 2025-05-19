class AddPayerToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :payer_id, :integer
  end
end
