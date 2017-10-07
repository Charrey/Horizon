class AddAttachmentImageToCharacters < ActiveRecord::Migration[5.1]
  def self.up
    change_table :characters do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :characters, :image
  end
end
