class King < Piece

  def valid_move?(new_x, new_y)
    #checks if the move that the king is making is valid
    if position_exist?(new_x, new_y) && pass_king_rules?(new_x, new_y)
      return true
    else
      return false
    end
  end

  def position_exist?(new_x, new_y)
    #checks if position that king is moving to exists
    if new_x < 0 || new_x > 7 || new_y < 0 || new_y > 7
      return false
    else
      return true
    end
  end

  def allowed_positions
    #returns positions of the allowed moves that king is allowed to make
    right_one = [x_cord + 1, y_cord]
    left_one = [x_cord - 1, y_cord]
    up_one = [x_cord, y_cord + 1]
    down_one = [x_cord, y_cord - 1]
    upper_right = [x_cord + 1, y_cord + 1]
    upper_left = [x_cord - 1, y_cord + 1]
    lower_right = [x_cord + 1, y_cord - 1]
    lower_left = [x_cord - 1, y_cord - 1]
    valid_moves = [right_one, left_one, up_one, down_one, upper_right, upper_left, lower_right, lower_left]
    return valid_moves
  end

  def pass_king_rules?(new_x, new_y)
    #checks if position king is moving to is an allowed position
    allowed_positions.each do |position|
      if [new_x, new_y] == position
        return true
      end
    end

    return false
  end

  def image
    if color == "white"
      "\u2654"
    else
      "\u265A"
    end
  end

end
