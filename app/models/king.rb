class King < Piece

  def valid_move?(new_x, new_y)
    #checks if the move that the king is making is valid
    start_position_exist?(x_cord, y_cord) && position_exist?(new_x, new_y) && pass_king_rules?(new_x, new_y)
  end

  def pass_king_rules?(new_x, new_y)
    #checks if position king is moving to is an allowed position
    (self.x_cord - new_x).abs <= 1 && (self.y_cord - new_y).abs <= 1
  end

  def image
    if color == "white"
      "\u2654"
    else
      "\u265A"
    end
  end

end
