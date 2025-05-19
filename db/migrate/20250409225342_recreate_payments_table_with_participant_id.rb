class RecreatePaymentsTableWithParticipantId < ActiveRecord::Migration[8.0]
  def change
    # Drop the existing payments table, and provide a block to recreate it during rollback
    drop_table :payments do |t|
      t.decimal :amount
      t.string :description
      t.date :date
      t.string :currency
      t.integer :trip_id, null: false
      t.integer :user_id, null: false
      t.integer :recipient_id, null: false
      t.integer :participant_id
      t.datetime :created_at, precision: nil
      t.datetime :updated_at, precision: nil
      t.index :recipient_id, name: "index_payments_on_recipient_id"
      t.index :trip_id, name: "index_payments_on_trip_id"
      t.index :user_id, name: "index_payments_on_user_id"
      t.index :participant_id, name: "index_payments_on_participant_id"
    end

    # Recreate the payments table with the correct foreign key constraints
    create_table :payments do |t|
      t.decimal :amount
      t.string :description
      t.date :date
      t.string :currency
      t.references :trip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :participant, null: false, foreign_key: true
      t.timestamps precision: nil
    end
  end
end
