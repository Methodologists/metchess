class King < Piece

  def valid_move?(new_position)
    if position_exist?(new_position) && pass_king_rules?(new_position)
      return true
    else
      return false
    end
  end

  def position_exist?(position)
    #checks if moving position exists
    if position[0] < 0 | position[0] > 7 | position[1] < 0 | position[1] > 7
      return false
    else
      return true
    end
  end

  def current_location
    #finds the king's original location
    position = [game_loc.king.x_cord, game_loc.king.y_cord]
    return position
  end

  def game_loc
    #find current game's game_id
    current_game = @game.game_id
    return current_game
  end

  def allowable_positions
    right_one = [current_location[0] + 1, current_location[1]]
    left_one = [current_location[0] - 1, current_location[1]]
    up_one = [current_location[0], current_location[1] + 1]
    down_one = [current_location[0], current_location[1] - 1]
    upper_right = [current_location[0] + 1, current_location[1] + 1]
    upper_left = [current_location[0] - 1, current_location[1] + 1]
    lower_right = [current_location[0] + 1, current_location[1] - 1]
    lower_left = [current_location[0] - 1, current_location[1] - 1]
    valid_moves = [right_one, left_one, up_one, down_one, upper_right, upper_left, lower_right, lower_left]
    return valid_moves
  end

  def pass_king_rules?(position)
    allowable_positions.each do |x|
      if position == x
        return true
      else
        return false
    end
  end
end
