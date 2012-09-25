class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user, null: false
      t.belongs_to :github_project, null: false

      t.timestamps
    end
    add_index :memberships, :user_id
    add_index :memberships, :github_project_id
  end
end
