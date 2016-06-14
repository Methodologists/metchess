class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end
end
