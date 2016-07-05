class Pawn < Piece

  def valid_move?(new_x, new_y)
    on_board?(new_x, new_y) && passes_pawn_rules?(new_x, new_y)
  end

  #we need to create a method that makes sure the pawn moves according to its rules
  def passes_pawn_rules?(x, y)

  end

  #we need to create a method that makes sure the pawn is moving into a position that exists
  def on_board?(x, y)
    x >= 0 && x <= 7 && y >=0 && y <= 7
  end

  #we need to check if its the first move for the pawn
  def first_move_position?
    self.y_cord == 1
  end

  #we need to check whether or not a diagonal move is allowed
  #this will be incorporated into passes_pawn_rules? method

  def diagonal_allowed?

  end

  #diagonal_allowed? should also check the color of opposition's piece color, if the piece color
  #is the opposite color then return false

  def same_color?(x, y)

  end

  def two_jumps_allowed?(x, y)

  end

  #should create a separate method that checks that pawn moves 

  def image
    if color == "white"
      "\u2659"
    else
      "\u265F"
    end
  end

end
