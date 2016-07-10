class Knight < Piece

  def image
    if color == "white"
      "\u2658"
    else
      "\u265E"
    end
  end

  def valid_move?(new_x, new_y)
    on_board?(new_x, new_y) && allowed_deltas?(new_x, new_y)
  end

  private

  def on_board?(new_x, new_y)
    new_x >= 0 && new_x <= 7 &&
      new_y >= 0 && new_y <= 7
  end

  def allowed_deltas?(new_x, new_y)
    allowed_deltas = [1, 2]
    coerced_delta_x = allowed_deltas.delete((x_cord - new_x).abs)
    coerced_delta_y = allowed_deltas.delete((y_cord - new_y).abs)
    !!(coerced_delta_x && coerced_delta_y)
  end

end
