class Piece < ActiveRecord::Base
  belongs_to :game

  def move_piece(new_x, new_y)
    # Add logic to check for validity
    update_attributes(x_cord: new_x, y_cord: new_y)
  end

  def is_obstructed?
    return false
  end

end
