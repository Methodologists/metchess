class Pawn < Piece

  def valid_move?(new_x, new_y)
    on_board?(new_x, new_y) && passes_pawn_rules?(new_x, new_y)
  end

  def passes_pawn_rules?(x, y)
    if two_squares_forward?(x, y)
      return true
    elsif one_square_forward?(x, y)
      return true
    elsif diagonal_move?(x, y)
      return true
    end

    return false
  end

  def two_squares_forward?(x, y)
    first_move_position? && not_backwards?(x, y) && (self.y_cord - y).abs == 2 && self.x_cord - x == 0
  end

  def one_square_forward?(x, y)
    not_backwards?(x, y) && (self.y_cord - y).abs == 1 && self.x_cord - x == 0
  end

  def diagonal_move?(x, y)
    diagonal_allowed?(x, y) && not_backwards?(x, y) && (self.y_cord - y).abs == 1 && (self.x_cord - x).abs == 1
  end

  #Checks that square is on board
  def on_board?(x, y)
    x >= 0 && x <= 7 && y >=0 && y <= 7
  end

  #Checks that pawn is on the originating square aka first_move_position depending on its color
  def first_move_position?
    if self.y_cord == 1 && self.color == 'white'
      return true
    elsif self.y_cord == 6 && self.color == 'black'
      return true
    else
      return false
    end
  end

  #Checks whether or not position pawn is moving to is backwards
  def not_backwards?(x, y)
    if self.color == 'white' && y > self.y_cord
      return true
    elsif self.color == 'black' && y < self.y_cord
      return true
    end

    return false
  end

  #Checks if diagonal move is allowed based on position it's moving to
  def diagonal_allowed?(x, y)
    if square_occupied?(x, y)
      target_piece = Piece.find_by(x_cord: x, y_cord: y)
      if self.color != target_piece.color
        return true
      end
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
