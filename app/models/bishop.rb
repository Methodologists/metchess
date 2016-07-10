class Bishop < Piece

	def valid_move?(new_x, new_y)
		position_exist?(new_x, new_y) && bishop_allowed_moves?(new_x, new_y) && (!(diagonally_obstructed?(new_x, new_y)))		
	end


	def bishop_allowed_moves?(new_x, new_y)
		if (new_x - x_cord).abs == (new_y - y_cord).abs
			return true
	end

	def diagonally_obstructed?(new_x,new_y)
		#needs to break is_obstructed method to diagonally_obstructed?(x,y), horizontally_obstructed?(x,y), and vertically_obstructed?(x,y)
	end



  def image
    if color == "white"
      "\u2657"
    else
      "\u265D"
    end
  end


end
