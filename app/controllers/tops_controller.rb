class TopsController < ApplicationController
  before_action :set_top, only: [:edit, :update, :destroy]


  def new
    @top = Top.new
  end

  def create
    @top = Top.new(top_params)

    respond_to do |format|
      if @top.save
        format.html { redirect_to team_game_path, notice: 'Top was successfully created.' }
        format.json { render :show, status: :created, location: @top }
      else
        format.html { render :new }
        format.json { render json: @top.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @top.update(top_params)
        format.html { redirect_to @top, notice: 'Top was successfully updated.' }
        format.json { render :show, status: :ok, location: @top }
      else
        format.html { render :edit }
        format.json { render json: @top.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tops/1
  # DELETE /tops/1.json
  def destroy
    @top.destroy
    respond_to do |format|
      format.html { redirect_to tops_url, notice: 'Top was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  def set_team
    @team = Team.find(current_user.team_id)
  end

  def set_game
    @game = Game.find(params["game_id"])
  end

  def set_flop
    @flop = Flop.new
  end

  def top_params
    params.require(:top).permit(:game_id, :user_id, :topplayer, :comment)
  end

  # USER HAS VOTED ???

  def has_voted_top_player
    @voted_top_player = false

    current_user.tops.each do |top|
      if top.game_id == @game.id
        @voted_top_player = true
        break
      else
        @voted_top_player = false
      end
    end
  end

  def has_voted_flop_player
    @voted_flop_player = false

    current_user.flops.each do |flop|
      if flop.game_id == @game.id
        @voted_flop_player = true
        break
      else
        @voted_flop_player = false
      end
    end
  end


  # FOR EDIT AND UPDATE !!!

  def set_top_and_flop
    @top = current_user.tops.last
    @flop = current_user.flops.last
  end
end
