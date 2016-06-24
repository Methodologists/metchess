class Piece < ActiveRecord::Base
  belongs_to :users
  belongs_to :games


  def move_to!
    #capture!
    #move to capture_location
  end

  def capture!
    #if capture_color?
    #then remove_captured_piece
  end

  def capture_location
    #position of piece being captured --
    #piece.find x & y cords -- return this into 2 variables x, y
  end

  def capture_color?
    #capture_location -- piece's color
    #if capture piece color == current piece color, return false; else return true
  end

  def remove_captured_piece
    #set coord to nil? -- what other ways can we go about "deleting" the piece from the board
  end







end
