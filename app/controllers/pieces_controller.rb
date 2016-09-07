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
      error = "It's not your turn, you barnacle!"
    elsif @piece.is_obstructed?(piece_params[:new_x].to_i, piece_params[:new_y].to_i)
      error = "Something's in the way."
    elsif !@piece.valid_move?(piece_params[:new_x].to_i, piece_params[:new_y].to_i)
      error = "Sorry, can't move there"
    else
      @piece.move_to!(piece_params[:new_x], piece_params[:new_y])
    end
    respond_to do |format|
      format.html {
        flash[:alert] = error
        redirect_to game_path(@game)
      }
      format.js {
        if error
          render json: {error: error}, status: :unprocessable_entity
        else
          render json: {response: 'huzzah!'}, status: :ok
        end
      }
    end
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
