class AddDateToExpenses < ActiveRecord::Migration[8.0]
  def change
    # Only add column if it doesn't exist
    unless column_exists?(:expenses, :date)
      add_column :expenses, :date, :date
    end
  end
end