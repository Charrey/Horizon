class MessagesController < ApplicationController
  before_action :authenticate_user!
  def save_message
    Message.save_message(params)
  end


end
