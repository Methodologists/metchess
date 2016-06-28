class King < Piece

  def image
    if color == "white"
      "\u2654"
    else
      "\u265A"
    end
  end


end
