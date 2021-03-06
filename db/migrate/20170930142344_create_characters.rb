class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :description
      t.boolean :is_narrator, default: :false
      t.references :user, foreign_key: true
      t.references :roleplay, foreign_key: true
      t.timestamps
    end
  end
end
