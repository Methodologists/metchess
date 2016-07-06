class Rook < Piece

  def valid_move?(new_x, new_y)
    position_exist?(new_x, new_y) && passes_rook_rules?(new_x, new_y)
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
