class King < Piece

  def valid_move?
    game_loc
    #find king's original location
    #find king's new location
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

  def position_exist?
    #if/else statement that checks if position exists
      #if x_cord && y_cord == negative value return false
      #if x_cord > 7 && y_cord > 7 return false
      #else return true
  end

  def orig_position
    #finds the king's original location

  end

  def new_position

  end

  def game_loc
    return @game
  end
end
