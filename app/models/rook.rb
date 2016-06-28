class Rook < Piece

  def image
    if color == "white"
      "\u2656"
    else
      "\u265C"
    end
  end


end
