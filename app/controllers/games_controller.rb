class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update]

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

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.includes(:pieces).find(params[:id])
    @piece = Piece.find(params[:id])
  end


  private

  def game_params
    params.require(:game).permit(:name, :player_white_id, :player_black_id)
  end

end
