class Piece < ActiveRecord::Base
  belongs_to :users
  belongs_to :games

  def self.types
    %w(Pawn Bishop Knight Rook Queen King)
  end
end
