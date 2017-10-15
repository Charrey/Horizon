class Character < ApplicationRecord
  belongs_to :user
  belongs_to :roleplay
  has_many :messages

  has_attached_file :image,
                    styles: { medium: '300x300!', thumb: '100x100!' },
                    default_url: '/images/:style/missing_user.jpg'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  def self.sorter(a, b, user)
    if a.is_narrator != b.is_narrator
      return b.is_narrator ? 1 : -1
    end
    if (a.user == user) != (b.user == user)
      return b.user == user ? 1 : -1
    end
    return b.updated_at <=> a.updated_at
  end

end
