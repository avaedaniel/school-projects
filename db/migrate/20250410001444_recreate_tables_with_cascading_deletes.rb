class RecreateTablesWithCascadingDeletes < ActiveRecord::Migration[8.0]
  def change
    # Drop existing tables with reversible blocks
    drop_table :payments do |t|
      t.decimal :amount
      t.string :description
      t.date :date
      t.string :currency
      t.integer :trip_id, null: false
      t.integer :user_id, null: false
      t.integer :recipient_id, null: false
      t.integer :participant_id, null: false
      t.datetime :created_at, precision: nil
      t.datetime :updated_at, precision: nil
      t.index :recipient_id, name: "index_payments_on_recipient_id"
      t.index :trip_id, name: "index_payments_on_trip_id"
      t.index :user_id, name: "index_payments_on_user_id"
      t.index :participant_id, name: "index_payments_on_participant_id"
    end

    drop_table :expenses do |t|
      t.string :description
      t.decimal :amount
      t.integer :category_id, null: false
      t.integer :trip_id, null: false
      t.integer :user_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index :category_id, name: "index_expenses_on_category_id"
      t.index :trip_id, name: "index_expenses_on_trip_id"
      t.index :user_id, name: "index_expenses_on_user_id"
    end

    drop_table :participants do |t|
      t.string :name
      t.integer :user_id, null: false
      t.integer :trip_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index :trip_id, name: "index_participants_on_trip_id"
      t.index :user_id, name: "index_participants_on_user_id"
    end

    drop_table :expenses_participants do |t|
      t.integer :expense_id, null: false
      t.integer :participant_id, null: false
      t.index :expense_id, name: "index_expenses_participants_on_expense_id"
      t.index :participant_id, name: "index_expenses_participants_on_participant_id"
    end

    # Recreate participants table with ON DELETE CASCADE
    create_table :participants do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    # Recreate expenses table with ON DELETE CASCADE
    create_table :expenses do |t|
      t.string :description
      t.decimal :amount
      t.references :category, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    # Recreate payments table with ON DELETE CASCADE
    create_table :payments do |t|
      t.decimal :amount
      t.string :description
      t.date :date
      t.string :currency
      t.references :trip, null: false, foreign_key: { on_delete: :cascade }
      t.references :user, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :participant, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps precision: nil
    end

    # Recreate expenses_participants table with ON DELETE CASCADE
    create_table :expenses_participants, id: false do |t|
      t.references :expense, null: false, foreign_key: { on_delete: :cascade }
      t.references :participant, null: false, foreign_key: { on_delete: :cascade }
    end
  end
end
