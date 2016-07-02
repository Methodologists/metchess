class Piece < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def is_obstructed?(x, y)

    #check moving direction
    path = moving_direction(x, y)

    #path is diagonal from lower left to upper right
    if path = 'diagonal' && x_cord < x && y_cord < y
      (x_cord + 1).upto(x - 1) do |changing_x|
        (y_cord + 1).upto(y - 1) do |changing_y|
          return true if occupied?(changing_x, changing_y)
        end
      end
    end

    #path is diagonal from lower right to upper left 
    if path = 'diagonal' && x_cord > x && y_cord < y
      (x_cord - 1).downto(x + 1) do |changing_x|
        (y_cord + 1).upto(y - 1) do |changing_y|
          return true if occupied?(changing_x, changing_y)
        end
      end
    end

    #path is diagonal from upper left to lower right
    if path = 'diagonal' && x_cord < x && y_cord > y
      (x_cord + 1).upto(x - 1) do |changing_x|
        (y_cord - 1).downto(y + 1) do |changing_y|
          return true if occupied?(changing_x, changing_y)
        end
      end
    end

    #path is diagonal from upper right to lower left
    if path = 'diagonal' && x_cord > x && y_cord > y
      (x_cord - 1).downto(x + 1) do |changing_x|
        (y_cord -1 ).downto(y + 1) do |changing_y|
          return true if occupied?(changing_x, changing_y)
        end
      end
    end


    #path is horizontal from left to right
    if path == 'horizontal' && x_cord < x
      (x_cord + 1).upto(x - 1) do |changing_x|
        return true if occupied?(changing_x, y_cord)
      end
    end


    #path is horizontal from right to left
    if path == 'horizontal' && x_cord > x
      (x_cord - 1).downto(x + 1) do |changing_x|
        return true if occupied?(changing_x, y_cord)
      end
    end


    #path is vertical from down to up
    if path == 'vertical' && y_cord < y
      (y_cord + 1).upto(y - 1) do |changing_y|
        return true if occupied?(x_cord, changing_y)
      end
    end

    #path is vertical from up to down
    if path == 'vertical' && y_cord > y
      (y_cord - 1).downto(y + 1) do |changing_y|
        return true if occupied?(x_cord, changing_y)
      end
    end



    #path does not exist
    if path == 'error'
       alert("you have to make a legal move first.");
    end

    #path is neither diagonal, vertical, nor horizontal
    if path == 'neither'
      alert("your move is not legal.");
    end

    return false

  end

  def occupied?(x, y)
    game.pieces.where(x_cord: x, y_cord: y).present?
  end 

  def moving_direction(x, y)

    if y_cord == y && x_cord == x
      return 'error'
    elsif y_cord == y
      return 'horizontal'
    elsif x_cord == x
      return 'vertical'
    elsif (y-y_cord).abs == (x-x_cord).abs
      return 'diagonal'
    else
      return 'neither'
    end
  end

# Moving piece to new location & Captures piece if valid
  def move_to!(new_x, new_y)
    piece_to_capture = Piece.find_by(x_cord: new_x, y_cord: new_y)

    # nothing happens if there is a piece in new location & is our own_piece
    return if piece_to_capture && own_piece?(piece_to_capture)

    # if the rest of this method is executed, either
    #   * piece_to_capture is nil
    #   * piece_to_capture is opposite color

    piece_to_capture.update(x_cord: nil, y_cord: nil) if piece_to_capture
    self.update(x_cord: new_x, y_cord: new_y)
  end

  def own_piece?(piece)
    piece.color == self.color
  end


end
