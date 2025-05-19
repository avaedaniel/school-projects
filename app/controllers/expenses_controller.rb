# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  before_action :set_trip
  before_action :set_expense, only: %i[ show edit update destroy select_participants update_participants ]

  # GET /trips/:trip_id/expenses
  def index
    @expenses = @trip.expenses.includes(:payer)
  end

  # GET /trips/:trip_id/expenses/1
  def show
  end

  # GET /trips/:trip_id/expenses/new
  def new
    @expense = @trip.expenses.new
    @expense.date = Date.today
    @participants = @trip.participants || []
    @users = User.all # Add this line to set @users
  end
  # GET /trips/:trip_id/expenses/1/edit
  def edit
    @participants = @trip.participants
    @users = User.all # Add this line to set @users
  end

  # GET /trips/:trip_id/expenses/1/select_participants
  def select_participants
    @participants = @trip.participants
    @selected_participants = @expense.participants
  end

  # PATCH /trips/:trip_id/expenses/1/update_participants
  def update_participants
    participant_ids = params[:expense][:participant_ids] || []
    
    @expense.participants = @trip.participants.where(id: participant_ids)
    
    respond_to do |format|
      if @expense.save
        format.html { redirect_to trip_expense_path(@trip, @expense), notice: "Expense participants were successfully updated." }
        format.json { render :show, status: :ok, location: [@trip, @expense] }
      else
        @participants = @trip.participants
        @selected_participants = @expense.participants
        format.html { render :select_participants, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /trips/:trip_id/expenses
def create
  @expense = @trip.expenses.new(expense_params)
  respond_to do |format|
    if @expense.save
      # Ensure the payer is a participant
      payer_participant = @trip.participants.find_by(user_id: @expense.payer_id)
      unless payer_participant
        payer_user = User.find(@expense.payer_id)
        payer_participant = @trip.participants.create(user_id: payer_user.id, name: payer_user.name)
      end
      # Add the payer to the expense participants if not already included
      unless @expense.participants.include?(payer_participant)
        @expense.participants << payer_participant
      end
      # Add selected participants
      if params[:expense][:participant_ids].present?
        @expense.participants = @trip.participants.where(id: params[:expense][:participant_ids])
      end
      format.html { redirect_to trip_expense_path(@trip, @expense), notice: "Expense was successfully created." }
      format.json { render :show, status: :created, location: [@trip, @expense] }
    else
      @participants = @trip.participants
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @expense.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /trips/:trip_id/expenses/1
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        # Handle participant selection
        if params[:expense][:participant_ids].present?
          @expense.participants = @trip.participants.where(id: params[:expense][:participant_ids])
        end
        
        format.html { redirect_to trip_expense_path(@trip, @expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: [@trip, @expense] }
      else
        @participants = @trip.participants
        @users = User.all # Add this line to set @users
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/:trip_id/expenses/1
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to trip_expenses_path(@trip), notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_trip
      @trip = Trip.find(params[:trip_id])
    end
    
    def set_expense
      @expense = @trip.expenses.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:description, :amount, :date, :currency, :expense_type, :payer_id, participant_ids: [])
    end
end