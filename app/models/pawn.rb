class Pawn < Piece

  def valid_move?(new_x, new_y)
    position_exist?(new_x, new_y) && passes_pawn_rules?(new_x, new_y)
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

  #Checks that pawn is on the originating square aka first_move_position depending on its color
  def first_move_position?
    return true if (y_cord == 1 && color == 'white') || (y_cord == 6 && color == 'black')
    
    return false
  end

  #We need to add a flag to a piece if it's moved
  #That way it is not dependent on y_cord position
  #So we added column to pieces database so if the pawn moves, then we change the :moved value to "yes"
  #Question is how do we change the :moved value to "yes"?
  # => easy: self.update_attributes(:moved, "yes")
  #ok we know how to update :moved to "yes", how do we know when to update the :moved value to "yes"?
  #we want to update it when the Pawn has moved from its starting position
  #how do we identify the starting position so that it's independent of color?
  #starting position is either y_cord == 1 or y_cord == 6...
  #what if we said when y_cord != 1 || y_cord != 6 then say that the pawn has moved
  #problem with this assertion is that what happens when the white pawn reaches y_cord == 6?
  #it would automatically be allowed to move 2 steps forward
  #however, this wouldn't matter because of the position_exist? method
  #ok it looks like this will be what we're working with
  #so if the pawn is not on y_cord == 6 or y_cord == 1 then mark the pawn as moved
  def not_moved?
    moved != "yes"
  end

  #Checks whether or not position pawn is moving to is backwards
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

  def image
    if color == "white"
      "\u2659"
    else
      "\u265F"
    end
  end

end
