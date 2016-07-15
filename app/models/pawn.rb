class Pawn < Piece

  def valid_move?(new_x, new_y)
    update_moved_status!
    start_position_exist?(new_x, new_y) && position_exist?(new_x, new_y) && passes_pawn_rules?(new_x, new_y)
  end

  def passes_pawn_rules?(x, y)
    return true if two_squares_forward?(x, y)
    return true if one_square_forward?(x, y)
    return true if diagonal_move?(x, y)

    return false
  end

  #Checks if position is 2 squares in front of Pawn
  def two_squares_forward?(x, y)
    not_moved? && not_backwards?(x, y) && (y_cord - y).abs == 2 && x_cord - x == 0
  end

  #Checks if position is 1 square in front of Pawn
  def one_square_forward?(x, y)
    not_backwards?(x, y) && (y_cord - y).abs == 1 && x_cord - x == 0
  end

  #Checks if position is diagonally in front of Pawn
  def diagonal_move?(x, y)
    diagonal_allowed?(x, y) && not_backwards?(x, y) && (y_cord - y).abs == 1 && (x_cord - x).abs == 1
  end

  #Checks that Pawn is on the originating square aka first_move_position depending on its color
  def first_move_position?
    return true if (y_cord == 1 && color == 'white') || (y_cord == 6 && color == 'black')
    
    return false
  end

  #Checks if Pawn has moved from its start position
  def not_moved?
    moved == false
  end

  #Checks whether or not position Pawn is moving to is backwards
  def not_backwards?(x, y)
    return true if (color == 'white' && y > y_cord) || (color == 'black' && y < y_cord)

    return false
  end

  #Checks if diagonal move is allowed based on position it's moving to
  def diagonal_allowed?(x, y)
    if square_occupied?(x, y)
      target_piece = Piece.find_by(x_cord: x, y_cord: y)
      return true if color != target_piece.color
    end

    return false
  end

  def square_occupied?(x, y)
    Piece.where(x_cord: x, y_cord: y).present?
  end

  #Updates the moved status of the Pawn
  def update_moved_status!
    if y_cord == 1 || y_cord == 6
      self.update(:moved => false)
    else
      self.update(:moved => true)
    end
  end

  def image
    if color == "white"
      "\u2659"
    else
      "\u265F"
    end
  end

end
