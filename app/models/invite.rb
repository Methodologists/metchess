class Invite < ActiveRecord::Base
  belongs_to :game
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  after_create :send_invite_email

  def send_invite_email
    InviteMailer.invite_sent(self).deliver
  end
end
