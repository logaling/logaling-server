class CreateGithubProjects < ActiveRecord::Migration
  def change
    create_table :github_projects do |t|
      t.string :owner
      t.string :name

      t.timestamps
    end
  end
end
