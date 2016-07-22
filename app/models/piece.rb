class Piece < ActiveRecord::Base
  belongs_to :game

	def is_obstructed?(new_x, new_y)
    if allowed_move?(new_x, new_y)
      #horizontal
      if x_cord != new_x && y_cord == new_y
        #moving right
        if x_cord - new_x > 0
          occupied = []
          occupied << (x_cord + 1).upto(new_x - 1) do |delta_x|
            Piece.where(x_cord: delta_x, y_cord: y_cord).present?
          end
          return true if occupied.include?(true)
        #moving left
        elsif x_cord - new_x < 0
          delta_x = []
         (x_cord..new_x).each do |x|
            delta_x << x
          end
          delta_x.pop
          delta_x.shift
puts "------ HELLO #{delta_x}"

          occupied = []
          puts "OCCUPIED #{occupied}"
          occupied = delta_x.each do |delta_x|
            Piece.where(x_cord: delta_x, y_cord: y_cord).present?
          end
          puts "OCCUPIED?????? #{occupied}"
          return true if occupied.include?(true)
        end
      end
    end
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


