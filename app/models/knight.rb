class Knight < Piece

  def image
    if color == "white"
      "\u2658"
    else
      "\u265E"
    end
  end

  def valid_move?(new_x, new_y)
    start_position_exist?(x_cord, y_cord) && final_position_exist?(new_x, new_y) && allowed_deltas?(new_x, new_y)
  end

  private

  def allowed_deltas?(new_x, new_y)
    allowed_deltas = [1, 2]
    coerced_delta_x = allowed_deltas.delete((x_cord - new_x).abs)
    coerced_delta_y = allowed_deltas.delete((y_cord - new_y).abs)
    !!(coerced_delta_x && coerced_delta_y)
  end

end
