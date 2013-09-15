class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_tournament, :assign_tournament, :unassign_tournament]
  before_action :user_is_master?

  def unassign_tournament
    tournament = Tournament.find(params[:tournament_id])
    @user.tournaments.delete(tournament)
    redirect_to @user
  end

  def assign_tournament
    @user.tournaments << Tournament.find(params[:tournament][:id])
    redirect_to users_url
  end

  def add_tournament
    @tournaments = Tournament.all - @user.tournaments
  end

  def index
    puts "current user #{current_user}"
    @users = User.all
  end

  def new
    @user = User.new
  end

  # GET /bowlers/1/edit
  def edit

  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  # PATCH/PUT /bowlers/1
  # PATCH/PUT /bowlers/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'Bowler was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bowlers/1
  # DELETE /bowlers/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end

end
