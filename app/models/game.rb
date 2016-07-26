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

    return false
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
    return false
  end

  def obstruct_out_of_check? #checks if there's any piece that can obstruct the path of the piece putting in check
    #own pieces that can get in between check piece 
    #positions are for piece putting king in check
    #check if any own_piece is valid_move? in those in between positions
    #check_pieces.each do |piece|

    #the only check_pieces that can be "interfered" with are the rook, bishop, and the queen. With every other
    #piece, this method won't matter (pawn, knight, king)

    block_pieces << Pieces.where(game_id: id, color: current_turn).where.not(x_cord: nil, y_cord: nil)
    
    #path from king to check_pieces
    check_pieces.each do |pieces|
      pieces.x_cord - check_x
      pieces.y_cord - check_y
    end
    
    if check_piece.is_obstructed?
      return false
    else
      
    end
  end

  # def method3? #checks if there's a piece that can capture the piece that's putting the king in check
  #   pieces.each do |piece|
  #     return true if piece.valid_move?(check_piece.x_cord, check_piece.y_cord)
  #   end

  #   return false
  # end

  def check_pieces
    check_pieces = []
    Piece.where(game_id: id).each do |piece|
      check_pieces << piece.valid_move?(check_x, check_y) if piece.color != current_turn
    end
  end

  def king_in_check
    King.find_by(game_id: id, color: current_turn)
  end

  def check_x
    king_in_check.x_cord
  end

  def check_y
    king_in_check.y_cord
  end

  # def checkmate?
  #   if check? == true
  #     #1. if can't capture piece: if piece putting king in check coords are not valid move for any opposition, return true
  #     #||
  #     #2. if can't block piece: 
  #     #||
  #     #3. if king can't move safely: valid_moves for king still puts king in check 
  #     king_in_check = King.where(game_id: id)
  #     king_in_check.each do |king|
  #       pieces.each do |piece|
  #         if piece.color != king.color && piece.valid_move?(king.x_cord, king.y_cord)
  #           king_in_check = King.where(game_id: id,  x_cord: king.x_cord, y_cord: king.y_cord)
  #         end
  #       end
  #     end
  #   else 
  #     return false
  #   end
  # end
end
