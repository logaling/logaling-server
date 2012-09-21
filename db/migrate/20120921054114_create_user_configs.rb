class CreateUserConfigs < ActiveRecord::Migration
  def change
    create_table :user_configs do |t|
      t.string :glossary
      t.string :source_language
      t.string :target_language
      t.timestamps
    end
  end
end
