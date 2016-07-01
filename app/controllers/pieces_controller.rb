class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    @game = Game.find(params[:game_id])
    @piece = Piece.find(params[:id])
    @piece.move_piece(piece_params[:x_cord], piece_params[:y_cord])
    redirect_to game_path(@game)
  end


  private

  def piece_params
    params.require(:piece).permit(:x_cord, :y_cord)
  end


end
