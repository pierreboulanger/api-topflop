class UsersController < ApplicationController
  before_action :set_user, :set_team, :find_teams

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to team_path(@team)
    else
      flash[:notice] = "Oops something went wrong."
      render :show
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_team
    if current_user.team_id != nil
      @team = Team.find(current_user.team_id)
    else
      @team = Team.find(1)
    end
  end

  def find_teams
    @teams = Team.all
  end

  def user_params
    params.require(:user).permit(:name, :shirt_number, :field_position, :team_id)
  end
end
