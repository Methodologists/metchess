class King < Piece

# valid move for king
  def valid_move?(new_x, new_y)
    allowed_move?(new_x, new_y) && passes_king_rules?(new_x, new_y) && not_check?(new_x, new_y)
  end

  def passes_king_rules?(new_x, new_y)
    (x_cord - new_x).abs <= 1 && (y_cord - new_y).abs <= 1
  end

  def not_check?(new_x, new_y)
    pieces = Piece.where(game_id: game_id)
    pieces.each do |piece|
      return false if piece.color != color && piece.valid_move?(new_x, new_y)
    end

    return true
  end

  def move_to!(new_x, new_y)
    #update coordinates of the king to new_x and new_y if castle conditions are met
    #otherwise just super and go on to the move_to! method in the piece

    super
  end

  def can_castle?(new_x, new_y)
    not_check?(new_x, new_y) && !game.check? && caslte_positioning? && moved_from_start_position?
  end

  def castle_positioning?
    if color == 'black'
      return true if Piece.find_by(game_id: game_id, x_cord: 5, y_cord: 7) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 6, y_cord: 7) == nil
      return true if Piece.find_by(game_id: game_id, x_cord: 3, y_cord: 7) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 2, y_cord: 7) == nil && 
        Piece.find_by(game_id: game_id, x_cord: 1, y_cord: 7) == nil
    elsif color == 'white'
      return true if Piece.find_by(game_id: game_id, x_cord: 5, y_cord: 0) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 6, y_cord: 0) == nil
      return true if Piece.find_by(game_id: game_id, x_cord: 3, y_cord: 0) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 2, y_cord: 0) == nil && 
        Piece.find_by(game_id: game_id, x_cord: 1, y_cord: 0) == nil
    end
    false
  end

  def moved_from_start_position?
    #we can add a column to the piece model called castle_moved with a boolean designation of true/false
    #but what stops a person from moving the king and then moving it back to its start position?
    # => under normal chess rules, this would not be allowed but in our game it would happen any way...
    #maybe we can use the timestamps?
    #there are 2 timestamp columns in the game model
    # => created_at and updated_at
    #just for example, what if created_at => 0 and we happen to move the king for one of our first moves?
    #we'll say that if the king is not at x_cord: 4 and y_cord: 0 then change castle_moved to true
    #we could also make a castle_moved_time as well, maybe that will fix things...
    #so when king is moved, change castle_moved_time to updated_at time
    #then we'll make an update_castle_status! method
    # => if updated_at > castle_moved_time then do nothing and stop method
    # => however, if this is not the case, then change the status to false
  end

# image for king
  def image
    if color == "white"
      "\u2654"
    else
      "\u265A"
    end
  end

end
