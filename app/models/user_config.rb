class UserConfig < ActiveRecord::Base
  attr_accessible :glossary_name, :source_language, :target_language, :user_id

  validates_presence_of :glossary_name, :source_language, :target_language, :user_id

  belongs_to :user

  def set_config(params)
    self.user_id ||= params[:user_id]
    self.glossary_name, self.source_language, self.target_language = id_to_config(params[:id])
  end

  def same?(user_glossary)
    glossary_name == user_glossary.glossary_name &&
    source_language == user_glossary.source_language &&
    target_language == user_glossary.target_language
  end

  private
  def id_to_config(id)
    id.split(".", 3)
  end
end
