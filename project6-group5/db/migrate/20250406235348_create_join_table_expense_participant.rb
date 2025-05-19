class CreateJoinTableExpenseParticipant < ActiveRecord::Migration[8.0]
  def change
    create_join_table :expenses, :participants do |t|
      # t.index [:expense_id, :participant_id]
      # t.index [:participant_id, :expense_id]
    end
  end
end
