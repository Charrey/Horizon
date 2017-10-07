class AddAttachmentImageToRoleplays < ActiveRecord::Migration[5.1]
  def self.up
    change_table :roleplays do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :roleplays, :image
  end
end
