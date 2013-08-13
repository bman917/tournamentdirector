class BowlingAssociationsController < ApplicationController
  include SessionsHelper

  before_action :set_bowling_association, only: [:show, :edit, :update, :destroy]

  # GET /bowling_associations
  # GET /bowling_associations.json
  def index
    @bowling_associations = BowlingAssociation.all
    clear_selected_tournament
  end

  def show_entries
    @bowling_association = BowlingAssociation.find(params[:bowling_association_id])
    @bowlers = selected_tournament.bowlers(@bowling_association)
  end

  # GET /bowling_associations/1
  # GET /bowling_associations/1.json
  def show
  end

  # GET /bowling_associations/new
  def new
    @bowling_association = BowlingAssociation.new
  end

  # GET /bowling_associations/1/edit
  def edit
  end

  # POST /bowling_associations
  # POST /bowling_associations.json
  def create
    @bowling_association = BowlingAssociation.new(bowling_association_params)

    respond_to do |format|
      if @bowling_association.save
        format.html { redirect_to @bowling_association, notice: 'Bowling association was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bowling_association }
      else
        format.html { render action: 'new' }
        format.json { render json: @bowling_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bowling_associations/1
  # PATCH/PUT /bowling_associations/1.json
  def update
    respond_to do |format|
      if @bowling_association.update(bowling_association_params)
        format.html { redirect_to @bowling_association, notice: 'Bowling association was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bowling_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bowling_associations/1
  # DELETE /bowling_associations/1.json
  def destroy
    @bowling_association.destroy
    respond_to do |format|
      format.html { redirect_to bowling_associations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bowling_association
      @bowling_association = BowlingAssociation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bowling_association_params
      params.require(:bowling_association).permit(:name)
    end
end
