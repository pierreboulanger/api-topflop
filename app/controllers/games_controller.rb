class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    final_top
    final_flop
    has_voted
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = @team.games.build(game_params)
    #does the same thing as :
    # @game = Game.new
    # @game.cocktail = @cocktail
    # @game.save

    respond_to do |format|
      if @game.save
        format.html { redirect_to @team, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update

    # OPEN VOTE
    if params[:open] != nil
      if @game.update(open: params[:open])
        flash[:notice] = "Les votes sont lancés !"
        redirect_to team_game_path(@team, @game)
      else
        flash[:notice] = "Oops il y a un Bug !"
        render :show
      end
    end

    # UPDATE TOP
    if params[:top] != nil && params[:flop] != nil
      top_name = @players.find(params[:top]).name
      flop_name = @players.find(params[:flop]).name

      if @game.update(top: top_name)
        if @game.update(flop: flop_name)
          redirect_to team_game_path(@team, @game)
        else
          flash[:notice] = "Oops il y a un Bug avec le Flop !"
          render :show
        end
      else
        flash[:notice] = "Oops il y a un Bug avec le Top !"
        render :show
      end
    end


    # respond_to do |format|
    #   if @game.update(game_params)
    #     format.html { redirect_to @game, notice: 'Game was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @game }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @game.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  def find_team
    @team = Team.find(params[:team_id])
  end

  def set_game
    find_team
    @game = @team.games.find(params[:id])
  end

  def set_tops
    @tops = @game.tops
  end

  def set_flops
    @flops = @game.flops
  end

  def set_comments
    @comments = []

    set_tops
    set_flops

    @players.each do |player|
      player_id = player.id

      player_flop = @flops.find_by user_id: player_id
      player_top = @tops.find_by user_id: player_id

      @comments << [player_top, player_flop]
    end

    @comments
  end

  def set_players
    find_team
    @players = @team.users
  end

  def game_params
    params.require(:game).permit(:opponent_name, :date, :open)
  end

  # FINAL COUNT TOP and FLOP METHOD

  def final_top
    top_list = []

    # Get all the user selected for top
    @tops.each do |top|
      top_list << @players.find(top.topplayer)
    end

    # Sort the list with count
    @count_tops = top_list.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }

    # Reverse in order to have most voted first
    @count_tops = @count_tops.sort_by {|k,v| v}.reverse
  end

  def final_flop
    flop_list = []

    @flops.each do |flop|
      flop_list << @players.find(flop.flopplayer)
    end
    # Sort the list with count
    @count_flops = flop_list.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }

    # Reverse in order to have most voted first
    @count_flops = @count_flops.sort_by {|k,v| v}.reverse
  end

  # USER HAS VOTED ??

  def has_voted
    @voted = false

    current_user.tops.each do |top|
      if top.game_id == @game.id
        @voted = true
        break
      else
        @voted = false
      end
    end
  end

end
