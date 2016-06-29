class Bishop < Piece

  def image
    if color == "white"
      "\u2657"
    else
      "\u265D"
    end
  end


end
