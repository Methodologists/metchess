class User < ActiveRecord::Base
  has_many :games
  has_many :pieces ## QUESTION: isn't this redundant? 
  #isn't this covered as pieces -> belongs to game -> belongs to user?

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
