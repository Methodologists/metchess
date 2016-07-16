class Rook < Piece

# valid move for rook
  def valid_move?(new_x, new_y)
    allowed_move?(new_x, new_y) && passes_rook_rules?(new_x, new_y)
  end

  def passes_rook_rules?(x, y)
    x_cord == x || y_cord == y
  end

# image for rook
  def image
    if color == "white"
      "\u2656"
    else
      "\u265C"
    end
  end


end
