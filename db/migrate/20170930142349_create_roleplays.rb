class CreateRoleplays < ActiveRecord::Migration[5.1]
  def change
    create_table :roleplays do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.boolean :online, default: :false
      t.boolean :disable_images, default: :false
      t.timestamps
    end
  end
end
