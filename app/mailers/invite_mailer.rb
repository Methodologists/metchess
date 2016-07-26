class InviteMailer < ActionMailer::Base
  default from: "no-reply@mchessapp.com"

  def invite_sent(invite)
    @game = invite.game
    
    
    @recipient = invite.recipient
    @sender = invite.sender
    
    mail(to: @recipient.email,
      subject: "You've been invited to play mChess with #{@sender.email}")
  end


end
