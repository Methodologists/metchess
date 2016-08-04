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
    not_check?(new_x, new_y) && !game.check? && caslte_positioning? && not_moved_from_start_position?
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

  def not_moved_from_start_position?
    update_castle_moved_time!
    update_castle_moved_status!
    return true if castle_moved == false
    return false if caslte_moved == true
    #at the creation of the game, we need to update the castle_moved status to false
  end

  def update_castle_moved_time!
    if !((x_cord == 4 && y_cord == 0) && () || (x_cord == 4 && y_cord == 7))
      self.update(castle_moved_time: updated_at)
    end
  end

  def update_castle_moved_status!
    if castle_moved_time == nil
      self.update(castle_moved: false)
    elsif castle_moved_time
      self.update(castle_moved: true)
    end
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
