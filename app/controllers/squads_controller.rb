class SquadsController < ApplicationController
  before_action :set_squad, only: [:show, :edit, :update, :destroy]

  def list
    @tournament = Tournament.find(params[:tournament_id])
    @squads = @tournament.squads    

  end

  # GET /squads
  # GET /squads.json
  def index
    @squads = Squad.all
  end

  # GET /squads/1
  # GET /squads/1.json
  def show
  end

  # GET /squads/new
  def new
    @squad = Squad.new
    @tournament = Tournament.find(params[:tournament_id])
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
        format.html { redirect_to tournament_squads_path(@squad.tournament), notice: 'Squad was successfully created.' }
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
        format.html { redirect_to tournament_squads_path(@squad.tournament), notice: 'Squad was successfully updated.' }
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
      format.html { redirect_to tournament_squads_path(tournament) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_squad
      @squad = Squad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def squad_params
      params.require(:squad).permit(:name, :time, :tournament_id, :user_id)
    end
end
