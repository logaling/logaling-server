class AddDescriptionToUserGlossary < ActiveRecord::Migration
  def change
    add_column :user_glossaries, :description, :string
  end
end
