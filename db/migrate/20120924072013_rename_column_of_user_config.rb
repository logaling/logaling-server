class RenameColumnOfUserConfig < ActiveRecord::Migration
  def up
    rename_column :user_configs, :glossary, :glossary_name
  end

  def down
    rename_column :user_configs, :glossary_name, :glossary
  end
end
