class Queen < Piece

  def image
    if color == "white"
      "\u2655"
    else
      "\u265B"
    end
  end

end
