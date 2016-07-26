class PiecesController < ApplicationController
before_action :authenticate_user!, only: [:update]

  def show
    @game = Game.find(params[:game_id])
    @piece = Piece.find(params[:id])
    @pieces = @game.pieces
  end

  def update
    @game = Game.find(params[:game_id])
    @piece = Piece.find(params[:id])

    if @piece.my_turn? == false || my_piece? == false
      flash[:alert] = "It's not your turn, you barnacle!"
    elsif @piece.is_obstructed?(piece_params[:new_x].to_i, piece_params[:new_y].to_i) || 
        !@piece.valid_move?(piece_params[:new_x].to_i, piece_params[:new_y].to_i)
      flash[:alert] = "Sorry, can't move there"
    else
      @piece.move_to!(piece_params[:new_x], piece_params[:new_y])
    end
      redirect_to game_path(@game)
  end

  def my_piece?
    (@game.current_turn == "white" && current_user == @game.white_player) ||
        (@game.current_turn == "black" && current_user == @game.black_player)
  end

  private


  def piece_params
    params.require(:piece).permit(:x_cord, :y_cord, :new_x, :new_y)
  end

  
end
