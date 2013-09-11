class BowlersController < ApplicationController
  include SessionsHelper

  before_action :set_bowler, only: [:show, :edit, :update, :destroy]
  before_action :user_is_admin?, only: [:edit, :update, :destroy, :create]

  def average
    @bowler = set_bowler
    @average = @bowler.average(selected_tournament)


  end

  def names
    @bowlers = Bowler.order(:name).where('name LIKE ? or last_name LIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
    render json: @bowlers.map(&:full_name)
  end


  def search_entries
    clear_selected_squad
    if params[:bowler]
      @bowler = Bowler.search(bowler_params[:name])
      if @bowler
        @squad_entries = @bowler.first.get_tournament_entries(selected_tournament)
        render 'show_entries'
      else
        flash.now.alert = "Bowler #{bowler_params[:name]} Not Found!"
      end
    end
  end


  def show_entries
    @bowler = Bowler.find(params[:bowler_id])
    @squad_entries = @bowler.get_tournament_entries(selected_tournament)
  end

  # GET /bowlers
  # GET /bowlers.json
  def index
    @bowlers = Bowler.search(params[:search]).order(:last_name).paginate(page: params[:page])
    @bowler = Bowler.new
    clear_selected_tournament
  end



  # GET /bowlers/1
  # GET /bowlers/1.json
  def show
  end

  # GET /bowlers/new
  def new
    @bowler = Bowler.new
    @ass = BowlingAssociation.all
  end

  # GET /bowlers/1/edit
  def edit
  end

  # POST /bowlers
  # POST /bowlers.json
  def create
    ass = BowlingAssociation.find(bowler_params[:bowling_association_id])
    
    @bowler = ass.bowlers.create(bowler_params)

    
    respond_to do |format|
      if @bowler.save
        @bowler.average_entries.create(average: bowler_params[:pbc_average])
        flash[:create_notice] = "Bowler #{@bowler.name} has successfully been added."
        format.html { redirect_to @bowler }
        format.js { render 'create' }
      else
        format.html { render action: 'new' }
        format.json { render json: @bowler.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PATCH/PUT /bowlers/1
  # PATCH/PUT /bowlers/1.json
  def update
    respond_to do |format|
      if @bowler.update(bowler_params)
        format.html { redirect_to @bowler, notice: 'Bowler was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bowler.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bowlers/1
  # DELETE /bowlers/1.json
  def destroy
    @bowler.destroy
    respond_to do |format|
      format.html { redirect_to bowlers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bowler
      bowler_id = params[:id] || params[:bowler_id]
      @bowler = Bowler.find(bowler_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowler_params
      params.require(:bowler).permit(:full_name, :last_name, :middle_name, :name, :gender, :bowling_association_id, :pbc_classification_id, :pbc_average)
    end
end
