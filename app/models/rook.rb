class Rook < Piece

  def valid_move?(new_x, new_y)
    start_position_exist?(x_cord, y_cord) && final_position_exist?(new_x, new_y) && passes_rook_rules?(new_x, new_y)
  end

  def passes_rook_rules?(x, y)
    if (x_cord == x && y_cord == y)
      return false
    else
      (x_cord == x || y_cord == y)
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
