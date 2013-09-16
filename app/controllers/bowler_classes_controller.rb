class BowlerClassesController < ApplicationController
  before_action :set_bowler_class, only: [:show, :edit, :update, :destroy]

  # GET /bowler_classes
  def index
    @bowler_classes = BowlerClass.all
  end

  # GET /bowler_classes/1
  def show
  end

  # GET /bowler_classes/new
  def new
    @bowler_class = BowlerClass.new
  end

  # GET /bowler_classes/1/edit
  def edit
  end

  # POST /bowler_classes
  def create
    @bowler_class = BowlerClass.new(bowler_class_params)

    if @bowler_class.save
      redirect_to @bowler_class, notice: 'Bowler class was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bowler_classes/1
  def update
    if @bowler_class.update(bowler_class_params)
      redirect_to @bowler_class, notice: 'Bowler class was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /bowler_classes/1
  def destroy
    @bowler_class.destroy
    redirect_to bowler_classes_url, notice: 'Bowler class was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bowler_class
      @bowler_class = BowlerClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowler_class_params
      params[:bowler_class].permit(:name)
    end
end
