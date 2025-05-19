class Expense < ApplicationRecord
  belongs_to :trip
  belongs_to :payer, class_name: 'User', foreign_key: 'payer_id'
  # Add the has_and_belongs_to_many relationship for participants
  has_and_belongs_to_many :participants

  validates :description, :amount, :date, presence: true
  validates :amount, numericality: { greater_than: 0 }

  # Automatically include all trip participants if none selected
  after_create :assign_default_participants

  private

  def assign_default_participants
    participants << trip.participants if participants.empty?
  end
end