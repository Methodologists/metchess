class Piece < ActiveRecord::Base
  belongs_to :users
  belongs_to :games

def is_obstructed?
  return false
end

end
