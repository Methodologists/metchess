class Bishop < Piece

	def valid_move?(new_x, new_y)
		position_exist?(new_x, new_y) && not_original_position?(new_x, new_y) && bishop_allowed_moves?(new_x, new_y)
	end

	def bishop_allowed_moves?(new_x, new_y)
		(new_x - x_cord).abs == (new_y - y_cord).abs
	end

  def not_original_position?(x, y)
    !(x_cord == x && y_cord == y)
  end

  def image
    if color == "white"
      "\u2657"
    else
      "\u265D"
    end
  end


end
