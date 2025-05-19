class Participant < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_and_belongs_to_many :expenses, dependent: :destroy
  has_many :payments
  
  validates :user_id, uniqueness: { scope: :trip_id, message: "is already a participant in this trip" }
  
  before_validation :set_name_from_user, if: -> { name.blank? && user.present? }
  
  private
  
  def set_name_from_user
    self.name = user.name
  end
end