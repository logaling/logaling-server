#coding: utf-8
module AdditionalInformationAsSearchResults
  attr_accessor :glossary_name
  attr_accessor :source_language
  attr_accessor :target_language
  attr_accessor :snipped_source_term

  def split_glossary_name_to_user_id_and_name
    glossary_name.split("-", 2)
  end

  def owner?(user)
    owner_id = split_glossary_name_to_user_id_and_name[0]
    user.id == owner_id.to_i
  end

  def glossary_name_without_user_id
    split_glossary_name_to_user_id_and_name[1]
  end
end
