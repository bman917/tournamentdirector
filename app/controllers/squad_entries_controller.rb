class SquadEntriesController < ApplicationController
  before_action :set_squad_entry, only: [:show, :edit, :update, :destroy, :new_game, :create_game]

  def new_game

    @game = Game.new
    @squad = @squad_entry.squad
    session[:selected_squad_entry] = params[:id]
    

  end

  def create_game

    squad = @squad_entry.squad
    errors = nil

    @squad_entry.bowlers.each do | bowler |
      @game = bowler.games.create(
        squad_entry_id: @squad_entry.id,
               user_id: session[:user_id],
                 score: params["score_#{bowler.id}"])
        
      errors = @game.errors
      puts "Created game      : #{@game.errors}"
      puts "Recored game score: #{@game.score}"
      
#      if @game.errors
 #       respond_to do |format|
  #        puts "redirecting to #{new_squad_entry_game_path @squad_entry}"
          #format.html { render  squads(squad)}
          #format.json { render json: @squad_entry.errors, status: :unprocessable_entity }
   #       return
    #    end
      #end
      break if @game.errors
    end

    respond_to do |format|
      if @game.errors.any?
        format.html { render 'new_game'}
      else
        path = squad_path(@squad_entry.squad)
        if session[:last_action] == :squad_entry_games
          path = squad_entry_games_path @squad_entry
        end
        format.html { redirect_to path, notice: 'Game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @squad_entry }
      end
    end
  end

  # GET /squad_entries
  # GET /squad_entries.json
  def index
    @squad_entries = SquadEntry.all
  end

  # GET /squad_entries/1
  # GET /squad_entries/1.json
  def show
  end

  # GET /squad_entries/new
  def new
    @squad_entry = SquadEntry.new
    @squad = Squad.find(params[:squad_id])
    entry_type = params[:entry_type]
    @squad_entry.entry_type = entry_type

    @number_of_bowlers = 1 if entry_type == 'Singles'
    @number_of_bowlers = 2 if entry_type == 'Doubles'
    @number_of_bowlers = 3 if entry_type == 'Team'

    session[:selected_squad] = @squad.id
    

  end

  # GET /squad_entries/1/edit
  def edit
  end

  # POST /squad_entries
  # POST /squad_entries.json
  def create

    @squad_entry = SquadEntry.new(squad_entry_params)


    puts "Squad ID: #{squad_entry_params[:category]}"
    entry_type = squad_entry_params[:entry_type]
    bowler_id_hash = params[:bowlers]
    number_of_bowlers = bowler_id_hash.size
    puts "Number of Bowler IDs: #{number_of_bowlers}, Entry Type: #{entry_type}"


    (1..number_of_bowlers).each do |i|
      bowler = Bowler.find(bowler_id_hash[i.to_s])
      @squad_entry.bowlers << bowler
    end


    respond_to do |format|
      if @squad_entry.save
        format.html { redirect_to squad_entry_games_path(@squad_entry), notice: 'Squad entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @squad_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @squad_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /squad_entries/1
  # PATCH/PUT /squad_entries/1.json
  def update
    respond_to do |format|
      if @squad_entry.update(squad_entry_params)
        format.html { redirect_to @squad_entry, notice: 'Squad entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @squad_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /squad_entries/1
  # DELETE /squad_entries/1.json
  def destroy
    @squad_entry.destroy
    respond_to do |format|
      format.html { redirect_to squad_path(@squad_entry.squad) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_squad_entry
      @squad_entry = SquadEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def squad_entry_params
      params.require(:squad_entry).permit(:category, :entry_type, :bowlers, :squad_id)
    end
end
