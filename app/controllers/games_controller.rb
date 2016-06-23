class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_board!

  def create
    game = Game.create(game_params)
  end

  private

  def game_params
    params.require(:game).permits(:player_white_id, :player_black_id)
  end
end
