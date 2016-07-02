class King < Piece

  def valid_move?(new_x, new_y)
    #checks if the move that the king is making is valid
    position_exist?(new_x, new_y) && pass_king_rules?(new_x, new_y)
  end

  def position_exist?(new_x, new_y)
    #checks if position that king is moving to exists
    new_x > 0 && new_x < 7 && new_y > 0 && new_y < 7
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
