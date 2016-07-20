class Invite < ActiveRecord::Base
  belongs_to :game
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  before_create :generate_token


  def generate_token
    self.token = Digest::SHA1.hexdigest([self.game_id, Time.now, rand].join)
  end
end
