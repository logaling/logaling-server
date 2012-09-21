class UserConfig < ActiveRecord::Base
  attr_accessible :glossary, :source_language, :target_language, :user_id

  validates_presence_of :glossary, :source_language, :target_language, :user_id

  belongs_to :user

  def set_config(params)
    self.user_id ||= params[:user_id]
    self.glossary, self.source_language, self.target_language = id_to_config(params[:id])
  end

  private
  def id_to_config(id)
    id.split(".", 3)
  end
end
