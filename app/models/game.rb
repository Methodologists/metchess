class Game < ActiveRecord::Base
  belongs_to :white_player, class_name: "User", foreign_key: "player_white_id"
  belongs_to :black_player, class_name: "User", foreign_key: "player_black_id"
  has_many :pieces
  
  after_create :initialize_board!
  after_create :set_first_turn!
  
  
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
        Pawn.create(game_id: id, color: 'white', x_cord: n, y_cord: 1)
    end
    
    8.times do |n|
        Pawn.create(game_id: id, color: 'black', x_cord: n, y_cord: 6)
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

  #game states
  def pending_opponent?
    player_black_id.blank?
  end

  def ready_to_play?
    player_white_id.present? && player_black_id.present?
  end

  #turn states
  def set_first_turn!
    update_attributes(current_turn: "white")
  end

  def next_turn!
    if self.current_turn == "white"
      self.update_attributes(current_turn: "black")
    elsif self.current_turn == "black"
      self.update_attributes(current_turn: "white")
    end
  end

#end game check and checkmate
  def check?
    kings = King.where(game_id: id)
    kings.each do |king|
      pieces.each do |piece|
        return true if piece.color != king.color && piece.valid_move?(king.x_cord, king.y_cord)
      end
    end
    false
  end

  def checkmate?
    return false unless check?
    return false if capture_by_other_piece?
    return false if move_out_of_check?
    #return false if obstruct_out_of_check?
    true
  end

  def move_out_of_check?
    king_in_check = King.find_by(game_id: self.id, color: self.current_turn)
    king_allowed_moves = 
    [ [king_in_check.x_cord, (king_in_check.y_cord + 1)],
      [king_in_check.x_cord, (king_in_check.y_cord - 1)],
      [(king_in_check.x_cord + 1), (king_in_check.y_cord + 1)],
      [(king_in_check.x_cord + 1), king_in_check.y_cord],
      [(king_in_check.x_cord + 1), (king_in_check.y_cord - 1)],
      [(king_in_check.x_cord - 1), (king_in_check.y_cord + 1)],
      [(king_in_check.x_cord - 1), king_in_check.y_cord],
      [(king_in_check.x_cord - 1), (king_in_check.y_cord - 1)]
      ]

    king_allowed_moves.each do |coord|
      puts coord.first
      puts coord.last
      puts " "
      puts "#{king_in_check.x_cord}, #{king_in_check.y_cord}"
      puts " "
      return true if king_in_check.valid_move?(coord.first, coord.last)
    end
    false
  end

  def obstruct_out_of_check? #checks if there's any piece that can obstruct the path of the piece putting in check
    obstructable_positions = []
    king_in_check = King.find_by(game_id: id, color: current_turn)
    check_piece = []
    Piece.where(game_id: id).where.not(color: current_turn).each do |piece|
      check_piece = piece if piece.valid_move?(king_in_check.x_cord, king_in_check.y_cord)
    end

    if check_piece
      if king_in_check.y_cord == check_piece.y_cord && king_in_check.x_cord > check_piece.x_cord
        (check_piece.x_cord + 1).upto(king_in_check.x_cord - 1) do |x|
          obstructable_positions << [x, king_in_check.y_cord]
        end
      elsif king_in_check.y_cord == check_piece.y_cord && king_in_check.x_cord < check_piece.x_cord
        (king_in_check.x_cord + 1).upto(check_piece.x_cord - 1) do |x|
          obstructable_positions << [x, king_in_check.y_cord]
        end
      elsif king_in_check.x_cord == check_piece.x_cord && king_in_check.y_cord > check_piece.y_cord
        (check_piece.y_cord + 1).upto(king_in_check.y_cord - 1) do |y|
          obstructable_positions << [king_in_check.x_cord, y]
        end
      elsif king_in_check.x_cord == check_piece.x_cord && king_in_check.y_cord < check_piece.y_cord
        (king_in_check.y_cord + 1).upto(check_piece.y_cord - 1) do |y|
          obstructable_positions << [king_in_check.x_cord, y]
        end
      #diagonally upper right  
      elsif (king_in_check.x_cord > check_piece.x_cord) && (king_in_check.y_cord > check_piece.y_cord)
        (check_piece.x_cord + 1).upto(king_in_check.x_cord - 1) do |x|
          (check_piece.y_cord + 1).upto(king_in_check.y_cord - 1) do |y|
            obstructable_positions << [x, y] if (x - check_piece.x_cord).abs == (y - check_piece.y_cord).abs
          end
        end
      #diagonally upper left
      elsif (king_in_check.x_cord < check_piece.x_cord) && (king_in_check.y_cord > check_piece.y_cord)
        (king_in_check.x_cord + 1).upto(check_piece.x_cord - 1) do |x|
          (check_piece.y_cord + 1).upto(king_in_check.y_cord - 1) do |y|
            obstructable_positions << [x, y] if (x - king_in_check.x_cord).abs == (y - check_piece.y_cord).abs
          end
        end
      #diagonally lower left
      elsif (king_in_check.x_cord < check_piece.x_cord) && (king_in_check.y_cord < check_piece.y_cord)
        (king_in_check.x_cord + 1).upto(check_piece.x_cord - 1) do |x|
          (king_in_check.y_cord + 1).upto(check_piece.y_cord - 1) do |y|
            obstructable_positions << [x, y] if (x - king_in_check.x_cord).abs == (y - king_in_check.y_cord).abs
          end
        end
      #diagonally lower right
      elsif (king_in_check.x_cord > check_piece.x_cord) && (king_in_check.y_cord < check_piece.y_cord)
        (check_piece.x_cord + 1).upto(king_in_check.x_cord - 1) do |x|
          (king_in_check.y_cord + 1).upto(check_piece.y_cord - 1) do |y|
            obstructable_positions << [x, y] if (x - check_piece.x_cord).abs == (y - check_piece.y_cord).abs
          end
        end
      end

      friendly_pieces = Piece.where(game_id: id, color: current_turn)
      friendly_pieces.each do |piece|
        obstructable_positions.each do |position|
          return true if piece.valid_move?(position[0], position[1])
        end
      end
    end

    false
  end

  def capture_by_other_piece?
    check_piece = []
    king_in_check = King.find_by(game_id: self.id, color: self.current_turn)
    Piece.where(game_id: self.id).where.not(color: self.current_turn).each do |piece|
      check_piece = piece if piece.valid_move?(king_in_check.x_cord, king_in_check.y_cord)
    end

    if check_piece
      Piece.where(game_id: id, color: current_turn).each do |piece|
        return true if piece.valid_move?(check_piece.x_cord, check_piece.y_cord)
      end
    end

    false
  end

  # def check_piece
  #   king_in_check = King.find_by(game_id: id, color: current_turn)
  #   check_piece = []
  #   Piece.where(game_id: id).where.not(color: current_turn).each do |piece|
  #     check_piece << piece.valid_move?(king_in_check.x_cord, king_in_check.y_cord)
  #   end
  # end
end
