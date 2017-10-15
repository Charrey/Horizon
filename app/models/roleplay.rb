class Roleplay < ApplicationRecord
  belongs_to :user
  has_attached_file :image,
                    styles: { medium: '300x300!', thumb: '100x100!' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :characters, dependent: :destroy
  has_many :messages

  def participants
    participants = Set.new
    roleplay = Roleplay.includes(characters: [:user]).find(id)
    roleplay.characters.each do |character|
      participants.add(character.user)
    end
    participants.to_a
  end

  def createNarrator(roleplay)
    narrator = Character.new
    narrator.roleplay = roleplay
    narrator.description = 'Narrator for roleplay "' + roleplay.name + '".'
    narrator.name = 'Narrator'
    narrator.image = File.new(File.join(Rails.root, "/app/assets/images/narrator.png"))
    narrator.is_narrator = true
    narrator.user = roleplay.user
    narrator.save!
  end

  def self.sorter(a, b)
    if b.user == current_user
      return 1 unless a.user == current_user
    end
    if a.user == current_user
      return -1 unless b.user == current_user
    end
    if a.online != b.online
      return b.online ? 1 : -1
    end
    a.name <=> b.name
  end

  def sortedcharacters(user)
    temp_characters = characters.clone().to_a
    temp_characters.sort! do |x,y|
      Character.sorter(x,y, user)
    end
    temp_characters
  end
end
