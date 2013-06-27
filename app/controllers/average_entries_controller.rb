class AverageEntriesController < ApplicationController
  before_action :set_average_entry, only: [:show, :edit, :update, :destroy]

  # GET /average_entries
  # GET /average_entries.json
  def index
    @average_entries = AverageEntry.all
  end

  # GET /average_entries/1
  # GET /average_entries/1.json
  def show
  end

  # GET /average_entries/new
  def new
    @average_entry = AverageEntry.new
    @bowler = Bowler.find(params[:bowler_id])
  end

  # GET /average_entries/1/edit
  def edit
    @bowler = @average_entry.bowler
  end

  # POST /average_entries
  # POST /average_entries.json
  def create
    @average_entry = AverageEntry.new(average_entry_params)

    respond_to do |format|
      if @average_entry.save
        format.html { redirect_to bowlers_path, notice: 'Average entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @average_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @average_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /average_entries/1
  # PATCH/PUT /average_entries/1.json
  def update
    respond_to do |format|
      if @average_entry.update(average_entry_params)
        format.html { redirect_to @average_entry, notice: 'Average entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @average_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /average_entries/1
  # DELETE /average_entries/1.json
  def destroy
    @average_entry.destroy
    respond_to do |format|
      format.html { redirect_to average_entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_average_entry
      @average_entry = AverageEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def average_entry_params
      params.require(:average_entry).permit(:average, :bowler_id, :user_id)
    end
end
