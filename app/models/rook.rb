class Rook < Piece

  def valid_move?(new_x, new_y)
    position_exist?(new_x, new_y) && passes_rook_rules?(new_x, new_y)
  end

  def position_exist?(x, y)
    x >= 0 && x <= 7 && y >= 0 && y <= 7
  end

  def passes_rook_rules?(x, y)
    if self.x_cord == x || self.y_cord == y
      return true
    else
      return false
    end
  end

  def image
    if color == "white"
      "\u2656"
    else
      "\u265C"
    end
  end


end
