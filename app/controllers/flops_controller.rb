class FlopsController < ApplicationController
  before_action :set_team, :set_game
  before_action :set_flop, only: [:edit, :update]

  def new
    @flop = Flop.new
  end

  def create
    @flop = Flop.new(flop_params)

    respond_to do |format|
      if @flop.save
        format.html { redirect_to @flop, notice: 'Flop was successfully created.' }
        format.json { render :show, status: :created, location: @flop }
      else
        format.html { render :new }
        format.json { render json: @flop.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @flop.update(flop_params)
        format.html { redirect_to @flop, notice: 'Flop was successfully updated.' }
        format.json { render :show, status: :ok, location: @flop }
      else
        format.html { render :edit }
        format.json { render json: @flop.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    def set_team
      @team = Team.find(current_user.team_id)
    end

    def set_game
      @game = Game.find(params["game_id"])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_flop
      @flop = Flop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flop_params
      params.require(:flop).permit(:game_id, :user_id, :comment, :flopplayer)
    end
end
