class UsersController < ApplicationController
  def show
    @games = Game.all
  end 
end
