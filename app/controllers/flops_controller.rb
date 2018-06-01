class FlopsController < ApplicationController
  before_action :set_team, :set_game
  before_action :set_flop, only: [:edit, :update]

  # GET /flops/new
  def new
    @flop = Flop.new
  end

  # GET /flops/1/edit
  def edit
  end

  # POST /flops
  # POST /flops.json
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

  # PATCH/PUT /flops/1
  # PATCH/PUT /flops/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_flop
      @flop = Flop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flop_params
      params.require(:flop).permit(:game_id, :user_id, :comment, :flopplayer)
    end
end
