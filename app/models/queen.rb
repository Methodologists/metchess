class Queen < Piece

  def valid_move?(new_x, new_y)
    allowed = not_original_position?(new_x, new_y) && position_exist?(new_x, new_y)
    start_position_exist?(x_cord, y_cord) && allowed && (bishop_movement?(new_x, new_y) || rook_movement?(new_x, new_y))
  end

  def not_original_position?(x, y)
    !(x_cord == x && y_cord == y)
  end

  def bishop_movement?(x,y)
    (x-x_cord).abs == (y-y_cord).abs
  end

  def rook_movement?(x, y)
    x_cord == x || y_cord == y
  end

  def image
    if color == "white"
      "\u2655"
    else
      "\u265B"
    end
  end

end
