class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def is_obstructed?
    return false
  end

#Capture Pieces Methods - Validates if the other piece is valid to capture, moves current piece to new location

  def move_to!(new_x, new_y)
    remove_captured_piece!(new_x, new_y)
    update_coordinates!(new_x, new_y)
  end

  def remove_captured_piece!(x,y)
    #sets the coordinates of the piece being captured to nil
    captured_piece = Piece.find(x_cord: x, y_cord: y)
    captured_piece.x_cord = nil
    captured_piece.y_cord = nil
  end

  def update_coordinates!(x, y)
    #updates the coordinates of the capturing piece's coordinates
    x_cord = x
    y_cord = y
  end

end
