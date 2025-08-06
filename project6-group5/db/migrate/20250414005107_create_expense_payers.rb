class CreateExpensePayers < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_payers do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
