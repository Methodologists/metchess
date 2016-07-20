class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :games
  has_many :invitations, class_name: "Invite", foreign_key: "recipient_id"
  has_many :sent_invites, class_name: "Invite", foreign_key: "sender_id"

  belongs_to :black_player, class_name: "User", foreign_key: "player_black_id"
  
end
