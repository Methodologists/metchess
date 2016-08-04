class King < Piece

# valid move for king
  def valid_move?(new_x, new_y)
    allowed_move?(new_x, new_y) && passes_king_rules?(new_x, new_y) && not_check?(new_x, new_y)
  end

  def passes_king_rules?(new_x, new_y)
    (x_cord - new_x).abs <= 1 && (y_cord - new_y).abs <= 1
  end

  def not_check?(new_x, new_y)
    pieces = Piece.where(game_id: game_id).where.not(color: color)
    pieces.each do |piece|
      return false if piece.valid_move?(new_x, new_y)
    end
    true
  end

  def move_to!(new_x, new_y)
    if can_castle?(new_x, new_y)
      self.update(x_cord: new_x, y_cord: new_y)
      r1 = Rook.find_by(color: color, game_id: game_id, x_cord: 7).update(x_cord: 5) if new_x > 4
      r2 = Rook.find_by(color: color, game_id: game_id, x_cord: 0).update(x_cord: 3) if new_x < 4
    end
    puts "king: #{x_cord}, #{y_cord}"

    super
  end

  def can_castle?(new_x, new_y)
    castle_positioning? && not_check?(new_x, new_y) && !game.check? && not_moved_from_start_position?
  end

  def castle_positioning?
    if color == 'black'
      return true if Piece.find_by(game_id: game_id, x_cord: 3, y_cord: 7) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 2, y_cord: 7) == nil && 
        Piece.find_by(game_id: game_id, x_cord: 1, y_cord: 7) == nil
      return true if Piece.find_by(game_id: game_id, x_cord: 5, y_cord: 7) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 6, y_cord: 7) == nil
    elsif color == 'white'
      return true if Piece.find_by(game_id: game_id, x_cord: 3, y_cord: 0) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 2, y_cord: 0) == nil && 
        Piece.find_by(game_id: game_id, x_cord: 1, y_cord: 0) == nil
      return true if Piece.find_by(game_id: game_id, x_cord: 5, y_cord: 0) == nil &&
       Piece.find_by(game_id: game_id, x_cord: 6, y_cord: 0) == nil
    end
    false
  end

  #we need to check that the rook has also not moved as well...
  def not_moved_from_start_position?
    update_castle_moved_time!
    update_castle_moved_status!
    return true if castle_moved == false
    return false if castle_moved == true
  end

  def update_castle_moved_time!
    if !((x_cord == 4 && y_cord == 0) || (x_cord == 4 && y_cord == 7))
      self.update(castle_moved_time: updated_at)
    end
  end

  def update_castle_moved_status!
    if !castle_moved_time.nil?
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
