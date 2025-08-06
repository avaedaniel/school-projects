# app/controllers/trips_controller.rb
class TripsController < ApplicationController
  before_action :set_trip, only: %i[show edit update destroy settle]

  def index
    @trips = Trip.all
  end

  def show
    @expenses = @trip.expenses.includes(:payer)
    @participants = @trip.participants
  end

  def new
    @trip = Trip.new
  end

  def edit
  end

  def create
    @trip = Trip.new(trip_params)
  
    if @trip.save
      # Add the owner as a participant
      user = User.find_by(id: @trip.user_id)
      @trip.participants.create(user: user, name: user.name) if user
  
      redirect_to @trip, notice: "Trip was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip, notice: "Trip was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Helper method to add participants to a new trip
  def add_participants_to_trip(trip, user_ids)
    user_ids.each do |user_id|
      next if user_id.blank?
      user = User.find(user_id)
      trip.participants.create(user: user, name: user.name)
    end
  end
  
  # Helper method to update participants
  def update_participants_for_trip(trip, user_ids)
    # Remove participants who were unchecked
    trip.participants.where.not(user_id: user_ids).destroy_all
    
    # Add new participants
    existing_user_ids = trip.participants.pluck(:user_id)
    user_ids.each do |user_id|
      next if user_id.blank? || existing_user_ids.include?(user_id.to_i)
      user = User.find(user_id)
      trip.participants.create(user: user, name: user.name)
    end
  end

  def destroy
    @trip.destroy!
    redirect_to trips_url, notice: "Trip was successfully destroyed."
  end

# app/controllers/trips_controller.rb
def settle
  @participants = @trip.participants.includes(:expenses, :payments) || []
  @balances = {}
  @initial_balances = {}
  @transactions = []

  # Step 1: Calculate debts per expense for each participant
  debts_per_expense = {} # { participant => [{expense, amount_owed}] }
  @participants.each do |participant|
    debts_per_expense[participant] = []
    total_owed = 0
    participant.expenses.where(trip_id: @trip.id).each do |expense|
      participants_count = expense.participants.count
      share = expense.amount / participants_count if participants_count > 0
      if expense.payer_id != participant.user_id
        # Find payments for this expense by description
        payments_for_expense = participant.payments.where(trip_id: @trip.id, description: expense.description)
        total_paid_for_expense = payments_for_expense.sum(:amount).to_f
        amount_owed = share.to_f - total_paid_for_expense
        debts_per_expense[participant] << { expense: expense, amount_owed: amount_owed }
        total_owed += amount_owed
      end
    end

    # Total paid across all expenses for initial balance
    total_paid = participant.payments.where(trip_id: @trip.id).sum(:amount).to_f
    @initial_balances[participant] = total_owed
    @balances[participant] = total_owed
  end

  # Step 2: Calculate amounts owed to each payer (what they are owed)
  payer_balances = {}
  @participants.each do |participant|
    total_spent = Expense.where(trip_id: @trip.id, payer_id: participant.user_id).sum(:amount).to_f
    total_owed_by_payer = 0
    Expense.where(trip_id: @trip.id, payer_id: participant.user_id).each do |expense|
      participants_count = expense.participants.count
      share = expense.amount / participants_count if participants_count > 0
      total_owed_by_payer += share.to_f
    end
    total_received = Payment.where(trip_id: @trip.id, recipient_id: participant.user_id).sum(:amount).to_f
    payer_balance = total_spent - total_owed_by_payer - total_received
    payer_balances[participant] = payer_balance
  end

  # Step 3: Suggest transactions to settle debts per expense
  @participants.each do |debtor|
    debtor_debts = debts_per_expense[debtor]
    debtor_debts.each do |debt|
      amount_owed = debt[:amount_owed]
      expense = debt[:expense]
      next if amount_owed <= 0

      # Find the payer of this expense (the creditor)
      creditor = @participants.find { |p| p.user_id == expense.payer_id }
      next unless creditor # Skip if the creditor isn’t a participant
      amount_owed_to = payer_balances[creditor]
      next if amount_owed_to <= 0

      amount_to_settle = [amount_owed, amount_owed_to].min
      if amount_to_settle > 0
        @transactions << { from: debtor, to: creditor, amount: amount_to_settle, expense: expense.description }
        @balances[debtor] -= amount_to_settle
        payer_balances[creditor] -= amount_to_settle
        debt[:amount_owed] -= amount_to_settle
      end
    end
  end
end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :user_id)
  end
end

def add_participants_to_trip(trip, user_ids)
  # still need to finish this
  user_ids.each do |user_id|
    user = User.find_by(id: user_id)
    next unless user

    # Avoid duplicate participants
    unless trip.participants.exists?(user_id: user.id)
      trip.participants.create!(user: user)
    end
  end
end
