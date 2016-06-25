class King < Piece

  def valid_move?
    game_loc
    current_location
    #if/else statement that checks if piece moves within its movable parameters
      #define the king's parameters for conditional statement of if/else statement (for each of these set to a variable)
        #move up one: y_cord + 1 
        #move down one: y_cord - 1
        #move right one: x_cord + 1
        #move left one: x_cord - 1
        #diagonals:
          #upper right: x_cord + 1, y_cord + 1
          #upper left: x_cord - 1, y_cord + 1
          #lower right: x_cord + 1, y_cord - 1
          #lower left: x_cord - 1, y_cord - 1
        #for each of these use position_exist? to verify the position exists
      #if the new location fits the above criteria, then return true. Else return false
  end

  def position_exist?(position)
    #checks if position exists
    if position[0] < 0 && position[1] < 0 && position[0] > 7 && position[1] > 7
      return false
    else
      return true
    end
  end

  def current_location
    #finds the king's original location
    position = [@current_game.king.x_cord, @current_game.king.y_cord]
    return position
  end

  def game_loc
    #find current game's game_id
    @current_game = @game.game_id
    return @current_game
  end

  def king_positions
    right_one = [current_location[0] + 1, current_location[1]]
    left_one = [current_location[0] - 1, current_location[1]]
    up_one = [current_location[0], current_location[1] + 1]
    down_one = [current_location[0], current_location[1] - 1]
    upper_right = [current_location[0] + 1, current_location[1] + 1]
    upper_left = [current_location[0] - 1, current_location[1] + 1]
    lower_right = [current_location[0] + 1, current_location[1] - 1]
    lower_left = [current_location[0] - 1, current_location[1] - 1]
  end
end
