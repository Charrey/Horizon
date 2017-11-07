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

  def self.last_message_id(roleplay_id)
    @id = ""
    @messages = Message.where(:roleplay_id => roleplay_id).order('created_at desc')
    if @messages.size > 0 then
      @id = @messages.first.id.to_s
    end

    return @id
  end

end
