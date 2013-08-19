class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :edit, :update, :destroy]
  before_action :clear_selected_squad_from_session, only: [:index]
  before_action :user_is_admin?
  skip_before_action :user_is_admin?, only: [:show_by_category, :show]

  include SessionsHelper

  def clear_selected_squad_from_session
    clear_selected_squad
  end

  # GET /squads
  # GET /squads.json
  def index
    @squads = selected_tournament.squads
  end

  def show_by_category

    @squad = set_squad
    @presenter = Squads::ShowPresenter.new(@squad)


    @category =  params[:bowler_class_name] || 'OPEN'
    @game_type = GameType.find_by_name(params[:game_type_name]) || selected_tournament.game_types.first
    
    set_selected_bowler_class_and_game_type(@category, @game_type.name)
    
    id = params[:squad_id] || params[:id]
    
    @squad_entries = @squad.squad_entries

    

    flash.keep if flash[:updated_squad_entry_id]
    render 'show'
  end

  # GET /squads/1
  # GET /squads/1.json
  def show
    clear_selected_squad_entry
    session[:last_action] = :squad
    show_by_category
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
      id = params[:squad_id] || params[:id]
      @squad = selected_tournament.squads.find(id, :include => :squad_entries)
      set_selected_squad(@squad)
      return @squad
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def squad_params
      params.require(:squad).permit(:name, :time, :tournament_id, :user_id)
    end
end
