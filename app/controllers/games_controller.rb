class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @piece = Piece.find(params[:id])
    @pieces = @game.pieces
  end


  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id)
  end

  def piece_params
    params.require(:piece).permit(:x_cord, :y_cord)
  end

  
end
