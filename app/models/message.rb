class Message < ApplicationRecord
  belongs_to :character
  belongs_to :roleplay

  after_create_commit { MessageBroadcastJob.perform_later(self) }
  validates :body, presence: true, length: {minimum: 2, maximum: 1000}

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end

  def self.save_message(params)
    @character_id = params[:character_id]
    @roleplay_id = params[:roleplay_id]
    @body = params[:body]
    puts "save_message!!!!"
    Message.create(character_id: @character_id, roleplay_id: @roleplay_id, body: @body)
  end

  def self.makeGhostMessages(messages)
    ghost_messages = []
    messages.each do |message|
      if ghost_messages.empty?
        ghost_messages.append(message)
      elsif ghost_messages.last.character == message.character
        ghost_messages.last.body = ghost_messages.last.body + '<br>' + message.body
      else
        ghost_messages.append(message)
      end
    end
    ghost_messages
  end

end
