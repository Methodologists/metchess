class User < ActiveRecord::Base
<<<<<<< HEAD
  has_many :games
  has_many :pieces
=======
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
>>>>>>> master
end
