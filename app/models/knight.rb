class Knight < Piece

  def image
    if color == "white"
      "\u2658"
    else
      "\u265E"
    end
  end


end
