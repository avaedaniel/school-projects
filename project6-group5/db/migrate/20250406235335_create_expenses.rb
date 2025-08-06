class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :amount
      t.date :date
      t.string :currency
      t.string :expense_type
      t.references :trip, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :payer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
