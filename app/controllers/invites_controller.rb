class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_filter :get_game

  def new
    @invite = Invite.new
  end

  def create
    @game = Game.find(params[:game_id])
    @invite = @game.invites.create(invite_params.merge(sender_id: current_user.id))
    #@invite.sender_id = current_user.id
    #InviteMailer.invite_sent(self).deliver
    redirect_to game_path(@game)
  end

  def show
    current_invite

  end

  def edit
    current_invite
  end

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy
    redirect_to user_path(current_user)
  end

  def accept_invite
    @invite = Invite.find(params[:id])
    #redirect to game

  end


  helper_method :current_invite
  def current_invite
    @invite = @game.invites.last
  end
  

  private

  def invite_params
    params.require(:invite).permit(:email, :sender_id, :recipient_id)
  end

  def get_game
    @game = Game.find(params[:game_id])
  end

end
