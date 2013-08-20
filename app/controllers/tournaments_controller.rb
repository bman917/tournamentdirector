class TournamentsController < ApplicationController

  include SessionsHelper

  before_action :set_tournament, only: [:edit, :update, :destroy]
  before_action :user_is_master?, only: [:new, :edit, :update, :destroy, :create]

  def bowlers
    @bowlers = selected_tournament.bowlers2
  end

  # GET /tournaments
  # GET /tournaments.json
  def index
    clear_selected_tournament
    @tournaments = current_user.tournaments
  end

  def latest
    @tournament = current_user.tournaments.last
    set_selected_tournament(@tournament)
  end

  def select
    @tournament = current_user.tournaments.find(params[:tournament_id]) || current_user.tournaments.last
    set_selected_tournament(@tournament)
  end


  def show
    if current_user.master?
      @tournament = Tournament.find(params[:id])
    else
      self.latest
    end
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tournament }
      else
        format.html { render action: 'new' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    @tournament.destroy
    respond_to do |format|
      format.html { redirect_to tournaments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:name, :tournament_type, :start_date, :end_date, :bowling_association_id)
    end
end
