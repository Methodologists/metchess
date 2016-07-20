class InvitesController < ApplicationController


  def new
    @game = Game.find(params[:game_id])
    @invite = Invite.new
  end

  def create
    @game = Game.find(params[:game_id])
    @invite = @game.invites.create(invite_params)
    @invite.sender_id = current_user.id
    
  end


  private

  def invite_params
    params.require(:invite).permit(:email, :sender_id, :recipient_id)
  end
end
