class Queen < Piece

# valid move for queen
  def valid_move?(new_x, new_y)
    allowed_move?(new_x, new_y) && passes_queen_rules?(new_x, new_y) && !is_obstructed?(new_x, new_y)
  end

  def passes_queen_rules?(x, y)
    # moves either like a bishop or like a rook
    ((x-x_cord).abs == (y-y_cord).abs) || (x_cord == x || y_cord == y)
  end

# image for queen
  def image
    if color == "white"
      "\u2655"
    else
      "\u265B"
    end
  end

end
