class SquadEntriesController < ApplicationController
  before_action :set_squad_entry, only: [:show, :edit, :update, :destroy]

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
        format.html { redirect_to squad_path(@squad_entry.squad), notice: 'Squad entry was successfully created.' }
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
      format.html { redirect_to squad_entries_url }
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
