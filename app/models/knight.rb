class Knight < Piece

# valid move for knight
  def valid_move?(new_x, new_y)
    allowed_move?(new_x, new_y) && passes_knight_rules?(new_x, new_y)
  end

  def passes_knight_rules?(new_x, new_y)
    allowed_deltas = [1, 2]
    coerced_delta_x = allowed_deltas.delete((x_cord - new_x).abs)
    coerced_delta_y = allowed_deltas.delete((y_cord - new_y).abs)
    !!(coerced_delta_x && coerced_delta_y)
  end

# image for knight
  def image
    if color == "white"
      "\u2658"
    else
      "\u265E"
    end
  end  

end
