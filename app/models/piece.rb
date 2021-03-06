class Piece < ActiveRecord::Base
  belongs_to :game

	def is_obstructed?(new_x, new_y)
    return true if Piece.where(game_id: game_id, color: color, x_cord: new_x, y_cord: new_y).present?
    return false if type == "Knight"
    return true unless allowed_move?(new_x, new_y)
      delta_y = []
      delta_x = []
      deltas = []
      occupied = []

      # - HORIZONTAL: left, right -
      if x_cord != new_x && y_cord == new_y
        if x_cord - new_x > 0
          (new_x..x_cord).each {|x| delta_x << x}
        elsif x_cord - new_x < 0
         (x_cord..new_x).each {|x| delta_x << x}
        end
        pop_and_shift(delta_x)
        delta_x.each {|delta_x| occupied << Piece.where(x_cord: delta_x, y_cord: y_cord).present?}

      # | VERTICAL: down, up |
      elsif x_cord == new_x && y_cord != new_y
        if y_cord - new_y > 0
          (new_y..y_cord).each {|y| delta_y << y}
        elsif y_cord - new_y < 0
          (y_cord..new_y).each {|y| delta_y << y}
        end
        pop_and_shift(delta_y)
        delta_y.each {|delta_y| occupied << Piece.where(x_cord: x_cord, y_cord: delta_y).present?}

      # / DIAGONAL: down, up / movement is happening in lower left to upper right or vice versa
      elsif x_cord - new_x == y_cord - new_y
        if x_cord - new_x > 0
          (new_x..x_cord).each {|x| delta_x << x}
          (new_y..y_cord).each {|y| delta_y << y}
        elsif x_cord - new_x < 0
          (x_cord..new_x).each {|x| delta_x << x}
          (y_cord..new_y).each {|y| delta_y << y}
        end

        pop_and_shift(delta_x)
        pop_and_shift(delta_y)
        delta_x.each_with_index do |x, column|
          delta_y.each_with_index do |y, row|
            deltas << [x, y] if column == row
          end
        end
        deltas.each {|i| occupied << Piece.where(x_cord: i.first, y_cord: i.last).present?}

      # / DIAGONAL: down, up / movement is happening in upper left to lower right or vice versa
      elsif x_cord - new_x == -(y_cord - new_y)
        if x_cord - new_x > 0 #moving left and up
          (new_x..x_cord).each {|x| delta_x << x}
          (new_y.downto(y_cord)).each {|y| delta_y << y}
        elsif x_cord - new_x < 0 #moving right and down
          (x_cord..new_x).each {|x| delta_x << x}
          (y_cord.downto(new_y)).each {|y| delta_y << y}
        end

        pop_and_shift(delta_x)
        pop_and_shift(delta_y)
        delta_x.each_with_index do |x, column|
          delta_y.each_with_index do |y, row|
            deltas << [x, y] if column == row 
          end
        end
        deltas.each {|i| occupied << Piece.where(x_cord: i.first, y_cord: i.last).present?}
      end

      return true if occupied.include?(true)
      false
  end

  def pop_and_shift(array)
    array.shift
    array.pop
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