class Game < ActiveRecord::Base
  belongs_to :users
  has_many :pieces
end
