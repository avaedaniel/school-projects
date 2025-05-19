# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  before_action :set_trip
  before_action :set_payment, only: %i[ show edit update destroy ]

  # GET /trips/:trip_id/payments
  def index
    @payments = @trip.payments.includes(:user, :recipient).order(date: :desc)
  end

  # GET /trips/:trip_id/payments/1
  def show
  end

  # GET /trips/:trip_id/payments/new
  def new
    @payment = @trip.payments.new
    @payment.date = Date.today
    @expense_descriptions = @trip.expenses.pluck(:description)
    # Get all users who are participants in this trip
    @participants = @trip.participants.includes(:user).map(&:user).uniq
  end

  # GET /trips/:trip_id/payments/1/edit
  def edit
    @participants = @trip.participants.includes(:user).map(&:user).uniq
  end

  # POST /trips/:trip_id/payments
  def create
    puts "Received params: #{params.inspect}"
    @payment = @trip.payments.new(payment_params.except(:participant_id))
    puts "Payment before save: #{@payment.inspect}"
    @payment = @trip.payments.new(payment_params.except(:participant_id))
    
    begin
      participant = Participant.find(params[:payment][:participant_id])
      @payment.participant = participant
      @payment.user_id = participant.user_id
    rescue ActiveRecord::RecordNotFound
      @payment.errors.add(:participant, "must exist")
    end
  
    respond_to do |format|
      if @payment.errors.empty? && @payment.save
        format.html { redirect_to trip_payments_path(@trip), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: [@trip, @payment] }
      else
        puts "Payment save failed. Errors: #{@payment.errors.full_messages}" # Debug output
        @participants = @trip.participants.includes(:user).map(&:user).uniq
        @expense_descriptions = @trip.expenses.pluck(:description)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /trips/:trip_id/payments/1
  def update
    # Update the participant if provided
    if params[:payment][:participant_id].present?
      @payment.participant = Participant.find(params[:payment][:participant_id])
      @payment.user_id = @payment.participant.user_id # Update user_id to match the new participant's user_id
    end

    respond_to do |format|
      if @payment.update(payment_params.except(:participant_id))
        format.html { redirect_to trip_payments_path(@trip), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: [@trip, @payment] }
      else
        @users = User.all
        @participants = @trip.participants.includes(:user).map(&:user).uniq
        @expense_descriptions = @trip.expenses.pluck(:description)
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/:trip_id/payments/1
  def destroy
    @payment.destroy!

    respond_to do |format|
      format.html { redirect_to trip_payments_path(@trip), notice: "Payment was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_trip
      @trip = Trip.find(params[:trip_id])
    end
    
    def set_payment
      @payment = @trip.payments.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:amount, :description, :date, :currency, :recipient_id, :participant_id)
    end
end