class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def list
    @squad_entry = SquadEntry.find(params[:squad_entry_id])
    @games = @squad_entry.games
    session[:selected_squad_entry] = @squad_entry.id

    @back_path = squad_path(@squad_entry.squad_id)

    render 'index'

  end

  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    session[:selected_tournament] = nil
    session[:selected_squad] = nil
    session[:selected_squad_entry] = nil

  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    game_params_with_notes = game_params
    game_params_with_notes[:notes] = "#{@game.notes} O-#{@game.score},N-#{game_params[:score]}"
    respond_to do |format|
      if @game.update(game_params_with_notes)
        if session[:selected_squad_entry]
          format.html { redirect_to squad_entry_games_path(session[:selected_squad_entry]), notice: 'Game was successfully updated.' }
        else
          format.html { redirect_to @game, notice: 'Game was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      if session[:selected_squad_entry]
        format.html { redirect_to squad_entry_games_path(session[:selected_squad_entry]), notice: 'Game was successfully updated.' }
      else
        format.html { redirect_to games_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:score, :bowler_id, :notes, :user_id)
    end
end
