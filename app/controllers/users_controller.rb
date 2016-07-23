class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @games = Game.all
  end
  
end
