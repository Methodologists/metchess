class Piece < ActiveRecord::Base
  belongs_to :users
  belongs_to :games

	def is_obstructed?(x, y)

		#check moving direction
		path = moving_direction(x, y)

		#path is horizontal from left to right
		if path == 'horizontal' && x_cord < x
			(x_cord + 1).upto(x - 1) do |changing_x|
				return true if occupied?(changing_x, y_cord)
			end
		end


		#path is horizontal from right to left
		if path == 'horizontal' && x_cord > x


		#path is vertical
		if path == 'vertical'
			(y_cord + 1).upto(y -1) do |changing_y|
				return true if occupied?(x_cord, changing_y)
			end
		end

		#path is diagonal 
		if (y-y_cord).abs == (x-x_cord).abs
			(x_cord + 1).upto(x - 1) do |changing_x|
				(y_cord + 1).upto (y - 1) do |changing_y|
					return true if occupied?(changing_x, changing_y)
				end
			end
		end

		return false

	end


	def occupied?(x, y)
		game.pieces.where(x_cord: x, y_cord: y).present?
	end	


	def moving_direction(x, y)

		if y_cord== y
			return 'horizontal'
		elsif x_cord == x
			return 'vertical'
		else
			return 'diagonal'
		end
	end

end
