class King < Piece
  def valid_move?(new_x, new_y)
    allowed_move?(new_x, new_y) && not_next_to_king?(new_x, new_y) && passes_king_rules?(new_x, new_y) &&
     not_check?(new_x, new_y)
  end

  def passes_king_rules?(new_x, new_y)
    (x_cord - new_x).abs <= 1 && (y_cord - new_y).abs <= 1
  end

  def not_check?(new_x, new_y)
    Piece.where(game_id: game_id).where.not(color: color).each do |piece|
      return false if piece.valid_move?(new_x, new_y)
    end

    return true
  end

  def not_next_to_king?(new_x, new_y)
    possible_king_positions = [[new_x, new_y + 1],[new_x + 1, new_y + 1],[new_x + 1, new_y],
    [new_x + 1, new_y - 1],[new_x, new_y - 1],[new_x - 1, new_y - 1],[new_x - 1, new_y],[new_x - 1, new_y + 1]]

    King.where(game_id: game_id).where.not(color: color).each do |king|
      possible_king_positions.each do |position|
        puts "opposite_king: #{king.x_cord}, #{king.y_cord}"
        puts "possible_current_king: #{position[0]}, #{position[1]}"
        puts "#{king.x_cord == position[0]}, #{(king.y_cord == position[1])}"
        return false if (king.y_cord == position[1]) && (king.x_cord == position[0])
      end
    end
    true
  end

# image for king
  def image
    if color == "white"
      "\u2654"
    else
      "\u265A"
    end
  end

end
