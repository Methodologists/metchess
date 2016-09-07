class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end 

  def create
    recipients = User.where(id: params['recipients'])
    recipients.each do |recipient|
      conversation = current_user.send_message(recipient, params[:message][:body], params[:message][:subject]).conversation
    end
    flash[:success] = "Message has been sent!"
    redirect_to conversations_path
  end
end
