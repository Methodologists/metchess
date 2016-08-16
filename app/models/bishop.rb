class Bishop < Piece

	def valid_move?(new_x, new_y)
		allowed_move?(new_x, new_y) && passes_bishop_rules?(new_x, new_y) && !is_obstructed?(new_x, new_y)
	end

	def passes_bishop_rules?(new_x, new_y)
		(new_x - x_cord).abs == (new_y - y_cord).abs
	end

  def image
    if color == "white"
      "\u2657"
    else
      "\u265D"
    end
  end


end
