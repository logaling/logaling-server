class UserConfig < ActiveRecord::Base
  attr_accessible :glossary_name, :source_language, :target_language, :user_id

  validates_presence_of :glossary_name, :source_language, :target_language, :user_id

  belongs_to :user

  def same?(glossary)
    if glossary.respond_to?(:glossary_name)
      glossary_name == glossary.glossary_name &&
      source_language == glossary.source_language &&
      target_language == glossary.target_language
    else
      glossary_name == glossary.name &&
      source_language == glossary.source_language &&
      target_language == glossary.target_language
    end
  end

  def glossary
    LogalingServer.repository.find_glossary(glossary_name, source_language, target_language)
  end
end
