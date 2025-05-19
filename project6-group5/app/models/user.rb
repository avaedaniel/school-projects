class User < ApplicationRecord
  has_many :trip_participants
  has_many :trips, through: :trip_participants
  
    VALID_OSU_EMAIL_REGEX = /\A[a-zA-Z]+\.[0-9]+@osu\.edu\z/
    validates :email, presence: true, format: { with: VALID_OSU_EMAIL_REGEX, message: "must be in the format string.number@osu.edu" }
  end
  