class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def move_piece(new_x, new_y)
    # Add logic to check for validity
    update_attributes(x_cord: new_x, y_cord: new_y)
  end

	def obstructed_horizontally?(x, y)
		path = moving_direction(x, y)
		#path is horizontal from left to right
		if path == 'horizontal' && x_cord < x
			(x_cord + 1).upto(x - 1) do |changing_x|
				return true if occupied?(changing_x, y_cord)
			end
		#path is horizontal from right to left
		elsif path == 'horizontal' && x_cord > x
			(x_cord - 1).downto(x + 1) do |changing_x|
				return true if occupied?(changing_x, y_cord)
			end
		end
		false
	end

	def obstructed_vertically?(x,y)
		path = moving_direction(x, y)
		#path is vertical from down to up
		if path == 'vertical' && y_cord < y
			(y_cord + 1).upto(y - 1) do |changing_y|
				return true if occupied?(x_cord, changing_y)
			end
		#path is vertical from up to down
		elsif path == 'vertical' && y_cord > y
			(y_cord - 1).downto(y + 1) do |changing_y|
				return true if occupied?(x_cord, changing_y)
			end
		end
		false
	end

	def obstructed_digonally?(x,y)
		path = moving_direction(x, y)

		#path is diagonal from lower left to upper right
		if path = 'diagonal' && x_cord < x && y_cord < y
			(x_cord + 1).upto(x - 1) do |changing_x|
				(y_cord + 1).upto(y - 1) do |changing_y|
					return true if occupied?(changing_x, changing_y)
				end
			end
		#path is diagonal from lower right to upper left 
		elsif path = 'diagonal' && x_cord > x && y_cord < y
			(x_cord - 1).downto(x + 1) do |changing_x|
				(y_cord + 1).upto(y - 1) do |changing_y|
					return true if occupied?(changing_x, changing_y)
				end
			end
		#path is diagonal from upper left to lower right
		elsif path = 'diagonal' && x_cord < x && y_cord > y
			(x_cord + 1).upto(x - 1) do |changing_x|
				(y_cord - 1).downto(y + 1) do |changing_y|
					return true if occupied?(changing_x, changing_y)
				end
			end
		#path is diagonal from upper right to lower left
		elsif path = 'diagonal' && x_cord > x && y_cord > y
			(x_cord - 1).downto(x + 1) do |changing_x|
				(y_cord -1 ).downto(y + 1) do |changing_y|
					return true if occupied?(changing_x, changing_y)
				end
			end
		end
		false
	end


  def occupied?(x, y)
    game.pieces.where(x_cord: x, y_cord: y).present?
  end 

  def moving_direction(x, y)
    if y_cord == y
      return 'horizontal'
    elsif x_cord == x
      return 'vertical'
    elsif (y-y_cord).abs == (x-x_cord).abs
      return 'diagonal'
    end
    false
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
  end

  def own_piece?(piece)
    piece.color == color
  end

  def position_exist?(x, y)
    x >= 0 && x <= 7 && y >= 0 && y <= 7
  end
end
