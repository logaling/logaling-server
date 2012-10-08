#coding: utf-8
module AdditionalInformationAsSearchResults
  attr_accessor :glossary_name
  attr_accessor :source_language
  attr_accessor :target_language
  attr_accessor :snipped_source_term

  def github_project?
    glossary_name =~ /^github/
  end

  def user_glossary?
    user_id = split_glossary_name_to_user_id_and_name[0]
    user_id =~ /\d{5}/
  end

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
  alias_method :glossary_name_without_github, :glossary_name_without_user_id

  def decorated_glossary_name
    if github_project?
      owner_name, project_name = glossary_name_without_github.split(":", 2)
      "#{owner_name}-#{project_name}"
    elsif user_glossary?
      user_id, glossary_name = split_glossary_name_to_user_id_and_name
      name = User.where(id: user_id.to_i).first.name
      "#{name}-#{glossary_name}"
    else
      glossary_name
    end
  end
end
