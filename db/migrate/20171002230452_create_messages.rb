class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :character, foreign_key: true
      t.references :roleplay,  foreign_key: true
      t.timestamps
    end
  end
end
