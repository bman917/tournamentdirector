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
      (1..@squad_entry.game_type.number_of_games).each do |i|
        @game = bowler.games.create(
          squad_entry_id: @squad_entry.id,
                 user_id: session[:user_id],
                   score: params["bowler_#{bowler.id}_game_#{i}"],
                   notes: "#{i}")

        errors = @game.errors
        puts "Created game      : #{@game.errors}"
        puts "Recored game score: #{@game.score}"
        puts "Last Action       : #{session[:last_action]}"

        break if @game.errors.any?
      end
    end

    respond_to do |format|
      if @game.errors.any?
        format.html { render 'new_game'}
      else
        path = squad_updated_entry_path(@squad_entry)
        if session[:last_action] == :squad_entry_games
          path = squad_entry_path @squad_entry
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
    session[:selected_squad_entry] = @squad_entry.id
    session[:last_action] = :squad_entry_games
  end

  # GET /squad_entries/new
  def new
    @squad_entry = SquadEntry.new
    @squad = Squad.find(params[:squad_id])
    
    game_type = GameType.find(params[:game_type_id])

    @squad_entry.game_type = game_type

    @number_of_bowlers = game_type.number_of_players

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
    game_type = squad_entry_params[:game_type]
    bowler_id_hash = params[:bowlers]
    number_of_bowlers = bowler_id_hash.size
    puts "Number of Bowler IDs: #{number_of_bowlers}, Entry Type: #{game_type}"


    (1..number_of_bowlers).each do |i|
      bowler = Bowler.find(bowler_id_hash[i.to_s])
      @squad_entry.bowlers << bowler
    end

    @new_squad_entry = @squad_entry


    respond_to do |format|
      if @squad_entry.save
        format.html { redirect_to squad_updated_entry_path(@squad_entry.id), notice: 'Squad entry was successfully created.' }
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
      params.require(:squad_entry).permit(:category, :game_type_id, :bowlers, :squad_id)
    end
end
