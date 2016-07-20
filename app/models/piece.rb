class Piece < ActiveRecord::Base
  belongs_to :game

	def is_obstructed?(new_x, new_y)
    obstructed_horizontally?(new_x, new_y) # || obstructed_vertically?(new_x, new_y) || obstructed_diagonally?(new_x, new_y)
  end
  
  def obstructed_horizontally?(new_x, new_y)

    if allowed_move?(new_x, new_y) && y_cord == new_y
      # move left
      if x_cord > new_x
        (x_cord - 1).downto(new_x + 1) {|delta_x| occupied?(delta_x, y_cord)}
      elsif x_cord < new_x
        (x_cord + 1).downto(new_x - 1) {|delta_x| occupied?(delta_x, y_cord)}
      end
    else
      return false
    end

  end

  def occupied?(new_x, new_y)
    Piece.where(x_cord: new_x, y_cord: new_y, game_id: id).present?
  end

# Moving piece to new location & Captures piece if valid
  def move_to!(new_x, new_y)
      piece_to_capture = Piece.find_by(x_cord: new_x, y_cord: new_y, game_id: game_id)

      return if piece_to_capture && own_piece?(piece_to_capture)

      # if the rest of this method is executed, either
      #   * piece_to_capture is nil
      #   * piece_to_capture is opposite color

      piece_to_capture.update(x_cord: nil, y_cord: nil) if piece_to_capture
      update(x_cord: new_x, y_cord: new_y)
      game.next_turn!
  end

  def own_piece?(piece)
    piece.color == color
  end

# Valid move parameters 
#   * if coordinates are on board
#   * if moving to same position
  def allowed_move?(new_x, new_y)
    piece_on_board? &&
      position_exist?(new_x, new_y) &&
        not_original_position?(new_x, new_y)
  end

  def position_exist?(new_x, new_y)
    new_x != nil && new_y != nil &&
      new_x >= 0 && new_x <= 7 && new_y >= 0 && new_y <= 7
  end

  def not_original_position?(new_x, new_y)
    !(x_cord == new_x && y_cord == new_y)
  end

  def piece_on_board?
    !(x_cord == nil && y_cord == nil)
  end

  def my_turn?
    self.color == game.current_turn
  end

end


