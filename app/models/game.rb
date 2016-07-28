class Game < ActiveRecord::Base
  belongs_to :white_player, class_name: "User", foreign_key: "player_white_id"
  belongs_to :black_player, class_name: "User", foreign_key: "player_black_id"
  has_many :pieces
  
  after_create :initialize_board!
  after_create :set_first_turn!
  
  
  def initialize_board!
    make_pawns!
    make_rooks!
    make_bishops!
    make_knights!
    make_kings!
    make_queens!
  end

  def make_pawns!
    8.times do |n|
        Pawn.create(
            game_id: id, 
            color: 'white', 
            x_cord: n,
            y_cord: 1
            )
    end
    #
    8.times do |n|
        Pawn.create(
            game_id: id, 
            color: 'black', 
            x_cord: n,
            y_cord: 6
            )
    end
  end

  def make_rooks!
    Rook.create(game_id: id, color: 'white', x_cord: 0, y_cord: 0)
    Rook.create(game_id: id, color: 'white', x_cord: 7, y_cord: 0)
    Rook.create(game_id: id, color: 'black', x_cord: 0, y_cord: 7)
    Rook.create(game_id: id, color: 'black', x_cord: 7, y_cord: 7)
  end

  def make_knights!
    Knight.create(game_id: id, color: 'white', x_cord: 1, y_cord: 0)
    Knight.create(game_id: id, color: 'white', x_cord: 6, y_cord: 0)
    Knight.create(game_id: id, color: 'black', x_cord: 6, y_cord: 7)
    Knight.create(game_id: id, color: 'black', x_cord: 1, y_cord: 7)
  end

  def make_bishops!
    Bishop.create(game_id: id, color: 'white', x_cord: 2, y_cord: 0)
    Bishop.create(game_id: id, color: 'white', x_cord: 5, y_cord: 0)
    Bishop.create(game_id: id, color: 'black', x_cord: 5, y_cord: 7)
    Bishop.create(game_id: id, color: 'black', x_cord: 2, y_cord: 7)
  end

  def make_kings!
    King.create(game_id: id, color: 'white', x_cord: 4, y_cord: 0)
    King.create(game_id: id, color: 'black', x_cord: 4, y_cord: 7)
  end

  def make_queens!
    Queen.create(game_id: id, color: 'white', x_cord: 3, y_cord: 0)
    Queen.create(game_id: id, color: 'black', x_cord: 3, y_cord: 7)
  end

  #game states
  def pending_opponent?
    player_black_id.blank?
  end

  def ready_to_play?
    player_white_id.present? && player_black_id.present?
  end

  #turn states
  def set_first_turn!
    update_attributes(current_turn: "white")
  end

  def next_turn!
    if self.current_turn == "white"
      self.update_attributes(current_turn: "black")
    elsif self.current_turn == "black"
      self.update_attributes(current_turn: "white")
    end
  end

#end game check and checkmate
  def check?
    kings = King.where(game_id: id)
    kings.each do |king|
      pieces.each do |piece|
        return true if piece.color != king.color && piece.valid_move?(king.x_cord, king.y_cord)
      end
    end
    false
  end

  def checkmate?
    return false if move_out_of_check? || obstruct_out_of_check? #|| method3?
    return true if check?
  end

  def move_out_of_check?
    king_allowed_moves = 
    [ [check_x, check_y + 1],
      [check_x, check_y - 1],
      [check_x + 1, check_y + 1],
      [check_x + 1, check_y],
      [check_x + 1, check_y - 1],
      [check_x - 1, check_y + 1],
      [check_x - 1, check_y],
      [check_x - 1, check_y - 1]
      ]
    king_allowed_moves.each do |coord|
      return true if king_in_check.valid_move?(coord.first, coord.last)
    end
    false
  end

  def obstruct_out_of_check? #checks if there's any piece that can obstruct the path of the piece putting in check
    obstructable_positions = []
    if king_in_check.y_cord == check_piece.y_cord && king_in_check.x_cord > check_piece.x_cord
      (check_piece.x_cord).upto(king_in_check.x_cord) do |x|
        obstructable_positions << [x, king_in_check.y_cord]
      end
    elsif king_in_check.y_cord == check_piece.y_cord && king_in_check.x_cord < check_piece.x_cord
      (king_in_check.x_cord).upto(check_piece.x_cord) do |x|
        obstructable_positions << [x, king_in_check.y_cord]
      end
    elsif king_in_check.x_cord == check_piece.x_cord && king_in_check.y_cord > check_piece.y_cord
      (check_piece.y_cord).upto(king_in_check.y_cord) do |y|
        obstructable_positions << [king_in_check.x_cord, y]
      end
    elsif king_in_check.x_cord == check_piece.x_cord && king_in_check.y_cord < check_piece.y_cord
      (king_in_check.y_cord).upto(check_piece.y_cord) do |y|
        obstructable_positions << [king_in_check.x_cord, y]
      end
    elsif (king_in_check.x_cord - check_piece.x_cord) == (king_in_check.y_cord - check_piece.x_cord)

    end
    #this is going to be very similar to the is_obstructed logic
    #we are going to find every situation where the king can be in check
    #this method will only apply horizontally and diagonally
    #we will loop through each of our pieces and see if any of them can make a valid move into the path of
    #the check_piece
    #so let's break this down into micro steps...
    #first we need to find the check piece (check_pieces)
    #then we need to find the positions that make up the path from the check_piece to the king in check
    #we need to do this for every possible scenario
    # => horizontal to the right, horizontal to the left
    # => vertically upwards, vertically downwards
    # => diagonally upper right, diagonally lower right, diagonally upper left, diagonally lower left
    #whenever an obstructable position fits the description, we put it into an array obstructable_positions
    #then we need to loop through each of our pieces and see which ones are allowed to move to these positions
    #if any of our pieces fits this description then return true for method
    #if after looping through everything, there is no piece that can obstruct the path, return false
    #block_pieces << Pieces.where(game_id: id, color: current_turn).where.not(x_cord: nil, y_cord: nil)

  end

  # def method3? #checks if there's a piece that can capture the piece that's putting the king in check
  #   pieces.each do |piece|
  #     return true if piece.valid_move?(check_piece.x_cord, check_piece.y_cord)
  #   end

  #   return false
  # end

  def check_piece
    check_piece = []
    Piece.where(game_id: id).where.not(color: current_turn).each do |piece|
      check_piece << piece.valid_move?(check_x, check_y)
    end
    check_piece
  end

  def king_in_check
    king = King.find_by(game_id: id, color: current_turn)
    king
  end

  def check_x
    x = king_in_check.x_cord
    x
  end

  def check_y
    y = king_in_check.y_cord
    y
  end
end
