class RoleplaysChannel < ApplicationCable::Channel
  def subscribed
    stream_from "roleplays_#{params['roleplay_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    Character.find(data['character_id']).messages.create!(body: data['message'], roleplay_id: data['roleplay_id'])
  end
end