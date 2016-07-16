class Game < ActiveRecord::Base
  belongs_to :white_player, class_name: "User", foreign_key: "player_white_id"
  belongs_to :black_player, class_name: "User", foreign_key: "player_black_id"
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
        Pawn.create(
            game_id: id, 
            color: 'white', 
            x_cord: n,
            y_cord: 1
            )
    end
    #
    8.times do |n|
        Pawn.create(
            game_id: id, 
            color: 'black', 
            x_cord: n,
            y_cord: 6
            )
    end
  end

  def make_rooks!
    Rook.create(game_id: id, color: 'white', x_cord: 0, y_cord: 0)
    Rook.create(game_id: id, color: 'white', x_cord: 7, y_cord: 0)
    Rook.create(game_id: id, color: 'black', x_cord: 0, y_cord: 7)
    Rook.create(game_id: id, color: 'black', x_cord: 7, y_cord: 7)
  end

  def make_knights!
    Knight.create(game_id: id, color: 'white', x_cord: 1, y_cord: 0)
    Knight.create(game_id: id, color: 'white', x_cord: 6, y_cord: 0)
    Knight.create(game_id: id, color: 'black', x_cord: 6, y_cord: 7)
    Knight.create(game_id: id, color: 'black', x_cord: 1, y_cord: 7)
  end

  def make_bishops!
    Bishop.create(game_id: id, color: 'white', x_cord: 2, y_cord: 0)
    Bishop.create(game_id: id, color: 'white', x_cord: 5, y_cord: 0)
    Bishop.create(game_id: id, color: 'black', x_cord: 5, y_cord: 7)
    Bishop.create(game_id: id, color: 'black', x_cord: 2, y_cord: 7)
  end

  def make_kings!
    King.create(game_id: id, color: 'white', x_cord: 4, y_cord: 0)
    King.create(game_id: id, color: 'black', x_cord: 4, y_cord: 7)
  end

  def make_queens!
    Queen.create(game_id: id, color: 'white', x_cord: 3, y_cord: 0)
    Queen.create(game_id: id, color: 'black', x_cord: 3, y_cord: 7)
  end

  def check?
    kings = King.where(game_id: id)
    kings.each do |king|
      pieces.each do |piece|
        return true if piece.color != king.color && piece.valid_move?(king.x_cord, king.y_cord)
      end
    end

    return false
  end
end
