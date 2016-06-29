class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def is_obstructed?
    return false
  end

#Capture Pieces Methods - Validates if the other piece is valid to capture, moves current piece to new location

  def move_to!(new_x, new_y)
    capture_piece = Piece.find_by(x_cord: new_x, y_cord: new_y)
    return if capture_piece && capture_piece.color == self.color

    # we know that if the rest of this method is executed, either
    #   * capture_piece is nil
    #   * capture_piece is opposite color
    capture_piece.update(x_cord: nil, y_cord: nil) if capture_piece
    self.update(x_cord: new_x, y_cord: new_y)
  end
end
