class Payment < ApplicationRecord
  belongs_to :trip
  belongs_to :user    # The user who made the payment
  belongs_to :participant  # Add this to associate the payment with a participant
  belongs_to :recipient, class_name: 'User'  # The user who received the payment
   #belongs_to :payer, class_name: 'User'

  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  
  scope :for_trip, ->(trip_id) { where(trip_id: trip_id) }
end
