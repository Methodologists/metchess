class InviteMailer < ActionMailer::Base
  default from: "no-reply@mchessapp.com"

  def invite_sent
    mail(to: "lindyrp@gmail.com",
      subject: "You've been invited to play mChess")
  end
end
