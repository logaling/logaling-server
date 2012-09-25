class AddReferenceToUserConfig < ActiveRecord::Migration
  def change
    add_column :user_configs, :user_id, :integer
    add_index :user_configs, :user_id
  end
end
