class Pawn < Piece

  def image
    if color == "white"
      "\u2659"
    else
      "\u265F"
    end
  end

end
