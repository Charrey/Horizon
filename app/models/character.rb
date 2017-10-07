class Character < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :roleplay
  has_many :messages, dependent: :destroy

  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing_user.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
