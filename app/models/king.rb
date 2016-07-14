class King < Piece

# valid move for king
  def valid_move?(new_x, new_y)
    allowed_move?(new_x, new_y) && passes_king_rules?(new_x, new_y)
  end

  def passes_king_rules?(new_x, new_y)
    (x_cord - new_x).abs <= 1 && (y_cord - new_y).abs <= 1
  end

# image for king
  def image
    if color == "white"
      "\u2654"
    else
      "\u265A"
    end
  end

end
