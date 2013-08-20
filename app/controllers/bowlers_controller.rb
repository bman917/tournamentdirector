class BowlersController < ApplicationController
  include SessionsHelper

  before_action :set_bowler, only: [:show, :edit, :update, :destroy]
  before_action :user_is_admin?, only: [:edit, :update, :destroy, :create]

  def names
    @bowlers = Bowler.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @bowlers.map(&:name)
  end


  def search_entries
    clear_selected_squad
    if params[:bowler]
      @bowler = Bowler.find_by_name(bowler_params[:name])
      if @bowler
        @squad_entries = @bowler.get_tournament_entries(selected_tournament)
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
    @bowlers = Bowler.all.paginate(page: params[:page])

    session[:selected_tournament] = nil
    session[:selected_squad] = nil
    session[:selected_squad_entry] = nil

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
        format.html { redirect_to @bowler, notice: 'Bowler was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bowler }
      else
        format.html { render action: 'new' }
        format.json { render json: @bowler.errors, status: :unprocessable_entity }
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
      @bowler = Bowler.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowler_params
      params.require(:bowler).permit(:name, :gender, :bowling_association_id)
    end
end
