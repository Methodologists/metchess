class PiecesController < ApplicationController

  def show
    @game = Game.find(params[:game_id])
    @piece = Piece.find(params[:id])
    @pieces = @game.pieces
  end

  def update
    @game = Game.find(params[:game_id])
    @piece = Piece.find(params[:id])
    #add check here for my_turn?
    @piece.move_to!(piece_params[:new_x], piece_params[:new_y])
    redirect_to game_path(@game)
  end


  private


  def piece_params
    params.require(:piece).permit(:x_cord, :y_cord, :new_x, :new_y)
  end

  
end
