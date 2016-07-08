class Bishop < Piece

	def no_move?(x,y)
		(x == x_cord) && (y == y_cord) ? true : false
	end

	def off_board?(x,y)
		(x > 8 || y > 8 || x < 1 || y < 1) ? true : false
	end

	def bishop_move (x,y)
		(x - x_cord).abs == (y - y_cord).abs
		#if obstructed diagonally
		return false if no_move(x,y)
		return false if off_board(x,y)
	end

  def image
    if color == "white"
      "\u2657"
    else
      "\u265D"
    end
  end


end
