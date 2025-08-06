class ParticipantsController < ApplicationController
  before_action :set_trip
  before_action :set_participant, only: %i[ show edit update destroy ]

  # GET /trips/:trip_id/participants
  def index
    @participants = @trip.participants.includes(:user)
  end

  # GET /trips/:trip_id/participants/1
  def show
  end

  # GET /trips/:trip_id/participants/new
  def new
    @participant = @trip.participants.new
    # Get users who are not already participants in this trip
    @available_users = User.where.not(id: @trip.participants.pluck(:user_id))
  end

  # GET /trips/:trip_id/participants/1/edit
  def edit
    @available_users = User.all
  end

  # POST /trips/:trip_id/participants
  def create
    @participant = @trip.participants.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to trip_participants_path(@trip), notice: "Participant was successfully added." }
        format.json { render :show, status: :created, location: [@trip, @participant] }
      else
        @available_users = User.where.not(id: @trip.participants.pluck(:user_id))
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/:trip_id/participants/1
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to trip_participants_path(@trip), notice: "Participant was successfully updated." }
        format.json { render :show, status: :ok, location: [@trip, @participant] }
      else
        @available_users = User.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/:trip_id/participants/1
  def destroy
    @participant.destroy!

    respond_to do |format|
      format.html { redirect_to trip_participants_path(@trip), status: :see_other, notice: "Participant was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Set the trip for all actions
    def set_trip
      @trip = Trip.find(params[:trip_id])
    end
    
    # Use callbacks to share common setup or constraints between actions
    def set_participant
      @participant = @trip.participants.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def participant_params
      params.require(:participant).permit(:name, :user_id)
    end
end
