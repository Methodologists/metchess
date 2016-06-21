class Game < ActiveRecord::Base
  belongs_to :users
  has_many :pieces
  after_create initialize_board!

  def initialize_board!
    #white pieces
    7.times do |n|
        Pawn.create(
            piece_id: id,
            color: true,
            y_cord: 1,
            x_cord: n,
            type: pawn
            )
    end

    Rook.create(piece_id: id, color: true, y_cord: 0, x_cord: 0, type: rook)
    Rook.create(piece_id: id, color: true, y_cord: 0, x_cord: 7, type: rook)

    Knight.create(piece_id: id, color: true, y_cord: 0, x_cord: 1, type: knight)
    Knight.create(piece_id: id, color: true, y_cord: 0, x_cord: 6, type: knight)

    Bishop.create(piece_id: id, color: true, y_cord: 0, x_cord: 2, type: bishop)
    Bishop.create(piece_id: id, color: true, y_cord: 0, x_cord: 5, type: bishop)

    Queen.create(piece_id: id, color: true, y_cord: 0, x_cord: 3, type: queen)
    King.create(piece_id: id, color: true, y_cord: 0, x_cord: 4, type: king)

    #black pieces
    7.times do |n|
        Pawn.create(
            piece_id: id,
            color: false,
            y_cord: 6,
            x_cord: n,
            type: pawn
            )
    end

    Rook.create(piece_id: id, color: false, y_cord: 7, x_cord: 0, type: rook)
    Rook.create(piece_id: id, color: false, y_cord: 7, x_cord: 7, type: rook)

    Knight.create(piece_id: id, color: false, y_cord: 7, x_cord: 1, type: knight)
    Knight.create(piece_id: id, color: false, y_cord: 7, x_cord: 6, type: knight)

    Bishop.create(piece_id: id, color: false, y_cord: 7, x_cord: 2, type: bishop)
    Bishop.create(piece_id: id, color: false, y_cord: 7, x_cord: 5, type: bishop)

    Queen.create(piece_id: id, color: false, y_cord: 7, x_cord: 3, type: queen)
    King.create(piece_id: id, color: false, y_cord: 7, x_cord: 4, type: queen)
  end
end
