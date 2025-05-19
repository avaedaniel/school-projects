# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create!(name: "Alice", email: "alice.123@osu.edu")
trip = Trip.create!(name: "Spring Break", start_date: Date.today, end_date: Date.today + 5.days, user: user)
participant1 = Participant.create!(name: "Alice", user: user, trip: trip)
#participant2 = Participant.create!(name: "Bob", trip: trip)
category = Category.create!(name: "Food")
Expense.create!(description: "Dinner", amount: 60.0, date: Date.today, currency: "USD", expense_type: "shared", trip: trip, category: category, payer: participant1, participants: [participant1])
