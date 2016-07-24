class InvitesController < ApplicationController
  before_filter :get_game

  def new
    @invite = Invite.new
  end

  def create
    @invite = @game.invites.create(invite_params)
    @invite.sender_id = current_user.id
    #mailer action?
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
    if @invite.destroy
      redirect_to user_path(current_user)
      #message
    else
      redirect_to user_path(current_user)
      #message flash
    end
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
