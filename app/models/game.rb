class Game < ActiveRecord::Base
  belongs_to :users
  has_many :pieces
  after_create :initialize_board!

  def initialize_board!
    make_pawns!
    make_rooks!
    make_bishops!
    make_knights!
    make_kings!
    make_queens!
  end

  def make_pawns!
    8.times do |n|
        pieces << Pawn.create(
            color: 'white', 
            x_cord: n,
            y_cord: 1
            )
    end
    #
    8.times do |n|
        pieces << Pawn.create(
            color: 'black', 
            x_cord: n,
            y_cord: 6
            )
    end
  end

  def make_rooks!
    pieces << Rook.create(color: 'white', x_cord: 0, y_cord: 0)
    pieces << Rook.create(color: 'white', x_cord: 7, y_cord: 0)
    pieces << Rook.create(color: 'black', x_cord: 0, y_cord: 7)
    pieces << Rook.create(color: 'black', x_cord: 7, y_cord: 7)
  end

  def make_knights!
    pieces << Knight.create(color: 'white', x_cord: 1, y_cord: 0)
    pieces << Knight.create(color: 'white', x_cord: 6, y_cord: 0)
    pieces << Knight.create(color: 'black', x_cord: 6, y_cord: 7)
    pieces << Knight.create(color: 'black', x_cord: 1, y_cord: 7)
  end

  def make_bishops!
    pieces << Bishop.create(color: 'white', x_cord: 2, y_cord: 0)
    pieces << Bishop.create(color: 'white', x_cord: 5, y_cord: 0)
    pieces << Bishop.create(color: 'black', x_cord: 5, y_cord: 7)
    pieces << Bishop.create(color: 'black', x_cord: 2, y_cord: 7)
  end

  def make_kings!
    pieces << King.create(color: 'white', x_cord: 4, y_cord: 0)
    pieces << King.create(color: 'black', x_cord: 4, y_cord: 7)
  end

  def make_queens!
    pieces << Queen.create(color: 'white', x_cord: 3, y_cord: 0)
    pieces << Queen.create(color: 'black', x_cord: 3, y_cord: 7)
  end
end
