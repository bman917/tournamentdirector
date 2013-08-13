class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :edit, :update, :destroy]
  before_action :clear_selected_squad_from_session, only: [:index]
  before_action :user_is_admin?
  skip_before_action :user_is_admin?, only: [:show]

  include SessionsHelper

#  def list
#    @tournament = Tournament.find(params[:tournament_id])
#    @squads = @tournament.squads    
#    session[:selected_tournament] = @tournament.id
#    session[:selected_squad] = nil
#    session[:selected_squad_entry] = nil
#  end

  def clear_selected_squad_from_session
    clear_selected_squad
  end

  # GET /squads
  # GET /squads.json
  def index
    
    @squads = selected_tournament.squads
  end

  # GET /squads/1
  # GET /squads/1.json
  def show

    session[:selected_squad_entry] = nil
    session[:last_action] = :squad

    @category_css = @updated_squad_entry.category_css if @updated_squad_entry
    @category_css ||= BowlerClass.first

  end

  # GET /squads/new
  def new
    @squad = Squad.new
    @tournament = selected_tournament;
    @next_squad_number = @tournament.squads.count+1
    
  end

  # GET /squads/1/edit
  def edit
    @tournament = @squad.tournament
    @next_squad_number = @squad.name
  end

  # POST /squads
  # POST /squads.json
  def create
    @squad = Squad.new(squad_params)

    respond_to do |format|
      if @squad.save
        format.html { redirect_to tournament_select_path(selected_tournament), notice: 'Squad was successfully created.' }
        format.json { render action: 'show', status: :created, location: @squad }
      else
        format.html { render action: 'new' }
        format.json { render json: @squad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /squads/1
  # PATCH/PUT /squads/1.json
  def update
    respond_to do |format|
      if @squad.update(squad_params)
        format.html { redirect_to tournament_select_path(@squad.tournament), notice: 'Squad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @squad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /squads/1
  # DELETE /squads/1.json
  def destroy
    tournament = @squad.tournament
    @squad.destroy
    respond_to do |format|
      format.html { redirect_to tournament_select_path(tournament) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_squad

      if (params[:updated_squad_entry_id])
        #If this parameter is present it means that a SquadEntry has been updated/created.
        #The updatd SquadEntry is forwarded to the next page so that there's an option to highligh it.
        @updated_squad_entry = SquadEntry.find(params[:updated_squad_entry_id])
        @squad = @updated_squad_entry.squad
      else

        @squad = Squad.find(params[:id])
      end
      session[:selected_squad] = @squad.id

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def squad_params
      params.require(:squad).permit(:name, :time, :tournament_id, :user_id)
    end
end
