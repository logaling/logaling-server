class CreateUserGlossaries < ActiveRecord::Migration
  def change
    create_table :user_glossaries do |t|
      t.references :user, :null => false
      t.string :name, :null => false
      t.string :source_language, :null => false
      t.string :target_language, :null => false

      t.timestamps
    end
    add_index :user_glossaries, :user_id
  end
end
