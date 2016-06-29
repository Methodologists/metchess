class Piece < ActiveRecord::Base
  belongs_to :game

  def is_obstructed?
    return false
  end

end
