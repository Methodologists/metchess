class GamesController < ApplicationController
  before_action :authenticate_user!
  #before_action :initialize_board!

  def new
    @game = Game.new
  end

  def create
    game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end


  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id)
  end
end
